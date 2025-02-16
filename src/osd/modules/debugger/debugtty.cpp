// license:BSD-3-Clause
// copyright-holders:Norihiro Kumagai
//============================================================
//
//  debugtty.cpp - debugger for using traditional tty
//
//============================================================

#include "emu.h"
#include "debug_module.h"

#include "debug/debugcon.h"
#include "debug/debugcpu.h"
#include "debugger.h"
#include "debug/debugbuf.h"

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
	void dump_registers(device_t &device, const char *reg_names);
	// raw keyin/out routines
	int getch(void);
	int kbhit(void);
	void putch(uint8_t ch);
	// line input/edit 
	int getline(uint8_t *buffer, int len);
	void flush_text_buffer(void);
private:
	running_machine *m_machine;
	const char *m_register_fmt;
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

	flush_text_buffer();
	if (firststop) {
		// get current pc
		device_debug *debug = device.debug();
		off_t curpc = debug->history_pc(0).first;
		// disassemble one line
		debug_disasm_buffer buffer(device);
		std::string instruction;
		offs_t next_pc, size;
		u32 info;
		buffer.disassemble(curpc, instruction, next_pc, size, info);
		fprintf(stderr, "%04lx %-20s ", curpc, instruction.c_str());
		//u32 pc = buffer.next_pc_wrap(curpc, info & util::disasm_interface::LENGTHMASK);
		// disassemble the current instruction and get the length
		dump_registers(device, "PC SP AF BC DE HL R");
	}
	fprintf(stderr, ">> "); fflush(stderr);
	i = getline(buf, MAXBUF);
	// execute single command
	if (i < 0) {
		m_machine->debugger().console().execute_command("hardreset", false);
		fprintf(stderr, "exit\n");
	}
	if (i > 0) {
		// false: no need to echoback, because getline already echoed it back
		m_machine->debugger().console().execute_command((const char *)buf, false);
		flush_text_buffer();
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
	text_buffer_clear(textbuf);
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
		if (i == 0 && ch == 0x04) {
			// Ctrl-D
			return -1;
		}
		if (ch == '\n' || ch == '\r') {
			fprintf(stderr, "\n");
			buffer[i] = '\0';
			break;
		}
		buffer[i++] = ch;
		putch(ch);
	}
	return i;
}

// -------------------------------------------
// dump_registers: for mame-sbc debugtty.cpp
// -------------------------------------------

void debug_tty::dump_registers(device_t &device, const char *reg_name)
{
	// add all registers into it
	std::stringstream s0(reg_name);
	std::string s;
	bool outflag = false;
	while (std::getline(s0, s, ' ')) {
		// find entry and dump it
		for (const auto &entry : device.debug()->state_entries()) {
			if (s.compare(entry->symbol()) == 0) {
				const char *fmt;
				switch(entry->datasize()) {
				case 1:	fmt = "%s %02lx "; break;
				case 2: fmt = "%s %04lx "; break;
				case 3: fmt = "%s %06lx "; break;
				case 4: fmt = "%s %08lx "; break;
				default: fmt = "%s %04lx "; break;
				}
				fprintf(stderr, fmt, s.c_str(), entry->value(), entry->datasize());
				outflag = true;
				break;
			}
		}
	}
	if (outflag) {
		fprintf(stderr, "\n");
	}
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
