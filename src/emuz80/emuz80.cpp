// license:BSD-3-Clause
// copyright-holders: Norihiro Kumagai
/******************************************************************************

  This is a simplified version of the emuz80 driver, merely as an example for a standalone
  emulator build. Video terminal and user interface is removed. For full notes and proper
  emulation driver, see src/mame/homebrew/emuz80.cpp.

******************************************************************************/

#include "emu.h"
#include "cpu/z80/z80.h"
#include "emuz80.h"
#include "interface.h"
#include "machine/uart_tty.h"

#include <cstdio>
#include <cstdlib>

class emuz80_state : public driver_device
{
public:
	emuz80_state(const machine_config &mconfig, device_type type, const char *tag) :
		driver_device(mconfig, type, tag),
		m_maincpu(*this, "maincpu"),
		m_main_ram(*this, "main_ram"),
		m_uart(*this, "uart")
	{
		fprintf(stderr, "emuz80_state: constructor\n");
	}

	uint8_t uart_creg_r();
	uint8_t uart_dreg_r();
	void uart_creg_w(uint8_t data);
	void uart_dreg_w(uint8_t data);

	void z80_mem(address_map &map) ATTR_COLD;
	//void io_map(address_map &map) ATTR_COLD;
	void emuz80(machine_config &config);

	void sbc_int_w(int state);	// drive Z80 int line

private:
	required_device<cpu_device> m_maincpu;
	required_shared_ptr<uint8_t> m_main_ram;
	required_device<uart_device> m_uart;

	virtual void machine_reset() override ATTR_COLD;
};


/******************************************************************************
 Machine Start/Reset
******************************************************************************/

void emuz80_state::machine_reset()
{
	// program is self-modifying, so need to refresh it on each run
	memcpy(m_main_ram, emuz80_binary, sizeof emuz80_binary);
	fprintf(stderr, "machine_reset\n");

}


/******************************************************************************
 I/O Handlers 
******************************************************************************/

uint8_t emuz80_state::uart_dreg_r() { return m_uart->data_r(); }
void    emuz80_state::uart_dreg_w(uint8_t data) { m_uart->data_w(data); }
uint8_t emuz80_state::uart_creg_r() {	return m_uart->status_r(); }
void    emuz80_state::uart_creg_w(uint8_t data) {
	fprintf(stderr, "uart_creg_w: %02x\n", data);
}

/******************************************************************************
 Address Maps
******************************************************************************/

void emuz80_state::z80_mem(address_map &map)
{
	map(0x0000, 0xdfff).ram().share("main_ram");
	// memory mapped I/O
	map(0xe000, 0xe000).rw(FUNC(emuz80_state::uart_dreg_r), FUNC(emuz80_state::uart_dreg_w));
	map(0xe001, 0xe001).rw(FUNC(emuz80_state::uart_creg_r), FUNC(emuz80_state::uart_creg_w));
}

#if 0
void emuz80_state::io_map(address_map &map)
{
	map.unmap_value_high();
	map.global_mask(0xff);
	map(0x20, 0x25).w(FUNC(emuz80_state::display_w));

}
#endif

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
	fprintf(stderr, "emuz80_state::emuz80 start\n");
	//Z80(config, m_maincpu, XTAL(3'579'545));
	Z80(config, m_maincpu, XTAL(40'000'000));
	UART(config, m_uart, 9600);
	m_maincpu->set_addrmap(AS_PROGRAM, &emuz80_state::z80_mem);
	m_maincpu->set_regdump_format("A BC DE HL SP");
	//m_maincpu->set_addrmap(AS_IO, &emuz80_state::io_map);
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
