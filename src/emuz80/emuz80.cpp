// license:BSD-3-Clause
// copyright-holders:Jonathan Gevaryahu, Robbbert, Miodrag Milanovic
/******************************************************************************

  This is a simplified version of the emuz80 driver, merely as an example for a standalone
  emulator build. Video terminal and user interface is removed. For full notes and proper
  emulation driver, see src/mame/homebrew/emuz80.cpp.

******************************************************************************/

#include "emu.h"
#include "cpu/z80/z80.h"
#include "emuz80.h"
#include "interface.h"
#include "osd.h"

#include <cstdio>
#include <cstdlib>

class emuz80_state : public driver_device
{
public:
	emuz80_state(const machine_config &mconfig, device_type type, const char *tag) :
		driver_device(mconfig, type, tag),
		m_maincpu(*this, "maincpu"),
		m_main_ram(*this, "main_ram")
	{
		fprintf(stderr, "emuz80_state: constructor\n");
	}

	uint8_t uart_creg_r();
	uint8_t uart_dreg_r();
	void uart_creg_w(uint8_t data);
	void uart_dreg_w(uint8_t data);
	void display_w(offs_t offset, uint8_t data);

	void z80_mem(address_map &map) ATTR_COLD;
	void io_map(address_map &map) ATTR_COLD;
	void emuz80(machine_config &config);

private:
	required_device<cpu_device> m_maincpu;
	required_shared_ptr<uint8_t> m_main_ram;
	// uint8_t m_out_data; // byte written to 0xFFFF
	// uint8_t m_out_req; // byte written to 0xFFFE
	// uint8_t m_out_req_last; // old value at 0xFFFE before the most recent write
	// uint8_t m_out_ack; // byte written to 0xFFFC
	// std::string terminate_string;

	virtual void machine_reset() override ATTR_COLD;
};


/******************************************************************************
 Machine Start/Reset
******************************************************************************/

void emuz80_state::machine_reset()
{
	// zerofill
	// m_out_ack = 0;
	// m_out_req = 0;
	// m_out_req_last = 0;
	// m_out_data = 0;
	// terminate_string = "";

	// program is self-modifying, so need to refresh it on each run
	memcpy(m_main_ram, emuz80_binary, sizeof emuz80_binary);
	// serial reset
	input_device_reset();
	output_device_reset();
	fprintf(stderr, "machine_reset\n");

}


/******************************************************************************
 I/O Handlers
******************************************************************************/

uint8_t emuz80_state::uart_creg_r()
{
	// spit out the byte in out_byte if out_req is not equal to out_req_last
	uint8_t c;

	output_device_update();
	update_user_input();

	c = input_device_status();
	c |= 2;
	//fprintf(stderr, "[%d]", c);
	return c;
}

void emuz80_state::uart_creg_w(uint8_t data)
{
	fprintf(stderr, "uart_creg_w: %02x\n", data);
}

std::uint8_t emuz80_state::uart_dreg_r()
{
	std::uint8_t ch;
	output_device_update();
	update_user_input();
	ch = input_device_read();
	return ch;
}

void emuz80_state::uart_dreg_w(uint8_t data)
{
	//if (data < 0x20) {
    //    fprintf(stderr, "[%02x]", data);
	//}
	output_device_write(data);
	output_device_update();
	update_user_input();
}

void emuz80_state::display_w(offs_t offset, uint8_t data)
{
	fprintf(stderr, "io_w: %04x %02x\n", offset, data);
}

/******************************************************************************
 Address Maps
******************************************************************************/

void emuz80_state::z80_mem(address_map &map)
{
	map(0x0000, 0xdfff).ram().share("main_ram");
	map(0xe000, 0xe000).rw(FUNC(emuz80_state::uart_dreg_r), FUNC(emuz80_state::uart_dreg_w));
	map(0xe001, 0xe001).rw(FUNC(emuz80_state::uart_creg_r), FUNC(emuz80_state::uart_creg_w));
}

void emuz80_state::io_map(address_map &map)
{
	map.unmap_value_high();
	map.global_mask(0xff);
	map(0x20, 0x25).w(FUNC(emuz80_state::display_w));

}


/******************************************************************************
 Input Ports
******************************************************************************/

static INPUT_PORTS_START( emuz80 )
INPUT_PORTS_END


/******************************************************************************
 Machine Drivers
******************************************************************************/

void emuz80_state::emuz80(machine_config &config)
{
	/* basic machine hardware */
	//Z80(config, m_maincpu, XTAL(3'579'545));
	Z80(config, m_maincpu, XTAL(40'000'000));
	m_maincpu->set_addrmap(AS_PROGRAM, &emuz80_state::z80_mem);
	m_maincpu->set_addrmap(AS_IO, &emuz80_state::io_map);
}


/******************************************************************************
 ROM Definitions
******************************************************************************/

ROM_START(emuz80)
	ROM_REGION(0x0, "maincpu", 0)
ROM_END


/******************************************************************************
 Drivers
******************************************************************************/

/*    YEAR  NAME      PARENT      COMPAT  MACHINE   INPUT   STATE         INIT        COMPANY                         FULLNAME                            FLAGS */
COMP( 2024, emuz80,   0,          0,      emuz80,   emuz80, emuz80_state, empty_init, "VintageChips", "emuz80 (Z80 with PIC18F47Q53)", MACHINE_NO_SOUND_HW )
