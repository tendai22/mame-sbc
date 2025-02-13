// license:BSD-3-Clause
// copyright-holders:Miodrag Milanovic
//============================================================
//
//  tty.cpp - stubs for linking when NO_DEBUGGER is defined
//
//============================================================

#include "emu.h"
#include "debug_module.h"

#include "debug/debugcon.h"
#include "debug/debugcpu.h"
#include "debugger.h"

#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <inttypes.h>
#include <fcntl.h>
#include <iostream>

namespace osd {

namespace {

class debug_tty : public osd_module, public debug_module
{
public:
	debug_tty() :
		osd_module(OSD_DEBUG_PROVIDER, "tty"), debug_module(),
		m_machine(nullptr)
	{
		fprintf(stderr, "debug_tty constructor invoked\n");
	}

	virtual ~debug_tty() { }

	virtual int init(osd_interface &osd, const osd_options &options) override { return 0; }
	virtual void exit() override { }

	virtual void init_debugger(running_machine &machine) override;
	virtual void wait_for_debugger(device_t &device, bool firststop) override;
	virtual void debugger_update() override;

protected:
	int getch(void);
	int kbhit(void);
	void putch(uint8_t ch);
	int getline(uint8_t *buffer, int len);
	void flush_text_buffer(void);
private:
	running_machine *m_machine;
	int m_status;
};

void debug_tty::init_debugger(running_machine &machine)
{
	fprintf(stderr, "debug_tty::init_debugger:\n");
	m_machine = &machine;
}

#define MAXBUF 80

void debug_tty::wait_for_debugger(device_t &device, bool firststop)
{
	int i;
	uint8_t buf[MAXBUF];

	fprintf(stderr, "debug_tty: wait_for_debugger\n");
	if (firststop) {
		fprintf(stderr, "wait_for_debugger: first stop\n");
	}
	flush_text_buffer();
	while (true) {
		fprintf(stderr, ">> ");
		fflush(stderr);
		i = getline(buf, MAXBUF);
		if (strcmp((const char *)buf, "go") == 0) {
			m_machine->debugger().console().get_visible_cpu()->debug()->go();
			break;
		}
		// execute_commands
		if (i > 0) {
			m_machine->debugger().console().execute_command((const char *)buf, true);
			flush_text_buffer();
		}
	}

}

void debug_tty::debugger_update()
{
}

} // anonymous namespace

//
// output messages to stderr
//
void debug_tty::flush_text_buffer(void)
{
	text_buffer &textbuf = m_machine->debugger().console().get_console_textbuf();
	for (std::string_view line_info : text_buffer_lines(textbuf))
	{
		fwrite(line_info.data(), sizeof(char), line_info.length(), stderr);
		fputc('\n', stderr);
	}
}

//
//  input command line 
//
int debug_tty::getline(uint8_t *buffer, int len)
{
	int ch, i;
	i = 0;
	while (i < MAXBUF && (ch = getch()) > 0) {
		if (ch == 0177 || ch == 0x08) {
			if (0 < i) {
				--i;
				putch(0x08); putch(' '); putch(0x08);
			}
			continue;
		}
		if (ch == '\n' || ch == '\r') {
			fprintf(stderr, " EOL\n");
			buffer[i] = '\0';
			break;
		}
		buffer[i++] = ch;
		putch(ch);
	}
	return i;
}

//
// console tty device
//

int debug_tty::kbhit(void)
{
    struct timeval tv;
    fd_set rdfs;

    tv.tv_sec = 0;
    tv.tv_usec = 10;

    FD_ZERO(&rdfs);
    FD_SET(STDIN_FILENO, &rdfs);

    select(STDIN_FILENO + 1, &rdfs, NULL, NULL, &tv);
    return FD_ISSET(STDIN_FILENO, &rdfs);
}

int debug_tty::getch(void)
{
    int result;
	uint8_t ch = 0;

	while(kbhit() == 0)
		;

	result = read(STDIN_FILENO, &ch, 1);
	if (result == 1) {
		return ch;
	}
	return -1;
}

void debug_tty::putch(uint8_t data)
{
	write(STDOUT_FILENO, &data, 1);
}

} // namespace osd


MODULE_DEFINITION(DEBUG_TTY, osd::debug_tty)
