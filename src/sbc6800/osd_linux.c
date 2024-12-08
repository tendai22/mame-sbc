#include <stdio.h>
#include <termios.h>
#include <unistd.h>
//#include <sys/types.h>
#include <sys/time.h>
#include <time.h>
#include <inttypes.h>
#include "osd.h"

//
// serial device upper layer
//

// one byte read ahead and ungetc
// we compose PIR9 (uart creg) with g_input_device_ready 
// and g_output_device_ready
int		g_input_device_value = -1;
int		g_input_device_ready = 0;			/* Current status in input device */

int		g_output_device_data_ready = 0;		/* 1 if g_output_device_data is valid, to be sent */
int		g_output_device_data = 0xe5;		/* output data to be sent, 0xe5 has no means, magic number */
int		g_output_device_empty = 1;			/* 1 if output queue is empty, ready to be written to DREG */
time_t	g_output_device_last_output;		/* Time of last char output */
int     g_quit = 0;
int     g_nmi = 0;

#define ASCIIART

#ifdef ASCIIART
static int file_flag = 1;
static FILE *fp = NULL;
static const char *filename = "ASCIIART.BAS";
#endif

/* Implementation for the input device */
void input_device_reset(void)
{
	changemode(1);
	// I have tried (and failed) to flush pending input by doing
	//  while (kbhit())
	//     osd_get_char();
	// but it did not work. (One character remains in input buffer, 
	// by typing second char, it returns 1st char)
	// I don't know why it did not work, but I recognize omitting this code
	// make it works.
	setbuf(stdin, NULL);
	setbuf(stdout, NULL);
	//g_input_device_ready = 0;
	//int_controller_clear(IRQ_INPUT_DEVICE);

}

void reset_asciiart_input(void)
{
#ifdef ASCIIART
    // startup key-in from ASCIIART.BAS
    if ((fp = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "%s cannot open\n", filename);
    }
#endif
}

void input_device_restore(void)
{
	changemode(0);
}

void input_device_update(void)
{
	//if (g_input_device_ready) {
		//int_controller_set(IRQ_INPUT_DEVICE);
	//}
}

int input_device_ack(void)
{
	//return M68K_INT_ACK_AUTOVECTOR;
  return 0;
}

unsigned int input_device_status(void)
{
	unsigned char c = 0;
	if (g_input_device_ready)
		c |= 1;
	if (g_output_device_empty)
		c |= 2;
	return c;
}

unsigned int input_device_read(void)
{
	int value;
	//printf("[");
	value = g_input_device_value;
	// emulate uart_dreg is read.
	//int_controller_clear(IRQ_INPUT_DEVICE);
	g_input_device_ready = 0;
	//printf("%02X]", value);
	return value;
}

void input_device_write(unsigned int value)
{
	// do nothing
	(void)value;
}

//
// get_msec ... with clock_gettime, a new POSIC standard
//
long int get_msec(void)
{
	struct timespec ts;
	static unsigned long int start = 0, current;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	current = (unsigned long int)ts.tv_sec * 1000L + ts.tv_nsec / 1000000L;
    current *= 10;
	if (start == 0) {
		start = current;
	}
	return current - start;
}

/* Implementation for the output device */
void output_device_reset(void)
{
	g_output_device_last_output = get_msec();
	g_output_device_data_ready = 0;
	g_output_device_empty = 1;
	//int_controller_clear(IRQ_OUTPUT_DEVICE);
}

void output_device_update(void)
{
	if(g_output_device_empty)		// empty check if any data is pending
	{
		if (g_output_device_data_ready)	// there is a data to be sent in g_output_device_data
		{
			printf("%c", g_output_device_data);
			g_output_device_data_ready = 0;
			g_output_device_last_output = get_msec();
			g_output_device_empty = 0;
			//int_controller_clear(IRQ_OUTPUT_DEVICE);
		}
	} else {	// not empty, now a data is transmitting
		if((get_msec() - g_output_device_last_output) >= OUTPUT_DEVICE_PERIOD)
		{
			g_output_device_empty = 1;
			//int_controller_set(IRQ_OUTPUT_DEVICE);
		}
	}
}

int output_device_ack(void)
{
	//return M68K_INT_ACK_AUTOVECTOR;
  return 0;
}

unsigned int output_device_read(void)
{
	//int_controller_clear(IRQ_OUTPUT_DEVICE);
	return 0;
}

void output_device_write(unsigned int value)
{
	g_output_device_data_ready = 1;
	g_output_device_data = value & 0xff;
	if (g_output_device_empty)
	{
		// send it out to lower physical layer
		// it should be here also, so that short-time consequent output_device_write calling
		// should not overwritten the first output character.
		printf("%c", g_output_device_data);
		g_output_device_data_ready = 0;
		g_output_device_last_output = get_msec();
		g_output_device_empty = 0;
		//int_controller_clear(IRQ_OUTPUT_DEVICE);
	}
}

//
//
//
/* Parse user input and update any devices that need user input */
void update_user_input(void)
{
	static int last_ch = -1;
	int ch = 0;

	if (g_input_device_ready || !kbhit())
		return;
#if 0
	while (kbhit()) {
		ch = osd_get_char();
		//printf("=%02X=", ch&0xff);
    }
#endif
    ch = osd_get_char();

    switch(ch)
	{
	    case 0x1b:
			g_quit = 1;
			break;
#ifdef ASCIIART
        case 0x0f:
            reset_asciiart_input();
            break;
#endif
		case '~':
			if(last_ch != ch)
				g_nmi = 1;
			break;
		default:
			g_input_device_ready = 1;
			g_input_device_value = ch;
	}
	//printf("(%02X)", ch);
    last_ch = ch;
}

//
// Linux tty driver interface
//

void changemode(int dir)
{
  static struct termios oldt, newt;

  if ( dir == 1 )
  {
    tcgetattr( STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_iflag &= ~( IGNCR | ICRNL );
    newt.c_lflag &= ~( ICANON | ECHO );
    tcsetattr( STDIN_FILENO, TCSANOW, &newt);
  }
  else
    tcsetattr( STDIN_FILENO, TCSANOW, &oldt);
}

int kbhit (void)
{
    struct timeval tv;
    fd_set rdfs;
#ifdef ASCIIART
    // redirect input
    if (file_flag && fp) {
        //fprintf(stderr, "(%d)", 1);
        return 1;
    }
#endif
    tv.tv_sec = 0;
    tv.tv_usec = 1000;

    FD_ZERO(&rdfs);
    FD_SET (STDIN_FILENO, &rdfs);

    select(STDIN_FILENO+1, &rdfs, NULL, NULL, &tv);
    //printf("%d", f);fflush(stdout);
    return FD_ISSET(STDIN_FILENO, &rdfs);

}

void rotate_clock_hand(void)
{
    static int counter = 0;
    static const char hands[] = "|/-\\";
    fprintf(stderr,"%c%c", 8, hands[counter++ % 4]);
}

int osd_get_char() {
    int ch;
    struct timespec ts;

#ifdef ASCIIART
    // redirected input
    if (file_flag && fp) {
        ch = fgetc(fp);
        if (ch != EOF) {
            //fprintf(stderr, "[%02x]", ch);
            rotate_clock_hand();
            return ch;
        }
        fclose(fp);
        fp = NULL;
        file_flag = 0;
        // falling down
    }
#endif

    ts.tv_sec = 0;
    ts.tv_nsec = 100000;  // 1 millisec
    while (!kbhit()) {
        nanosleep(&ts, &ts);
    }
  	ch = getchar();
    if (ch == 0x7f)
        ch = 0x08;
    //if (ch < 0x20 || ch >= 0x7f)
    //    fprintf(stderr, "{%02x}", ch);
    return ch;
}

