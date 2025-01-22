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

private:
	running_machine *m_machine;
};

void debug_tty::init_debugger(running_machine &machine)
{
	fprintf(stderr, "debug_tty::init_debugger:\n");
	m_machine = &machine;
}

void debug_tty::wait_for_debugger(device_t &device, bool firststop)
{
	fprintf(stderr, "debug_tty: wait_for_debugger\n");
	m_machine->debugger().console().get_visible_cpu()->debug()->go();
}

void debug_tty::debugger_update()
{
}

} // anonymous namespace

} // namespace osd

MODULE_DEFINITION(DEBUG_TTY, osd::debug_tty)
