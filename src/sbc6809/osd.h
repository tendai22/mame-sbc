#if defined(__cplusplus)
extern "C" {
#endif
#ifndef HEADER__OSD
#define HEADER__OSD

/* Time between characters sent to output device (seconds) */
// changed as milliseconds about 10000bps serial speed
#define OUTPUT_DEVICE_PERIOD 1

// linux tty driver
void changemode(int dir);
int kbhit(void);
int osd_get_char(void);

// input_device
void input_device_reset(void);
void input_device_update(void);
int input_device_ack(void);
unsigned int input_device_read(void);
unsigned int input_device_status(void);
void input_device_write(unsigned int value);

// output_device
void output_device_reset(void);
void output_device_update(void);
int output_device_ack(void);
unsigned int output_device_read(void);
void output_device_write(unsigned int value);

// update
void update_user_input(void);

#endif /* HEADER__OSD */
#if defined(__cplusplus)
}
#endif

