STANDALONE = true

CPUS["M6800"] = true

-- MACHINES["Z80DAISY"] = true

function standalone()
	files{
		MAME_DIR .. "src/sbc6800/main.cpp",
		MAME_DIR .. "src/sbc6800/sbc6800.cpp",
		MAME_DIR .. "src/sbc6800/sbc6800.h",
		MAME_DIR .. "src/sbc6800/interface.h",
		MAME_DIR .. "src/sbc6800/osd.h",
		MAME_DIR .. "src/sbc6800/osd_linux.c",
	}
end

