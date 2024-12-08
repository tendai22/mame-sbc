// license:BSD-3-Clause
// copyright-holders:Jonathan Gevaryahu, Robbbert, Miodrag Milanovic
/******************************************************************************

  This is a simplified version of the sbc6800 driver, merely as an example for a standalone
  emulator build. Video terminal and user interface is removed. For full notes and proper
  emulation driver, see src/mame/homebrew/sbc6800.cpp.

******************************************************************************/

#include "emu.h"
// #include "cpu/z80/z80.h"
#include "cpu/m6800/m6800.h"
#include "sbc6800.h"
#include "interface.h"
#include "osd.h"

#include <cstdio>
#include <cstdlib>

class sbc6800_state : public driver_device
{
public:
	sbc6800_state(const machine_config &mconfig, device_type type, const char *tag) :
		driver_device(mconfig, type, tag),
		m_maincpu(*this, "maincpu"),
		m_main_ram(*this, "main_ram"),
		m_main_rom(*this, "main_rom")
	{
		fprintf(stderr, "sbc6800_state: constructor\n");
	}

	uint8_t uart_creg_r();
	uint8_t uart_dreg_r();
	void uart_creg_w(uint8_t data);
	void uart_dreg_w(uint8_t data);
	// void display_w(offs_t offset, uint8_t data);

	void m68_mem(address_map &map) ATTR_COLD;
	// void io_map(address_map &map) ATTR_COLD;
	void sbc6800(machine_config &config);

private:
	required_device<cpu_device> m_maincpu;
	required_shared_ptr<uint8_t> m_main_ram;
	required_shared_ptr<uint8_t> m_main_rom;

	virtual void machine_reset() override ATTR_COLD;
};


/******************************************************************************
 Machine Start/Reset
******************************************************************************/

void sbc6800_state::machine_reset()
{

	// program is self-modifying, so need to refresh it on each run
	// memcpy(m_main_ram+0xe000, sbc6800_binary, sizeof sbc6800_binary);
	memcpy(m_main_rom, sbc6800_binary, sizeof sbc6800_binary);
	fprintf(stderr, "memcpy: %ld bytes to main_rom\n", sizeof sbc6800_binary);
	fprintf(stderr, "reset vector: %x %x \n", m_main_rom[0xfffe - 0xe000], m_main_rom[0xffff - 0xe000]);
	// serial reset
	input_device_reset();
	output_device_reset();
	fprintf(stderr, "machine_reset\n");

	m_maincpu->set_input_line(INPUT_LINE_RESET, ASSERT_LINE);
	m_maincpu->set_input_line(INPUT_LINE_RESET, CLEAR_LINE);
}


/******************************************************************************
 I/O Handlers
******************************************************************************/

uint8_t sbc6800_state::uart_creg_r()
{
	// spit out the byte in out_byte if out_req is not equal to out_req_last
	uint8_t c;

	output_device_update();
	update_user_input();
	c = input_device_status();
	// c |= 2;
	// fprintf(stderr, "[%d]", c);
	return c;
}

void sbc6800_state::uart_creg_w(uint8_t data)
{
	// fprintf(stderr, "uart_creg_w: %02x\n", data);
}

std::uint8_t sbc6800_state::uart_dreg_r()
{
	std::uint8_t ch;
	output_device_update();
	update_user_input();
	ch = input_device_read();
	return ch;
}

void sbc6800_state::uart_dreg_w(uint8_t data)
{
	// if (data < 0x20) {
    //    fprintf(stderr, "[%02x]", data);
	// }
	output_device_write(data);
	output_device_update();
	update_user_input();
}

// void sbc6800_state::display_w(offs_t offset, uint8_t data)
// {
// 	fprintf(stderr, "io_w: %04x %02x\n", offset, data);
// }

/******************************************************************************
 Address Maps
******************************************************************************/

void sbc6800_state::m68_mem(address_map &map)
{
	map(0x0000, 0x7fff).ram().share("main_ram");
	map(0x8018, 0x8018).rw(FUNC(sbc6800_state::uart_creg_r), FUNC(sbc6800_state::uart_creg_w));
	map(0x8019, 0x8019).rw(FUNC(sbc6800_state::uart_dreg_r), FUNC(sbc6800_state::uart_dreg_w));
	map(0xe000, 0xffff).rom().share("main_rom");
}

// void sbc6800_state::io_map(address_map &map)
// {
// 	map.unmap_value_high();
// 	map.global_mask(0xff);
// 	map(0x20, 0x25).w(FUNC(sbc6800_state::display_w));
// 
// }


/******************************************************************************
 Input Ports
******************************************************************************/

static INPUT_PORTS_START( sbc6800 )
INPUT_PORTS_END


/******************************************************************************
 Machine Drivers
******************************************************************************/

void sbc6800_state::sbc6800(machine_config &config)
{
	/* basic machine hardware */
	//Z80(config, m_maincpu, XTAL(3'579'545));
	// Z80(config, m_maincpu, XTAL(40'000'000));
	M6800(config, m_maincpu, XTAL(16'000'000 / 4));
	m_maincpu->set_addrmap(AS_PROGRAM, &sbc6800_state::m68_mem);
	// m_maincpu->set_addrmap(AS_IO, &sbc6800_state::io_map);
}


/******************************************************************************
 ROM Definitions
******************************************************************************/

ROM_START(sbc6800)
	ROM_REGION(0x0, "maincpu", 0)
ROM_END


/******************************************************************************
 Drivers
******************************************************************************/

/*    YEAR  NAME      PARENT      COMPAT  MACHINE   INPUT   STATE         INIT        COMPANY                         FULLNAME                            FLAGS */
COMP( 2024, sbc6800,   0,          0,      sbc6800,   sbc6800, sbc6800_state, empty_init, "VintageChips", "sbc6800 (m6800+6850)", MACHINE_NO_SOUND_HW )
