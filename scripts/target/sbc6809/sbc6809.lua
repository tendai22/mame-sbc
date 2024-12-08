STANDALONE = true

-- CPUS["MC6809"] = true
CPUS["M6809"] = true

-- MACHINES["Z80DAISY"] = true

function standalone()
	files{
		MAME_DIR .. "src/sbc6809/main.cpp",
		MAME_DIR .. "src/sbc6809/sbc6809.cpp",
		MAME_DIR .. "src/sbc6809/sbc6809.h",
		MAME_DIR .. "src/sbc6809/interface.h",
		MAME_DIR .. "src/sbc6809/osd.h",
		MAME_DIR .. "src/sbc6809/osd_linux.c",
	}
end

