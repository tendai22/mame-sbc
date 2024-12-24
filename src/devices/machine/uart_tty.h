// license:BSD-3-Clause
// copyright-holders: Norihiro Kumagai

// uart_device : simple but generic UART / Linux tty device

#ifndef HEADER_TTY
#define HEADER_TTY

#include "emu.h"
#include "schedule.h"
#include "osdcomm.h"
#include "devcb.h"

#include <time.h>
#include <unistd.h>

// redirect / asciiart.bas file read enable
#define REDIRECT

// tick timer counter type (internal only)
typedef int32_t tick_t;

// Data regisger/Control register
#define TTY_DR 0
#define TTY_CR 1
#define TTY_SR 1

// Status Register
#define DSR_Bit (1<<7)
#define SYNDET_Bit  (1<<6)
#define FE_Bit  (1<<5)
#define OE_Bit  (1<<4)
#define PE_Bit  (1<<3)
#define TXEMPTY_Bit (1<<2)
#define RXRDY_Bit (1<<1)
#define TXRDY_Bit (1<<0)

// tick timer counter type (internal only)
typedef int32_t tick_t;

class uart_device : public device_t {
public:
	// configuration helpers
    // usually for INT line
	auto rxrdy_handler() { return m_rxrdy_handler.bind(); }

	uart_device(const machine_config &mconfig, const char *tag, device_t *owner, uint32_t clock);

	// destructore .. restore tty device in it
	~uart_device(void);

    // CPU interface
	uint8_t status_r();
	uint8_t data_r();
	void data_w(uint8_t data);

    // set a callback function
    // void set_irq_cb(void (*fptr)(offs_t offset, uint8_t value)) { tty_irq_cb = fptr; };

protected:
	uart_device(
			const machine_config &mconfig,
			device_type type,
			const char *tag,
			device_t *owner,
			uint32_t baudrate);


	// device_t implementation
	virtual void device_start() override ATTR_COLD;
	virtual void device_reset() override ATTR_COLD;

    // register tweaking
    virtual uint8_t update_status_r(void);

	// time measurement
	tick_t get_current_tick(void);

private:
    // timer update callback
	TIMER_CALLBACK_MEMBER(update_timer_txd);
	TIMER_CALLBACK_MEMBER(update_timer_rxd);

	// tick ... 1/2 cycle period

    void start_timer_txd(int clock);

    // callbacks
	//devcb_write_line m_output_cb;
	// timer
	emu_timer *m_timer_txd;
    emu_timer *m_timer_rxd;
    // speed (bps)
	time_t get_tick(void);	// convert m_baudrate to tick (1/2 cycle-width)
	void set_baudrate(time_t baudrate);
	// internal state
	int m_phase_rxd;    // 0: none, 1: after-receive dead mode, 2: over
	int m_phase_txd;

    // upper interface
    devcb_write_line m_rxrdy_handler;	// RxRDY line (for CPU INT0)

    // upper layer registers
    uint8_t m_status = (TXRDY_Bit|TXEMPTY_Bit);
    uint8_t m_data_r;
    uint8_t m_data_w;

protected:
    // internal state
	int m_data_r_ready = 0;
    int m_data_w_ready = 0;
    int m_data_w_empty = 0;
	// error flag
	int m_data_r_overrun = 1;
	int m_data_w_overrun = 0;
private:
	// measurement
	tick_t m_tick_start = 0;

	// lower layer (terminal device)
	int kbhit(void);
	int getch(void);
	void putch(uint8_t ch);
#ifdef REDIRECT
	// input redirect
	//FILE *m_fp = NULL;
	int m_file_flag = 0;
	const char *m_filename = "ASCIIART.BAS";
#endif
    int m_fd = STDIN_FILENO;
	void changemode(int dir);

    // file input redirection
    void reset_asciiart_input(void);
	void reset_input_device(void);
    void restore_input_device(void);
};

DECLARE_DEVICE_TYPE(UART, uart_device)

/****************************************************
 derived class macro ... for specific UART chips
*****************************************************/
#define DECLARE_DERIVED_UART_DEVICE(NAME, derived_device) \
DECLARE_DEVICE_TYPE(NAME, derived_device)\
class derived_device : public uart_device {\
public:\
	derived_device(\
		const machine_config &mconfig,\
		const char *tag,\
		device_t *owner,\
		u32 clock)\
	: uart_device(mconfig, NAME, tag, owner, clock) {}\
protected:\
	derived_device(\
		const machine_config &mconfig,\
		device_type type,\
		const char *tag,\
		device_t *owner,\
		u32 clock)\
	: uart_device(mconfig, type, tag, owner, clock) {}\
	uint8_t update_status_r(void) override;\
};\


#endif /* HEADER_TTY */
