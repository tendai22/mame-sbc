-- license:BSD-3-Clause
-- copyright-holders:MAMEdev Team

---------------------------------------------------------------------------
--
--   cpu.lua
--
--   Rules for building CPU cores
--
---------------------------------------------------------------------------

--------------------------------------------------
-- Dynamic recompiler objects
--------------------------------------------------

DRC_CPUS = { "E1", "SH", "MIPS3", "POWERPC", "ARM7", "ADSP21062", "MB86235", "DSP16", "UNSP" }
CPU_INCLUDE_DRC = false
for i, v in ipairs(DRC_CPUS) do
	if (CPUS[v]~=null) then
		CPU_INCLUDE_DRC = true
		break
	end
end


if (CPU_INCLUDE_DRC) then
	files {
--		MAME_DIR .. "src/devices/cpu/drcbec.cpp",
--		MAME_DIR .. "src/devices/cpu/drcbec.h",
--		MAME_DIR .. "src/devices/cpu/drcbeut.cpp",
--		MAME_DIR .. "src/devices/cpu/drcbeut.h",
--		MAME_DIR .. "src/devices/cpu/drccache.cpp",
--		MAME_DIR .. "src/devices/cpu/drccache.h",
--		MAME_DIR .. "src/devices/cpu/drcfe.cpp",
--		MAME_DIR .. "src/devices/cpu/drcfe.h",
--		MAME_DIR .. "src/devices/cpu/drcuml.cpp",
--		MAME_DIR .. "src/devices/cpu/drcuml.h",
--		MAME_DIR .. "src/devices/cpu/uml.cpp",
--		MAME_DIR .. "src/devices/cpu/uml.h",
--		MAME_DIR .. "src/devices/cpu/x86log.cpp",
--		MAME_DIR .. "src/devices/cpu/x86log.h",
--		MAME_DIR .. "src/devices/cpu/drcumlsh.h",
	}
	if not _OPTIONS["FORCE_DRC_C_BACKEND"] then
		files {
--			MAME_DIR .. "src/devices/cpu/drcbex64.cpp",
--			MAME_DIR .. "src/devices/cpu/drcbex64.h",
--			MAME_DIR .. "src/devices/cpu/drcbex86.cpp",
--			MAME_DIR .. "src/devices/cpu/drcbex86.h",
		}
	end

	if _OPTIONS["targetos"]=="macosx" and _OPTIONS["gcc"]~=nil then
		if string.find(_OPTIONS["gcc"], "clang") and (str_to_version(_OPTIONS["gcc_version"]) < 80000) then
			defines {
--				"TARGET_OS_OSX=1",
			}
		end
	end
end

--------------------------------------------------
-- Signetics 8X300 / Scientific Micro Systems SMS300
--@src/devices/cpu/8x300/8x300.h,CPUS["8X300"] = true
--------------------------------------------------

if CPUS["8X300"] then
	files {
--		MAME_DIR .. "src/devices/cpu/8x300/8x300.cpp",
--		MAME_DIR .. "src/devices/cpu/8x300/8x300.h",
	}
end

if opt_tool(CPUS, "8X300") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/8x300/8x300dasm.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/8x300/8x300dasm.cpp")
end

--------------------------------------------------
-- 3DO Don's Super Performing Processor (DSPP)
--@src/devices/cpu/dspp/dspp.h,CPUS["DSPP"] = true
--------------------------------------------------

if CPUS["DSPP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/dspp/dspp.cpp",
--		MAME_DIR .. "src/devices/cpu/dspp/dspp.h",
--		MAME_DIR .. "src/devices/cpu/dspp/dsppdrc.cpp",
--		MAME_DIR .. "src/devices/cpu/dspp/dsppfe.cpp",
--		MAME_DIR .. "src/devices/cpu/dspp/dsppfe.h",
	}
end

if opt_tool(CPUS, "DSPP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dspp/dsppdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dspp/dsppdasm.h")
end

--------------------------------------------------
-- ARCangent A4
--@src/devices/cpu/arc/arc.h,CPUS["ARC"] = true
--------------------------------------------------

if CPUS["ARC"] then
	files {
--		MAME_DIR .. "src/devices/cpu/arc/arc.cpp",
--		MAME_DIR .. "src/devices/cpu/arc/arc.h",
	}
end

if opt_tool(CPUS, "ARC") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arc/arcdasm.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arc/arcdasm.cpp")
end

--------------------------------------------------
-- ARcompact (ARCtangent-A5, ARC 600, ARC 700)
--@src/devices/cpu/arcompact/arcompact.h,CPUS["ARCOMPACT"] = true
--------------------------------------------------

if CPUS["ARCOMPACT"] then
	files {
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact.h",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_00to01.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_02to03.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_jumps.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_loop.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_aux.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_2f_sop.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_2f_3f_zop.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_04_3x.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_05.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_05_2f_sop.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_06to0b.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0c_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0d_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0e_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0f_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0f_00_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_0f_00_07_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_12to16_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_17_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_18_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_19_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_1ato1c_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_execute_ops_1dto1f_16bit.cpp",
--		MAME_DIR .. "src/devices/cpu/arcompact/arcompact_helper.ipp",
	}
end

if opt_tool(CPUS, "ARCOMPACT") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompact_common.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_internal.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_00to01.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_02to03.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_04.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_04_2f_sop.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_04_2f_3f_zop.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_04_3x.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_05.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_05_2f_sop.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_06to0b.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arcompact/arcompactdasm_ops_16bit.cpp")
end

--------------------------------------------------
-- Acorn ARM series
--
--@src/devices/cpu/arm/arm.h,CPUS["ARM"] = true
--@src/devices/cpu/arm7/arm7.h,CPUS["ARM7"] = true
--------------------------------------------------

if CPUS["ARM"] then
	files {
--		MAME_DIR .. "src/devices/cpu/arm/arm.cpp",
--		MAME_DIR .. "src/devices/cpu/arm/arm.h",
	}
end

if opt_tool(CPUS, "ARM") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arm/armdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arm/armdasm.h")
end

if CPUS["ARM7"] then
	files {
--		MAME_DIR .. "src/devices/cpu/arm7/arm7.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7.h",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7thmb.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7ops.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/ap2010cpu.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/ap2010cpu.h",
--		MAME_DIR .. "src/devices/cpu/arm7/lpc210x.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/lpc210x.h",
--		MAME_DIR .. "src/devices/cpu/arm7/upd800468.cpp",
--		MAME_DIR .. "src/devices/cpu/arm7/upd800468.h",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7core.h",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7core.hxx",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7drc.hxx",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7help.h",
--		MAME_DIR .. "src/devices/cpu/arm7/arm7tdrc.hxx",
--		MAME_DIR .. "src/devices/cpu/arm7/cecalls.hxx",
	}
end

if opt_tool(CPUS, "ARM7") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arm7/arm7dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/arm7/arm7dasm.h")
end

--------------------------------------------------
-- Advanced Digital Chips SE3208
--@src/devices/cpu/se3208/se3208.h,CPUS["SE3208"] = true
--------------------------------------------------

if CPUS["SE3208"] then
	files {
--		MAME_DIR .. "src/devices/cpu/se3208/se3208.cpp",
--		MAME_DIR .. "src/devices/cpu/se3208/se3208.h",
	}
end

if opt_tool(CPUS, "SE3208") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/se3208/se3208dis.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/se3208/se3208dis.h")
end

--------------------------------------------------
-- American Microsystems, Inc.(AMI) S2000 series
--@src/devices/cpu/amis2000/amis2000.h,CPUS["AMIS2000"] = true
--------------------------------------------------

if CPUS["AMIS2000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/amis2000/amis2000.cpp",
--		MAME_DIR .. "src/devices/cpu/amis2000/amis2000.h",
--		MAME_DIR .. "src/devices/cpu/amis2000/amis2000op.cpp",
	}
end

if opt_tool(CPUS, "AMIS2000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/amis2000/amis2000d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/amis2000/amis2000d.h")
end

--------------------------------------------------
-- Analog Devices ADSP21xx series
--@src/devices/cpu/adsp2100/adsp2100.h,CPUS["ADSP21XX"] = true
--------------------------------------------------

if CPUS["ADSP21XX"] then
	files {
--		MAME_DIR .. "src/devices/cpu/adsp2100/adsp2100.cpp",
--		MAME_DIR .. "src/devices/cpu/adsp2100/adsp2100.h",
--		MAME_DIR .. "src/devices/cpu/adsp2100/2100ops.hxx",
	}
end

if opt_tool(CPUS, "ADSP21XX") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/adsp2100/2100dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/adsp2100/2100dasm.h")
end

--------------------------------------------------
-- Analog Devices "Sharc" ADSP21062
--@src/devices/cpu/sharc/sharc.h,CPUS["ADSP21062"] = true
--------------------------------------------------

if CPUS["ADSP21062"] then
	files {
--		MAME_DIR .. "src/devices/cpu/sharc/sharc.cpp",
--		MAME_DIR .. "src/devices/cpu/sharc/sharc.h",
--		MAME_DIR .. "src/devices/cpu/sharc/compute.hxx",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcdma.hxx",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcmem.hxx",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcops.h",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcops.hxx",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcdrc.cpp",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcfe.cpp",
--		MAME_DIR .. "src/devices/cpu/sharc/sharcfe.h",
	}
end

if opt_tool(CPUS, "ADSP21062") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sharc/sharcdsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sharc/sharcdsm.h")
end

--------------------------------------------------
-- APEXC
--@src/devices/cpu/apexc/apexc.h,CPUS["APEXC"] = true
--------------------------------------------------

if CPUS["APEXC"] then
	files {
--		MAME_DIR .. "src/devices/cpu/apexc/apexc.cpp",
--		MAME_DIR .. "src/devices/cpu/apexc/apexc.h",
	}
end

if opt_tool(CPUS, "APEXC") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/apexc/apexcdsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/apexc/apexcdsm.h")
end

--------------------------------------------------
-- WE|AT&T DSP16
--@src/devices/cpu/dsp16/dsp16.h,CPUS["DSP16"] = true
--------------------------------------------------

if CPUS["DSP16"] then
	files {
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16.h",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16core.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16core.h",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16core.ipp",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16fe.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16fe.h",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16rc.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp16/dsp16rc.h",
	}
end

if opt_tool(CPUS, "DSP16") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp16/dsp16dis.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp16/dsp16dis.h")
end

--------------------------------------------------
-- AT&T DSP32C
--@src/devices/cpu/dsp32/dsp32.h,CPUS["DSP32C"] = true
--------------------------------------------------

if CPUS["DSP32C"] then
	files {
--		MAME_DIR .. "src/devices/cpu/dsp32/dsp32.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp32/dsp32.h",
--		MAME_DIR .. "src/devices/cpu/dsp32/dsp32ops.hxx",
	}
end

if opt_tool(CPUS, "DSP32C") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp32/dsp32dis.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp32/dsp32dis.h")
end

--------------------------------------------------
-- Atari custom RISC processor
--@src/devices/cpu/asap/asap.h,CPUS["ASAP"] = true
--------------------------------------------------

if CPUS["ASAP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/asap/asap.cpp",
--		MAME_DIR .. "src/devices/cpu/asap/asap.h",
	}
end

if opt_tool(CPUS, "ASAP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/asap/asapdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/asap/asapdasm.h")
end

--------------------------------------------------
-- AMD Am29000
--@src/devices/cpu/am29000/am29000.h,CPUS["AM29000"] = true
--------------------------------------------------

if CPUS["AM29000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/am29000/am29000.cpp",
--		MAME_DIR .. "src/devices/cpu/am29000/am29000.h",
--		MAME_DIR .. "src/devices/cpu/am29000/am29ops.h",
	}
end

if opt_tool(CPUS, "AM29000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/am29000/am29dasm.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/am29000/am29dasm.cpp")
end

--------------------------------------------------
-- Atari Jaguar custom DSPs
--@src/devices/cpu/jaguar/jaguar.h,CPUS["JAGUAR"] = true
--------------------------------------------------

if CPUS["JAGUAR"] then
	files {
--		MAME_DIR .. "src/devices/cpu/jaguar/jaguar.cpp",
--		MAME_DIR .. "src/devices/cpu/jaguar/jaguar.h",
	}
end

if opt_tool(CPUS, "JAGUAR") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/jaguar/jagdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/jaguar/jagdasm.h")
end

--------------------------------------------------
-- Simutrek Cube Quest bit-sliced CPUs
--@src/devices/cpu/cubeqcpu/cubeqcpu.h,CPUS["CUBEQCPU"] = true
--------------------------------------------------

if CPUS["CUBEQCPU"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cubeqcpu/cubeqcpu.cpp",
--		MAME_DIR .. "src/devices/cpu/cubeqcpu/cubeqcpu.h",
	}
end

if opt_tool(CPUS, "CUBEQCPU") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cubeqcpu/cubedasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cubeqcpu/cubedasm.h")
end

--------------------------------------------------
-- Ensoniq ES5510 ('ESP') DSP
--@src/devices/cpu/es5510/es5510.h,CPUS["ES5510"] = true
--------------------------------------------------

if CPUS["ES5510"] then
	files {
--		MAME_DIR .. "src/devices/cpu/es5510/es5510.cpp",
--		MAME_DIR .. "src/devices/cpu/es5510/es5510.h",
	}
end

if opt_tool(CPUS, "ES5510") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/es5510/es5510d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/es5510/es5510d.h")
end

--------------------------------------------------
-- Entertainment Sciences AM29116-based RIP
--@src/devices/cpu/esrip/esrip.h,CPUS["ESRIP"] = true
--------------------------------------------------

if CPUS["ESRIP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/esrip/esrip.cpp",
--		MAME_DIR .. "src/devices/cpu/esrip/esrip.h",
	}
end

if opt_tool(CPUS, "ESRIP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/esrip/esripdsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/esrip/esripdsm.h")
end

--------------------------------------------------
-- Seiko Epson E0C6200 series
--@src/devices/cpu/e0c6200/e0c6200.h,CPUS["E0C6200"] = true
--------------------------------------------------

if CPUS["E0C6200"] then
	files {
--		MAME_DIR .. "src/devices/cpu/e0c6200/e0c6200.cpp",
--		MAME_DIR .. "src/devices/cpu/e0c6200/e0c6200.h",
--		MAME_DIR .. "src/devices/cpu/e0c6200/e0c6s46.cpp",
--		MAME_DIR .. "src/devices/cpu/e0c6200/e0c6s46.h",
--		MAME_DIR .. "src/devices/cpu/e0c6200/e0c6200op.cpp",
	}
end

if opt_tool(CPUS, "E0C6200") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/e0c6200/e0c6200d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/e0c6200/e0c6200d.h")
end

--------------------------------------------------
-- RCA COSMAC
--@src/devices/cpu/cosmac/cosmac.h,CPUS["COSMAC"] = true
--------------------------------------------------

if CPUS["COSMAC"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cosmac/cosmac.cpp",
--		MAME_DIR .. "src/devices/cpu/cosmac/cosmac.cpp",
--		MAME_DIR .. "src/devices/cpu/cosmac/cosmac.h",
	}
end

if opt_tool(CPUS, "COSMAC") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cosmac/cosdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cosmac/cosdasm.h")
end

--------------------------------------------------
-- National Semiconductor COPS(MM57) family
--@src/devices/cpu/cops1/mm5799.h,CPUS["COPS1"] = true
--------------------------------------------------

if CPUS["COPS1"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cops1/cops1base.cpp",
--		MAME_DIR .. "src/devices/cpu/cops1/cops1base.h",
--		MAME_DIR .. "src/devices/cpu/cops1/mm5799.cpp",
--		MAME_DIR .. "src/devices/cpu/cops1/mm5799.h",
--		MAME_DIR .. "src/devices/cpu/cops1/mm5799op.cpp",
	}
end

if opt_tool(CPUS, "COPS1") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cops1/cops1d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cops1/cops1d.h")
end

--------------------------------------------------
-- National Semiconductor COPS(COP400) family
--@src/devices/cpu/cop400/cop400.h,CPUS["COP400"] = true
--------------------------------------------------

if CPUS["COP400"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cop400/cop400.cpp",
--		MAME_DIR .. "src/devices/cpu/cop400/cop400.h",
--		MAME_DIR .. "src/devices/cpu/cop400/cop400op.hxx",
	}
end

if opt_tool(CPUS, "COP400") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop410ds.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop410ds.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop420ds.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop420ds.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop444ds.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop444ds.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop424ds.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cop400/cop424ds.h")
end

--------------------------------------------------
-- CP1610
--@src/devices/cpu/cp1610/cp1610.h,CPUS["CP1610"] = true
--------------------------------------------------

if CPUS["CP1610"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cp1610/cp1610.cpp",
--		MAME_DIR .. "src/devices/cpu/cp1610/cp1610.h",
	}
end

if opt_tool(CPUS, "CP1610") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cp1610/1610dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cp1610/1610dasm.h")
end

--------------------------------------------------
-- DEC PDP-8
--@src/devices/cpu/pdp8/pdp8.h,CPUS["PDP8"] = true
--@src/devices/cpu/pdp8/hd6120.h,CPUS["PDP8"] = true
--------------------------------------------------

if CPUS["PDP8"] then
	files {
--		MAME_DIR .. "src/devices/cpu/pdp8/hd6120.cpp",
--		MAME_DIR .. "src/devices/cpu/pdp8/hd6120.h",
--		MAME_DIR .. "src/devices/cpu/pdp8/pdp8.cpp",
--		MAME_DIR .. "src/devices/cpu/pdp8/pdp8.h",
	}
end

if opt_tool(CPUS, "PDP8") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pdp8/pdp8dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pdp8/pdp8dasm.h")
end

--------------------------------------------------
-- F8
--@src/devices/cpu/f8/f8.h,CPUS["F8"] = true
--------------------------------------------------

if CPUS["F8"] then
	files {
--		MAME_DIR .. "src/devices/cpu/f8/f8.cpp",
--		MAME_DIR .. "src/devices/cpu/f8/f8.h",
	}
end

if opt_tool(CPUS, "F8") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/f8/f8dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/f8/f8dasm.h")
end

--------------------------------------------------
-- Intel MCS-40
--@src/devices/cpu/mcs40/mcs40.h,CPUS["MCS40"] = true
--------------------------------------------------

if CPUS["MCS40"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mcs40/mcs40.cpp",
--		MAME_DIR .. "src/devices/cpu/mcs40/mcs40.h",
	}
end

if opt_tool(CPUS, "MCS40") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs40/mcs40dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs40/mcs40dasm.h")
end

--------------------------------------------------
-- Intel 8008
--@src/devices/cpu/i8008/i8008.h,CPUS["I8008"] = true
--------------------------------------------------

if CPUS["I8008"] then
	files {
--		MAME_DIR .. "src/devices/cpu/i8008/i8008.cpp",
--		MAME_DIR .. "src/devices/cpu/i8008/i8008.h",
	}
end

if opt_tool(CPUS, "I8008") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8008/8008dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8008/8008dasm.h")
end

--------------------------------------------------
--  National Semiconductor SC/MP
--@src/devices/cpu/scmp/scmp.h,CPUS["SCMP"] = true
--------------------------------------------------

if CPUS["SCMP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/scmp/scmp.cpp",
--		MAME_DIR .. "src/devices/cpu/scmp/scmp.h",
	}
end

if opt_tool(CPUS, "SCMP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/scmp/scmpdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/scmp/scmpdasm.h")
end

--------------------------------------------------
-- Intel 8080/8085A
--@src/devices/cpu/i8085/i8085.h,CPUS["I8085"] = true
--------------------------------------------------

if CPUS["I8085"] then
	files {
		MAME_DIR .. "src/devices/cpu/i8085/i8085.cpp",
		MAME_DIR .. "src/devices/cpu/i8085/i8085.h",
	}
end

if opt_tool(CPUS, "I8085") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8085/8085dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8085/8085dasm.h")
end

--------------------------------------------------
-- Intel 8089
--@src/devices/cpu/i8089/i8089.h,CPUS["I8089"] = true
--------------------------------------------------

if CPUS["I8089"] then
	files {
--		MAME_DIR .. "src/devices/cpu/i8089/i8089.cpp",
--		MAME_DIR .. "src/devices/cpu/i8089/i8089.h",
--		MAME_DIR .. "src/devices/cpu/i8089/i8089_channel.cpp",
--		MAME_DIR .. "src/devices/cpu/i8089/i8089_channel.h",
--		MAME_DIR .. "src/devices/cpu/i8089/i8089_ops.cpp",
	}
end

if opt_tool(CPUS, "I8089") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8089/i8089_dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/i8089/i8089_dasm.h")
end

--------------------------------------------------
-- Intel MCS-48 (8039 and derivatives)
--@src/devices/cpu/mcs48/mcs48.h,CPUS["MCS48"] = true
--------------------------------------------------

if CPUS["MCS48"] then
	files {
		MAME_DIR .. "src/devices/cpu/mcs48/mcs48.cpp",
		MAME_DIR .. "src/devices/cpu/mcs48/mcs48.h",
	}
end

if opt_tool(CPUS, "MCS48") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs48/mcs48dsm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs48/mcs48dsm.h")
end

--------------------------------------------------
-- Intel 8051 and derivatives
--@src/devices/cpu/mcs51/mcs51.h,CPUS["MCS51"] = true
--------------------------------------------------

if CPUS["MCS51"] then
	files {
		MAME_DIR .. "src/devices/cpu/mcs51/mcs51.cpp",
		MAME_DIR .. "src/devices/cpu/mcs51/mcs51.h",
		MAME_DIR .. "src/devices/cpu/mcs51/mcs51ops.hxx",
	}
end

if opt_tool(CPUS, "MCS51") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs51/mcs51dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mcs51/mcs51dasm.h")
end

--------------------------------------------------
-- KL1839VM1
--@src/devices/cpu/mpk1839/kl1839vm1.h,CPUS["KL1839VM1"] = true
--------------------------------------------------

if CPUS["KL1839VM1"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mpk1839/kl1839vm1.cpp",
--		MAME_DIR .. "src/devices/cpu/mpk1839/kl1839vm1.h",
	}
end

if opt_tool(CPUS, "KL1839VM1") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mpk1839/kl1839vm1dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mpk1839/kl1839vm1dasm.h")
end

--------------------------------------------------
-- MOS Technology 6502 and its many derivatives
--@src/devices/cpu/m6502/deco16.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/gew7.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/gew12.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m3745x.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m37640.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m4510.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m50734.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m5074x.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6500_1.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6502.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6503.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6504.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6507.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6509.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6510.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m6510t.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m65ce02.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m65c02.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m65sc02.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m740.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m7501.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/m8502.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/r65c02.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/r65c19.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/rp2a03.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/st2xxx.h,CPUS["ST2XXX"] = true
--@src/devices/cpu/m6502/st2204.h,CPUS["ST2XXX"] = true
--@src/devices/cpu/m6502/st2205u.h,CPUS["ST2XXX"] = true
--@src/devices/cpu/m6502/w65c02s.h,CPUS["M6502"] = true
--@src/devices/cpu/m6502/xavix.h,CPUS["XAVIX"] = true
--@src/devices/cpu/m6502/xavix.h,CPUS["XAVIX2000"] = true

--------------------------------------------------

if CPUS["M6502"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m6502/deco16.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/deco16.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m3745x.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m3745x.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m37640.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m37640.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m4510.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m4510.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m50734.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m50734.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m5074x.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m5074x.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6500_1.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6500_1.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6502.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6502.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6502mcu.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6502mcu.ipp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6503.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6503.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6504.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6504.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6507.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6507.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6509.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6509.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6510.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6510.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m6510t.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m6510t.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m65c02.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m65c02.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m65ce02.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m65ce02.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m65sc02.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m65sc02.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m740.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m740.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m7501.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m7501.h",
--		MAME_DIR .. "src/devices/cpu/m6502/m8502.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/m8502.h",
--		MAME_DIR .. "src/devices/cpu/m6502/r65c02.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/r65c02.h",
--		MAME_DIR .. "src/devices/cpu/m6502/r65c19.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/r65c19.h",
--		MAME_DIR .. "src/devices/cpu/m6502/w65c02s.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/w65c02s.h",
	}

	custombuildtask {
--		{ MAME_DIR .. "src/devices/cpu/m6502/odeco16.lst",  GEN_DIR .. "emu/cpu/m6502/deco16.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/ddeco16.lst"  }, {"@echo Generating deco16 instruction source file...", PYTHON .. " $(1) s deco16 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om4510.lst",   GEN_DIR .. "emu/cpu/m6502/m4510.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm4510.lst"   }, {"@echo Generating m4510 instruction source file...", PYTHON .. " $(1) s m4510 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om6502.lst",   GEN_DIR .. "emu/cpu/m6502/m6502.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6502.lst"   }, {"@echo Generating m6502 instruction source file...", PYTHON .. " $(1) s m6502 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om65c02.lst",  GEN_DIR .. "emu/cpu/m6502/m65c02.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm65c02.lst"  }, {"@echo Generating m65c02 instruction source file...", PYTHON .. " $(1) s m65c02 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om65ce02.lst", GEN_DIR .. "emu/cpu/m6502/m65ce02.hxx", { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm65ce02.lst" }, {"@echo Generating m65ce02 instruction source file...", PYTHON .. " $(1) s m65ce02 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om6509.lst",   GEN_DIR .. "emu/cpu/m6502/m6509.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6509.lst"   }, {"@echo Generating m6509 instruction source file...", PYTHON .. " $(1) s m6509 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om6510.lst",   GEN_DIR .. "emu/cpu/m6502/m6510.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6510.lst"   }, {"@echo Generating m6510 instruction source file...", PYTHON .. " $(1) s m6510 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/om740.lst" ,   GEN_DIR .. "emu/cpu/m6502/m740.hxx",    { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm740.lst"    }, {"@echo Generating m740 instruction source file...", PYTHON .. " $(1) s m740 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/dr65c02.lst",  GEN_DIR .. "emu/cpu/m6502/r65c02.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",                                                     }, {"@echo Generating r65c02 instruction source file...", PYTHON .. " $(1) s r65c02 - $(<) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/or65c19.lst",  GEN_DIR .. "emu/cpu/m6502/r65c19.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dr65c19.lst"  }, {"@echo Generating r65c19 instruction source file...", PYTHON .. " $(1) s r65c19 $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/orp2a03.lst",  GEN_DIR .. "emu/cpu/m6502/rp2a03.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/drp2a03.lst"  }, {"@echo Generating rp2a03 instruction source file...", PYTHON .. " $(1) s rp2a03_core $(<) $(2) $(@)" }},
--		{ MAME_DIR .. "src/devices/cpu/m6502/ow65c02s.lst", GEN_DIR .. "emu/cpu/m6502/w65c02s.hxx", { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dw65c02s.lst" }, {"@echo Generating w65c02s instruction source file...", PYTHON .. " $(1) s w65c02s $(<) $(2) $(@)" }},
	}

	dependency {
--		{ MAME_DIR .. "src/devices/cpu/m6502/deco16.cpp",   GEN_DIR .. "emu/cpu/m6502/deco16.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m4510.cpp",    GEN_DIR .. "emu/cpu/m6502/m4510.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m6502.cpp",    GEN_DIR .. "emu/cpu/m6502/m6502.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m6509.cpp",    GEN_DIR .. "emu/cpu/m6502/m6509.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m6510.cpp",    GEN_DIR .. "emu/cpu/m6502/m6510.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m65c02.cpp",   GEN_DIR .. "emu/cpu/m6502/m65c02.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m65ce02.cpp",  GEN_DIR .. "emu/cpu/m6502/m65ce02.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/m740.cpp",     GEN_DIR .. "emu/cpu/m6502/m740.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/r65c02.cpp",   GEN_DIR .. "emu/cpu/m6502/r65c02.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/r65c19.cpp",   GEN_DIR .. "emu/cpu/m6502/r65c19.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/rp2a03.cpp",   GEN_DIR .. "emu/cpu/m6502/rp2a03.hxx" },
--		{ MAME_DIR .. "src/devices/cpu/m6502/w65c02s.cpp",  GEN_DIR .. "emu/cpu/m6502/w65c02s.hxx" },
	}
end

if CPUS["ST2XXX"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m6502/st2xxx.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/st2xxx.h",
--		MAME_DIR .. "src/devices/cpu/m6502/st2204.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/st2204.h",
--		MAME_DIR .. "src/devices/cpu/m6502/st2205u.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/st2205u.h",
	}
end

if CPUS["XAVIX"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m6502/xavix.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/xavix.h",
	}

	custombuildtask {
--		{ MAME_DIR .. "src/devices/cpu/m6502/oxavix.lst",   GEN_DIR .. "emu/cpu/m6502/xavix.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dxavix.lst"   }, {"@echo Generating xavix instruction source file...", PYTHON .. " $(1) s xavix $(<) $(2) $(@)" }},
	}

	dependency {
--		{ MAME_DIR .. "src/devices/cpu/m6502/xavix.cpp",    GEN_DIR .. "emu/cpu/m6502/xavix.hxx" },
	}
end

if CPUS["XAVIX2000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m6502/xavix2000.cpp",
--		MAME_DIR .. "src/devices/cpu/m6502/xavix2000.h",
	}

	custombuildtask {
--		{ MAME_DIR .. "src/devices/cpu/m6502/oxavix2000.lst",   GEN_DIR .. "emu/cpu/m6502/xavix2000.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dxavix2000.lst"   }, {"@echo Generating xavix2000 instruction source file...", PYTHON .. " $(1) s xavix2000 $(<) $(2) $(@)" }},
	}

	dependency {
--		{ MAME_DIR .. "src/devices/cpu/m6502/xavix2000.cpp",    GEN_DIR .. "emu/cpu/m6502/xavix2000.hxx" },
	}
end

if opt_tool(CPUS, "M6502") then
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/odeco16.lst",  GEN_DIR .. "emu/cpu/m6502/deco16d.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/ddeco16.lst"  }, {"@echo Generating deco16 disassembler source file...", PYTHON .. " $(1) d deco16 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om4510.lst",   GEN_DIR .. "emu/cpu/m6502/m4510d.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm4510.lst"   }, {"@echo Generating m4510 disassembler source file...", PYTHON .. " $(1) d m4510 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om6502.lst",   GEN_DIR .. "emu/cpu/m6502/m6502d.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6502.lst"   }, {"@echo Generating m6502 disassembler source file...", PYTHON .. " $(1) d m6502 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om65c02.lst",  GEN_DIR .. "emu/cpu/m6502/m65c02d.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm65c02.lst"  }, {"@echo Generating m65c02 disassembler source file...", PYTHON .. " $(1) d m65c02 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om65ce02.lst", GEN_DIR .. "emu/cpu/m6502/m65ce02d.hxx", { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm65ce02.lst" }, {"@echo Generating m65ce02 disassembler source file...", PYTHON .. " $(1) d m65ce02 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om6509.lst",   GEN_DIR .. "emu/cpu/m6502/m6509d.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6509.lst"   }, {"@echo Generating m6509 disassembler source file...", PYTHON .. " $(1) d m6509 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om6510.lst",   GEN_DIR .. "emu/cpu/m6502/m6510d.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm6510.lst"   }, {"@echo Generating m6510 disassembler source file...", PYTHON .. " $(1) d m6510 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/om740.lst" ,   GEN_DIR .. "emu/cpu/m6502/m740d.hxx",    { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dm740.lst"    }, {"@echo Generating m740 disassembler source file...", PYTHON .. " $(1) d m740 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/dr65c02.lst",  GEN_DIR .. "emu/cpu/m6502/r65c02d.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",                                                     }, {"@echo Generating r65c02 disassembler source file...", PYTHON .. " $(1) d r65c02 - $(<) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/or65c19.lst",  GEN_DIR .. "emu/cpu/m6502/r65c19d.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dr65c19.lst"  }, {"@echo Generating r65c19 disassembler source file...", PYTHON .. " $(1) d r65c19 $(<) $(2) $(@)" }})
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/orp2a03.lst",  GEN_DIR .. "emu/cpu/m6502/rp2a03d.hxx",  { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/drp2a03.lst"  }, {"@echo Generating rp2a03 disassembler source file...", PYTHON .. " $(1) d rp2a03 $(<) $(2) $(@)" }})

--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/deco16d.cpp",   GEN_DIR .. "emu/cpu/m6502/deco16d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m4510d.cpp",    GEN_DIR .. "emu/cpu/m6502/m4510d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m6502d.cpp",    GEN_DIR .. "emu/cpu/m6502/m6502d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m6509d.cpp",    GEN_DIR .. "emu/cpu/m6502/m6509d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m6510d.cpp",    GEN_DIR .. "emu/cpu/m6502/m6510d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m65c02d.cpp",   GEN_DIR .. "emu/cpu/m6502/m65c02d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m65ce02d.cpp",  GEN_DIR .. "emu/cpu/m6502/m65ce02d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/m740d.cpp",     GEN_DIR .. "emu/cpu/m6502/m740d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/r65c02d.cpp",   GEN_DIR .. "emu/cpu/m6502/r65c02d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/r65c19d.cpp",   GEN_DIR .. "emu/cpu/m6502/r65c19d.hxx" })
--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/rp2a03d.cpp",   GEN_DIR .. "emu/cpu/m6502/rp2a03d.hxx" })

--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/deco16d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/deco16d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m4510d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m4510d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6502d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6502d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6509d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6509d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6510d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m6510d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m65c02d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m65c02d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m65ce02d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m65ce02d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m740d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/m740d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/r65c02d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/r65c02d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/r65c19d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/r65c19d.h")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/rp2a03d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/rp2a03d.h")
end

if opt_tool(CPUS, "XAVIX") then
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/oxavix.lst",   GEN_DIR .. "emu/cpu/m6502/xavixd.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dxavix.lst"   }, {"@echo Generating xavix disassembler source file...", PYTHON .. " $(1) d xavix $(<) $(2) $(@)" }})

--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/xavixd.cpp",    GEN_DIR .. "emu/cpu/m6502/xavixd.hxx" })

--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/xavixd.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/xavixd.h")
end

if opt_tool(CPUS, "XAVIX2000") then
--	table.insert(disasm_custombuildtask, { MAME_DIR .. "src/devices/cpu/m6502/oxavix2000.lst",   GEN_DIR .. "emu/cpu/m6502/xavix2000d.hxx",   { MAME_DIR .. "src/devices/cpu/m6502/m6502make.py",   MAME_DIR  .. "src/devices/cpu/m6502/dxavix2000.lst"   }, {"@echo Generating xavix2000 disassembler source file...", PYTHON .. " $(1) d xavix2000 $(<) $(2) $(@)" }})

--	table.insert(disasm_dependency, { MAME_DIR .. "src/devices/cpu/m6502/xavix2000d.cpp",    GEN_DIR .. "emu/cpu/m6502/xavix2000d.hxx" })

--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/xavix2000d.cpp")
--	table.insert(disasm_files, MAME_DIR .. "src/devices/cpu/m6502/xavix2000d.h")
end

--------------------------------------------------
-- Motorola 680x
--@src/devices/cpu/m6800/m6800.h,CPUS["M6800"] = true
--@src/devices/cpu/m6800/m6801.h,CPUS["M6800"] = true
--------------------------------------------------

if CPUS["M6800"] then
	files {
		MAME_DIR .. "src/devices/cpu/m6800/m6800.cpp",
		MAME_DIR .. "src/devices/cpu/m6800/m6800.h",
		MAME_DIR .. "src/devices/cpu/m6800/m6801.cpp",
		MAME_DIR .. "src/devices/cpu/m6800/m6801.h",
		MAME_DIR .. "src/devices/cpu/m6800/6800ops.hxx",
	}
end

if opt_tool(CPUS, "M6800") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6800/6800dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6800/6800dasm.h")
end

--------------------------------------------------
-- Motorola 6805
--@src/devices/cpu/m6805/m6805.h,CPUS["M6805"] = true
--------------------------------------------------

if CPUS["M6805"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m6805/m6805.cpp",
--		MAME_DIR .. "src/devices/cpu/m6805/m6805.h",
--		MAME_DIR .. "src/devices/cpu/m6805/m6805defs.h",
--		MAME_DIR .. "src/devices/cpu/m6805/6805ops.hxx",
--		MAME_DIR .. "src/devices/cpu/m6805/m68705.cpp",
--		MAME_DIR .. "src/devices/cpu/m6805/m68705.h",
--		MAME_DIR .. "src/devices/cpu/m6805/m68hc05.cpp",
--		MAME_DIR .. "src/devices/cpu/m6805/m68hc05.h",
--		MAME_DIR .. "src/devices/cpu/m6805/m68hc05e1.cpp",
--		MAME_DIR .. "src/devices/cpu/m6805/m68hc05e1.h",
	}
end

if opt_tool(CPUS, "M6805") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6805/6805dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6805/6805dasm.h")
end

--------------------------------------------------
-- Motorola 6809
--@src/devices/cpu/m6809/m6809.h,CPUS["M6809"] = true
--@src/devices/cpu/m6809/hd6309.h,CPUS["M6809"] = true
--@src/devices/cpu/m6809/konami.h,CPUS["M6809"] = true
--------------------------------------------------

if CPUS["M6809"] then
	files {
		MAME_DIR .. "src/devices/cpu/m6809/m6809.cpp",
		MAME_DIR .. "src/devices/cpu/m6809/m6809.h",
		MAME_DIR .. "src/devices/cpu/m6809/hd6309.cpp",
		MAME_DIR .. "src/devices/cpu/m6809/hd6309.h",
		MAME_DIR .. "src/devices/cpu/m6809/konami.cpp",
		MAME_DIR .. "src/devices/cpu/m6809/konami.h",
		MAME_DIR .. "src/devices/cpu/m6809/m6809inl.h",
	}

	dependency {
		{ MAME_DIR .. "src/devices/cpu/m6809/m6809.cpp",   GEN_DIR .. "emu/cpu/m6809/m6809.hxx" },
		{ MAME_DIR .. "src/devices/cpu/m6809/hd6309.cpp",  GEN_DIR .. "emu/cpu/m6809/hd6309.hxx" },
		{ MAME_DIR .. "src/devices/cpu/m6809/konami.cpp",  GEN_DIR .. "emu/cpu/m6809/konami.hxx" },
	}

	custombuildtask {
		{ MAME_DIR .. "src/devices/cpu/m6809/m6809.lst"  , GEN_DIR .. "emu/cpu/m6809/m6809.hxx",   { MAME_DIR .. "src/devices/cpu/m6809/m6809make.py"  , MAME_DIR .. "src/devices/cpu/m6809/base6x09.lst"  }, {"@echo Generating m6809 source file...", PYTHON .. " $(1) $(<) > $(@)" }},
		{ MAME_DIR .. "src/devices/cpu/m6809/hd6309.lst" , GEN_DIR .. "emu/cpu/m6809/hd6309.hxx",  { MAME_DIR .. "src/devices/cpu/m6809/m6809make.py"  , MAME_DIR .. "src/devices/cpu/m6809/base6x09.lst"  }, {"@echo Generating hd6309 source file...", PYTHON .. " $(1) $(<) > $(@)" }},
		{ MAME_DIR .. "src/devices/cpu/m6809/konami.lst" , GEN_DIR .. "emu/cpu/m6809/konami.hxx",  { MAME_DIR .. "src/devices/cpu/m6809/m6809make.py"  , MAME_DIR .. "src/devices/cpu/m6809/base6x09.lst"  }, {"@echo Generating konami source file...", PYTHON .. " $(1) $(<) > $(@)" }},
	}
end

if opt_tool(CPUS, "M6809") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6809/6x09dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m6809/6x09dasm.h")
end

--------------------------------------------------
-- Motorola 68HC11
--@src/devices/cpu/mc68hc11/mc68hc11.h,CPUS["MC68HC11"] = true
--------------------------------------------------

if CPUS["MC68HC11"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mc68hc11/mc68hc11.cpp",
--		MAME_DIR .. "src/devices/cpu/mc68hc11/mc68hc11.h",
--		MAME_DIR .. "src/devices/cpu/mc68hc11/hc11ops.h",
--		MAME_DIR .. "src/devices/cpu/mc68hc11/hc11ops.hxx",
	}
end

if opt_tool(CPUS, "MC68HC11") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mc68hc11/hc11dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mc68hc11/hc11dasm.h")
end

--------------------------------------------------
-- Motorola 68000 series
--@src/devices/cpu/m68000/m68000.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/m68008.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/m68010.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/m68020.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/m68030.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/m68040.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/scc68070.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/fscpu32.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/mcf5206e.h,CPUS["M680X0"] = true
--@src/devices/cpu/m68000/tmp68301.h,CPUS["M680X0"] = true
--------------------------------------------------

if CPUS["M680X0"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m68000/m68kcpu.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kcpu.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kops.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kops.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kfpu.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kmmu.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kmusashi.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kcommon.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68kcommon.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000.lst",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000gen.py",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-decode.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-head.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-sdf.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-sif.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-sdp.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000-sip.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu-head.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu-sdfm.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu-sifm.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu-sdpm.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu-sipm.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000mcu.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008-head.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008-sdf8.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008-sif8.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008-sdp8.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008-sip8.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68008.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000musashi.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68000musashi.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68010.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68010.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68020.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68020.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68030.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68030.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/m68040.h",
--		MAME_DIR .. "src/devices/cpu/m68000/m68040.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/scc68070.h",
--		MAME_DIR .. "src/devices/cpu/m68000/scc68070.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/fscpu32.h",
--		MAME_DIR .. "src/devices/cpu/m68000/fscpu32.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/mcf5206e.h",
--		MAME_DIR .. "src/devices/cpu/m68000/mcf5206e.cpp",
--		MAME_DIR .. "src/devices/cpu/m68000/tmp68301.h",
--		MAME_DIR .. "src/devices/cpu/m68000/tmp68301.cpp",
	}
end

if opt_tool(CPUS, "M680X0") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m68000/m68kdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m68000/m68kdasm.h")
end


--------------------------------------------------
-- PDP-1
--@src/devices/cpu/pdp1/pdp1.h,CPUS["PDP1"] = true
--------------------------------------------------

if CPUS["PDP1"] then
	files {
--		MAME_DIR .. "src/devices/cpu/pdp1/pdp1.cpp",
--		MAME_DIR .. "src/devices/cpu/pdp1/pdp1.h",
	}
end

if opt_tool(CPUS, "PDP1") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pdp1/pdp1dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pdp1/pdp1dasm.h")
end

--------------------------------------------------
-- Matsushita (Panasonic) MN1400
--@src/devices/cpu/mn1400/mn1400.h,CPUS["MN1400"] = true
--------------------------------------------------

if CPUS["MN1400"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mn1400/mn1400base.cpp",
--		MAME_DIR .. "src/devices/cpu/mn1400/mn1400base.h",
--		MAME_DIR .. "src/devices/cpu/mn1400/mn1400.cpp",
--		MAME_DIR .. "src/devices/cpu/mn1400/mn1400.h",
--		MAME_DIR .. "src/devices/cpu/mn1400/mn1400op.cpp",
	}
end

if opt_tool(CPUS, "MN1400") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1400/mn1400d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1400/mn1400d.h")
end

--------------------------------------------------
-- Panafacom MN1610, disassembler only
--@src/devices/cpu/mn1610/mn1610d.h,CPUS["MN1610"] = true
--------------------------------------------------

if opt_tool(CPUS, "MN1610") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1610/mn1610d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1610/mn1610d.h")
end

--------------------------------------------------
-- Panasonic MN1880
--@src/devices/cpu/mn1880/mn1880.h,CPUS["MN1880"] = true
--------------------------------------------------

if CPUS["MN1880"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mn1880/mn1880.cpp",
--		MAME_DIR .. "src/devices/cpu/mn1880/mn1880.h",
	}
end

if opt_tool(CPUS, "MN1880") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1880/mn1880d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn1880/mn1880d.h")
end

--------------------------------------------------
-- Panasonic MN10200
--@src/devices/cpu/mn10200/mn10200.h,CPUS["MN10200"] = true
--------------------------------------------------

if CPUS["MN10200"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mn10200/mn10200.cpp",
--		MAME_DIR .. "src/devices/cpu/mn10200/mn10200.h",
	}
end

if opt_tool(CPUS, "MN10200") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn10200/mn102dis.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mn10200/mn102dis.h")
end

--------------------------------------------------
-- Texas Instruments TMS99xx series
--@src/devices/cpu/tms9900/tms9900.h,CPUS["TMS9900"] = true
--@src/devices/cpu/tms9900/tms9980a.h,CPUS["TMS9900"] = true
--@src/devices/cpu/tms9900/tms9995.h,CPUS["TMS9900"] = true
--@src/devices/cpu/tms9900/ti990_10.h,CPUS["TMS9900"] = true
--------------------------------------------------

if CPUS["TMS9900"] then
	files {
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9900.cpp",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9900.h",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9980a.cpp",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9980a.h",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9995.cpp",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms9995.h",
--		MAME_DIR .. "src/devices/cpu/tms9900/ti990_10.cpp",
--		MAME_DIR .. "src/devices/cpu/tms9900/ti990_10.h",
--		MAME_DIR .. "src/devices/cpu/tms9900/tms99com.h",
	}
end

if opt_tool(CPUS, "TMS9900") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/tms9900/9900dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/tms9900/9900dasm.h")
end

--------------------------------------------------
-- Zilog Z80
--@src/devices/cpu/z80/z80.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/tmpz84c011.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/tmpz84c015.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/ez80.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/lz8420m.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/mc8123.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/nsc800.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/r800.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/z84c015.h,CPUS["Z80"] = true
--@src/devices/cpu/z80/z80n.h,CPUS["Z80N"] = true
--@src/devices/cpu/z80/kc82.h,CPUS["KC80"] = true
--@src/devices/cpu/z80/kl5c80a12.h,CPUS["KC80"] = true
--@src/devices/cpu/z80/kl5c80a16.h,CPUS["KC80"] = true
--@src/devices/cpu/z80/ky80.h,CPUS["KC80"] = true
--------------------------------------------------

if CPUS["Z80"] or CPUS["KC80"] or CPUS["Z80N"] then
	files {
		MAME_DIR .. "src/devices/cpu/z80/z80.cpp",
		MAME_DIR .. "src/devices/cpu/z80/z80.h",
		MAME_DIR .. "src/devices/cpu/z80/tmpz84c011.cpp",
		MAME_DIR .. "src/devices/cpu/z80/tmpz84c011.h",
		MAME_DIR .. "src/devices/cpu/z80/tmpz84c015.cpp",
		MAME_DIR .. "src/devices/cpu/z80/tmpz84c015.h",
		MAME_DIR .. "src/devices/cpu/z80/ez80.cpp",
		MAME_DIR .. "src/devices/cpu/z80/ez80.h",
		MAME_DIR .. "src/devices/cpu/z80/lz8420m.cpp",
		MAME_DIR .. "src/devices/cpu/z80/lz8420m.h",
		MAME_DIR .. "src/devices/cpu/z80/mc8123.cpp",
		MAME_DIR .. "src/devices/cpu/z80/mc8123.h",
		MAME_DIR .. "src/devices/cpu/z80/nsc800.cpp",
		MAME_DIR .. "src/devices/cpu/z80/nsc800.h",
		MAME_DIR .. "src/devices/cpu/z80/r800.cpp",
		MAME_DIR .. "src/devices/cpu/z80/r800.h",
		MAME_DIR .. "src/devices/cpu/z80/z84c015.cpp",
		MAME_DIR .. "src/devices/cpu/z80/z84c015.h",
	}

	dependency {
		{ MAME_DIR .. "src/devices/cpu/z80/z80.cpp", GEN_DIR .. "emu/cpu/z80/z80.hxx" },
		{ MAME_DIR .. "src/devices/cpu/z80/nsc800.cpp", GEN_DIR .. "emu/cpu/z80/ncs800.hxx" },
		{ MAME_DIR .. "src/devices/cpu/z80/r800.cpp", GEN_DIR .. "emu/cpu/z80/r800.hxx" },
	}

	custombuildtask {
		{ MAME_DIR .. "src/devices/cpu/z80/z80.lst", GEN_DIR .. "emu/cpu/z80/z80.hxx", { MAME_DIR .. "src/devices/cpu/z80/z80make.py" }, { "@echo Generating Z80 source file...",   PYTHON .. "  $(1) $(<) $(@)" } },
		{ MAME_DIR .. "src/devices/cpu/z80/z80.lst", GEN_DIR .. "emu/cpu/z80/ncs800.hxx", { MAME_DIR .. "src/devices/cpu/z80/z80make.py" }, { "@echo Generating NSC800 source file...",   PYTHON .. " $(1) ncs800 $(<) $(@)" } },
		{ MAME_DIR .. "src/devices/cpu/z80/z80.lst", GEN_DIR .. "emu/cpu/z80/r800.hxx", { MAME_DIR .. "src/devices/cpu/z80/z80make.py" }, { "@echo Generating R800 source file...",   PYTHON .. "  $(1) r800 $(<) $(@)" } },
	}
end

if CPUS["Z80N"] then
	files {
		MAME_DIR .. "src/devices/cpu/z80/z80n.cpp",
		MAME_DIR .. "src/devices/cpu/z80/z80n.h",
	}

	dependency {
		{ MAME_DIR .. "src/devices/cpu/z80/z80n.cpp", GEN_DIR .. "emu/cpu/z80/z80n.hxx" },
	}

	custombuildtask {
		{ MAME_DIR .. "src/devices/cpu/z80/z80.lst", GEN_DIR .. "emu/cpu/z80/z80n.hxx", { MAME_DIR .. "src/devices/cpu/z80/z80make.py" }, { "@echo Generating Z80N source file...",   PYTHON .. "  $(1) z80n $(<) $(@)" } },
	}
end

if CPUS["KC80"] then
	files {
		MAME_DIR .. "src/devices/cpu/z80/kc82.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kc82.h",
		MAME_DIR .. "src/devices/cpu/z80/kl5c80a12.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kl5c80a12.h",
		MAME_DIR .. "src/devices/cpu/z80/kl5c80a16.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kl5c80a16.h",
		MAME_DIR .. "src/devices/cpu/z80/kp63.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kp63.h",
		MAME_DIR .. "src/devices/cpu/z80/kp64.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kp64.h",
		MAME_DIR .. "src/devices/cpu/z80/kp69.cpp",
		MAME_DIR .. "src/devices/cpu/z80/kp69.h",
		MAME_DIR .. "src/devices/cpu/z80/ky80.cpp",
		MAME_DIR .. "src/devices/cpu/z80/ky80.h",
	}
end

local want_disasm_z80  = opt_tool(CPUS, "Z80")
local want_disasm_kc80 = opt_tool(CPUS, "KC80")

if want_disasm_z80 or want_disasm_kc80 then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/r800dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/r800dasm.h")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/z80dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/z80dasm.h")
end

if opt_tool(CPUS, "Z80N") then
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/z80ndasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/z80dasm.cpp")
	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z80/z80ndasm.h")
end

--------------------------------------------------
-- Zilog Z180
--@src/devices/cpu/z180/z180.h,CPUS["Z180"] = true
--------------------------------------------------

if CPUS["Z180"] then
	files {
--		MAME_DIR .. "src/devices/cpu/z180/hd647180x.cpp",
--		MAME_DIR .. "src/devices/cpu/z180/hd647180x.h",
--		MAME_DIR .. "src/devices/cpu/z180/z180.cpp",
--		MAME_DIR .. "src/devices/cpu/z180/z180.h",
--		MAME_DIR .. "src/devices/cpu/z180/z180cb.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180dd.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180ed.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180fd.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180op.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180xy.hxx",
--		MAME_DIR .. "src/devices/cpu/z180/z180ops.h",
--		MAME_DIR .. "src/devices/cpu/z180/z180tbl.h",
--		MAME_DIR .. "src/devices/cpu/z180/z180asci.cpp",
--		MAME_DIR .. "src/devices/cpu/z180/z180asci.h",
--		MAME_DIR .. "src/devices/cpu/z180/z180csio.cpp",
--		MAME_DIR .. "src/devices/cpu/z180/z180csio.h",
	}
end

if opt_tool(CPUS, "Z180") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z180/z180dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z180/z180dasm.h")
end

--------------------------------------------------
-- Zilog Z8000
--@src/devices/cpu/z8000/z8000.h,CPUS["Z8000"] = true
--------------------------------------------------

if CPUS["Z8000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/z8000/z8000.cpp",
--		MAME_DIR .. "src/devices/cpu/z8000/z8000.h",
--		--MAME_DIR .. "src/devices/cpu/z8000/makedab.cpp",
--		MAME_DIR .. "src/devices/cpu/z8000/z8000cpu.h",
--		MAME_DIR .. "src/devices/cpu/z8000/z8000dab.h",
--		MAME_DIR .. "src/devices/cpu/z8000/z8000ops.hxx",
--		MAME_DIR .. "src/devices/cpu/z8000/z8000tbl.hxx",
	}
end

if opt_tool(CPUS, "Z8000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z8000/8000dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z8000/8000dasm.h")
end

--------------------------------------------------
-- Zilog Z8
--@src/devices/cpu/z8/z8.h,CPUS["Z8"] = true
--------------------------------------------------

if CPUS["Z8"] then
	files {
--		MAME_DIR .. "src/devices/cpu/z8/z8.cpp",
--		MAME_DIR .. "src/devices/cpu/z8/z8.h",
--		MAME_DIR .. "src/devices/cpu/z8/z8ops.hxx",
	}
end

if opt_tool(CPUS, "Z8") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z8/z8dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/z8/z8dasm.h")
end

--------------------------------------------------
-- Argonaut SuperFX
--@src/devices/cpu/superfx/superfx.h,CPUS["SUPERFX"] = true
--------------------------------------------------

if CPUS["SUPERFX"] then
	files {
--		MAME_DIR .. "src/devices/cpu/superfx/superfx.cpp",
--		MAME_DIR .. "src/devices/cpu/superfx/superfx.h",
	}
end

if opt_tool(CPUS, "SUPERFX") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/superfx/sfx_dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/superfx/sfx_dasm.h")
end

--------------------------------------------------
-- Rockwell A/B5000 family
--@src/devices/cpu/rw5000/a5000.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/a5500.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/a5900.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/b5000.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/b5500.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/b6000.h,CPUS["RW5000"] = true
--@src/devices/cpu/rw5000/b6100.h,CPUS["RW5000"] = true
--------------------------------------------------

if CPUS["RW5000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/rw5000/rw5000base.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/rw5000base.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/b5000.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/b5000.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/b5000op.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/b5500.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/b5500.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/b6000.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/b6000.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/b6100.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/b6100.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5000.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5000.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5500.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5500.h",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5900.cpp",
--		MAME_DIR .. "src/devices/cpu/rw5000/a5900.h",
	}
end

if opt_tool(CPUS, "RW5000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rw5000/rw5000d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rw5000/rw5000d.h")
end

--------------------------------------------------
-- Rockwell PPS-4
--@src/devices/cpu/pps4/pps4.h,CPUS["PPS4"] = true
--------------------------------------------------

if CPUS["PPS4"] then
	files {
--		MAME_DIR .. "src/devices/cpu/pps4/pps4.cpp",
--		MAME_DIR .. "src/devices/cpu/pps4/pps4.h",
	}
end

if opt_tool(CPUS, "PPS4") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pps4/pps4dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pps4/pps4dasm.h")
end

--------------------------------------------------
-- Rockwell PPS-4/1
--@src/devices/cpu/pps41/mm75.h,CPUS["PPS41"] = true
--@src/devices/cpu/pps41/mm76.h,CPUS["PPS41"] = true
--@src/devices/cpu/pps41/mm78.h,CPUS["PPS41"] = true
--@src/devices/cpu/pps41/mm78la.h,CPUS["PPS41"] = true
--------------------------------------------------

if CPUS["PPS41"] then
	files {
--		MAME_DIR .. "src/devices/cpu/pps41/pps41base.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/pps41base.h",
--		MAME_DIR .. "src/devices/cpu/pps41/mm75.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm75.h",
--		MAME_DIR .. "src/devices/cpu/pps41/mm75op.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm76.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm76.h",
--		MAME_DIR .. "src/devices/cpu/pps41/mm76op.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78.h",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78op.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78la.cpp",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78la.h",
--		MAME_DIR .. "src/devices/cpu/pps41/mm78laop.cpp",
	}
end

if opt_tool(CPUS, "PPS41") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pps41/pps41d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pps41/pps41d.h")
end

--------------------------------------------------
-- Hitachi HD61700
--@src/devices/cpu/hd61700/hd61700.h,CPUS["HD61700"] = true
--------------------------------------------------

if CPUS["HD61700"] then
	files {
--		MAME_DIR .. "src/devices/cpu/hd61700/hd61700.cpp",
--		MAME_DIR .. "src/devices/cpu/hd61700/hd61700.h",
	}
end

if opt_tool(CPUS, "HD61700") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hd61700/hd61700d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hd61700/hd61700d.h")
end

--------------------------------------------------
-- Sanyo LC8670
--@src/devices/cpu/lc8670/lc8670.h,CPUS["LC8670"] = true
--------------------------------------------------

if CPUS["LC8670"] then
	files {
--		MAME_DIR .. "src/devices/cpu/lc8670/lc8670.cpp",
--		MAME_DIR .. "src/devices/cpu/lc8670/lc8670.h",
	}
end

if opt_tool(CPUS, "LC8670") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc8670/lc8670dsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc8670/lc8670dsm.h")
end

--------------------------------------------------
-- Sega SCU DSP
--@src/devices/cpu/scudsp/scudsp.h,CPUS["SCUDSP"] = true
--------------------------------------------------

if CPUS["SCUDSP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/scudsp/scudsp.cpp",
--		MAME_DIR .. "src/devices/cpu/scudsp/scudsp.h",
	}
end

if opt_tool(CPUS, "SCUDSP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/scudsp/scudspdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/scudsp/scudspdasm.h")
end

--------------------------------------------------
-- Sunplus Technology S+core
--@src/devices/cpu/score/score.h,CPUS["SCORE"] = true
--------------------------------------------------

if CPUS["SCORE"] then
	files {
--		MAME_DIR .. "src/devices/cpu/score/score.cpp",
--		MAME_DIR .. "src/devices/cpu/score/score.h",
--		MAME_DIR .. "src/devices/cpu/score/scorem.h",
	}
end

if opt_tool(CPUS, "SCORE") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/score/scoredsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/score/scoredsm.h")
end

--------------------------------------------------
-- Xerox Alto-II
--@src/devices/cpu/alto2/alto2cpu.h,CPUS["ALTO2"] = true
--------------------------------------------------

if CPUS["ALTO2"] then
	files {
--		MAME_DIR .. "src/devices/cpu/alto2/alto2cpu.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/alto2cpu.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2disk.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2disk.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2disp.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2disp.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2curt.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2curt.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dht.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dht.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dvt.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dvt.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dwt.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2dwt.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2emu.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2emu.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ether.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ether.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2hw.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2hw.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2kbd.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2kbd.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ksec.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ksec.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2kwd.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2kwd.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mem.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mem.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mouse.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mouse.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mrt.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2mrt.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2part.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2part.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ram.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2ram.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2roms.cpp",
--		MAME_DIR .. "src/devices/cpu/alto2/a2roms.h",
--		MAME_DIR .. "src/devices/cpu/alto2/a2jkff.h",
	}
end

if opt_tool(CPUS, "ALTO2") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/alto2/alto2dsm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/alto2/alto2dsm.h")
end

------------------------------------------
-- Sun SPARCv7, SPARCv8 implementation
--@src/devices/cpu/sparc/sparc.h,CPUS["SPARC"] = true
--------------------------------------------------

if CPUS["SPARC"] then
	files {
--		MAME_DIR .. "src/devices/cpu/sparc/sparc.cpp",
--		MAME_DIR .. "src/devices/cpu/sparc/sparcdefs.h",
--		MAME_DIR .. "src/devices/cpu/sparc/sparc_intf.h",
--		MAME_DIR .. "src/devices/cpu/sparc/sparc.h",
	}
end

if opt_tool(CPUS, "SPARC") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sparc/sparcdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sparc/sparcdasm.h")
end

--------------------------------------------------
-- Intergraph CLIPPER (C100/C300/C400) series
--@src/devices/cpu/clipper/clipper.h,CPUS["CLIPPER"] = true
--------------------------------------------------

if CPUS["CLIPPER"] then
	files {
--		MAME_DIR .. "src/devices/cpu/clipper/clipper.cpp",
--		MAME_DIR .. "src/devices/cpu/clipper/clipper.h",
	}
end

if opt_tool(CPUS, "CLIPPER") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/clipper/clipperd.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/clipper/clipperd.h")
end


--------------------------------------------------
-- VM Labs Nuon, disassembler only
--------------------------------------------------

if opt_tool(CPUS, "NUON") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nuon/nuondasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nuon/nuondasm.h")
end

--------------------------------------------------
-- DEC Alpha (EV4/EV5/EV6/EV7) series
--@src/devices/cpu/alpha/alpha.h,CPUS["ALPHA"] = true
--------------------------------------------------

if CPUS["ALPHA"] then
	files {
--		MAME_DIR .. "src/devices/cpu/alpha/alpha.cpp",
--		MAME_DIR .. "src/devices/cpu/alpha/alpha.h",
	}
end

if opt_tool(CPUS, "ALPHA") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/alpha/alphad.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/alpha/alphad.h")
end

--------------------------------------------------
-- Hewlett-Packard HP2100 (disassembler only)
--@src/devices/cpu/hp2100/hp2100.h,CPUS["HP2100"] = true
--------------------------------------------------

if opt_tool(CPUS, "HP2100") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hp2100/hp2100d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hp2100/hp2100d.h")
end

--------------------------------------------------
-- SDS Sigma 2 (disassembler only)
--@src/devices/cpu/sigma2/sigma2.h,CPUS["SIGMA2"] = true
--------------------------------------------------

if opt_tool(CPUS, "SIGMA2") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sigma2/sigma2d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/sigma2/sigma2d.h")
end

--------------------------------------------------
-- Control Data Corporation 1700 (disassembler only)
--@src/devices/cpu/cdc1700/cdc1700.h,CPUS["CDC1700"] = true
--------------------------------------------------

if opt_tool(CPUS, "CDC1700") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cdc1700/cdc1700d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cdc1700/cdc1700d.h")
end

--------------------------------------------------
-- National Semiconductor HPC
--@src/devices/cpu/hpc/hpc.h,CPUS["HPC"] = true
--------------------------------------------------

if CPUS["HPC"] then
	files {
--		MAME_DIR .. "src/devices/cpu/hpc/hpc.cpp",
--		MAME_DIR .. "src/devices/cpu/hpc/hpc.h",
	}
end

if opt_tool(CPUS, "HPC") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hpc/hpcdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/hpc/hpcdasm.h")
end

--------------------------------------------------
-- Yamaha SWP30
--@src/devices/sound/swp30.h,CPUS["SWP30"] = true
--------------------------------------------------

if CPUS["SWP30"] then
	files {
	}
end

if opt_tool(CPUS, "SWP30") then
end

--------------------------------------------------
-- Yamaha DSPV
--@src/devices/sound/dspv.h,CPUS["DSPV"] = true
--------------------------------------------------

if CPUS["DSPV"] then
	files {
	}
end

if opt_tool(CPUS, "DSPV") then
end

--------------------------------------------------
--  National Semiconductor NS32000 series
--@src/devices/cpu/ns32000/ns32000.h,CPUS["NS32000"] = true
--------------------------------------------------

if CPUS["NS32000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/ns32000/ns32000.cpp",
--		MAME_DIR .. "src/devices/cpu/ns32000/ns32000.h",
--		MAME_DIR .. "src/devices/cpu/ns32000/common.h",
	}
end

if opt_tool(CPUS, "NS32000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ns32000/ns32000d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ns32000/ns32000d.h")
end

--------------------------------------------------
-- Elan RISC II series
--@src/devices/cpu/rii/riscii.h,CPUS["RII"] = true
--------------------------------------------------

if CPUS["RII"] then
	files {
--		MAME_DIR .. "src/devices/cpu/rii/riscii.cpp",
--		MAME_DIR .. "src/devices/cpu/rii/riscii.h",
	}
end

if opt_tool(CPUS, "RII") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rii/riidasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rii/riidasm.h")
end

--------------------------------------------------
-- National Semiconductor BCP
--@src/devices/cpu/bcp/dp8344.h,CPUS["BCP"] = true
--------------------------------------------------

if CPUS["BCP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/bcp/dp8344.cpp",
--		MAME_DIR .. "src/devices/cpu/bcp/dp8344.h",
	}
end

if opt_tool(CPUS, "BCP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/bcp/bcpdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/bcp/bcpdasm.h")
end

--------------------------------------------------
-- Fujitsu F2MC-16 series
--@src/devices/cpu/f2mc16/f2mc16.h,CPUS["F2MC16"] = true
--------------------------------------------------

if CPUS["F2MC16"] then
	files {
--		MAME_DIR .. "src/devices/cpu/f2mc16/f2mc16.cpp",
--		MAME_DIR .. "src/devices/cpu/f2mc16/f2mc16.h",
--		MAME_DIR .. "src/devices/cpu/f2mc16/mb9061x.cpp",
--		MAME_DIR .. "src/devices/cpu/f2mc16/mb9061x.h",
	}
end

if opt_tool(CPUS, "F2MC16") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/f2mc16/f2mc16d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/f2mc16/f2mc16d.h")
end

--------------------------------------------------
-- National Semiconductor CR16B
--@src/devices/cpu/cr16b/cr16b.h,CPUS["CR16B"] = true
--------------------------------------------------

if CPUS["CR16B"] then
	files {
--		MAME_DIR .. "src/devices/cpu/cr16b/cr16b.cpp",
--		MAME_DIR .. "src/devices/cpu/cr16b/cr16b.h",
	}
end

if opt_tool(CPUS, "CR16B") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cr16b/cr16bdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cr16b/cr16bdasm.h")
end

--------------------------------------------------
-- National Semiconductor CR16C, disassembler only
--------------------------------------------------

if opt_tool(CPUS, "CR16C") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cr16c/cr16cdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/cr16c/cr16cdasm.h")
end

--------------------------------------------------
-- Motorola DSP56000
--@src/devices/cpu/dsp56000/dsp56000.h,CPUS["DSP56000"] = true
--------------------------------------------------

if CPUS["DSP56000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/dsp56000/dsp56000.cpp",
--		MAME_DIR .. "src/devices/cpu/dsp56000/dsp56000.h",
	}
end

if opt_tool(CPUS, "DSP56000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp56000/dsp56000d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/dsp56000/dsp56000d.h")
end

--------------------------------------------------
-- DEC VAX, disassembler only
--@src/devices/cpu/vax/vax.h,CPUS["VAX"] = true
--------------------------------------------------

if opt_tool(CPUS, "VAX") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vax/vaxdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vax/vaxdasm.h")
end

--------------------------------------------------
-- DEC VT50/VT52
--@src/devices/cpu/vt50/vt50.h,CPUS["VT50"] = true
--------------------------------------------------

if CPUS["VT50"] then
	files {
--		MAME_DIR .. "src/devices/cpu/vt50/vt50.cpp",
--		MAME_DIR .. "src/devices/cpu/vt50/vt50.h",
	}
end

if opt_tool(CPUS, "VT50") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vt50/vt50dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vt50/vt50dasm.h")
end

--------------------------------------------------
-- DEC VT61
--@src/devices/cpu/vt61/vt61.h,CPUS["VT61"] = true
--------------------------------------------------

if CPUS["VT61"] then
	files {
--		MAME_DIR .. "src/devices/cpu/vt61/vt61.cpp",
--		MAME_DIR .. "src/devices/cpu/vt61/vt61.h",
	}
end

if opt_tool(CPUS, "VT61") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vt61/vt61dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/vt61/vt61dasm.h")
end

--------------------------------------------------
-- National Semiconductor PACE/INS8900
--@src/devices/cpu/pace/pace.h,CPUS["PACE"] = true
--------------------------------------------------

if CPUS["PACE"] then
	files {
--		MAME_DIR .. "src/devices/cpu/pace/pace.cpp",
--		MAME_DIR .. "src/devices/cpu/pace/pace.h",
	}
end

if opt_tool(CPUS, "PACE") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pace/pacedasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/pace/pacedasm.h")
end

--------------------------------------------------
-- AT&T WE32000/WE32100/WE32200
--@src/devices/cpu/we32000/we32100.h,CPUS["WE32000"] = true
--------------------------------------------------

if CPUS["WE32000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/we32000/we32100.cpp",
--		MAME_DIR .. "src/devices/cpu/we32000/we32100.h",
	}
end

if opt_tool(CPUS, "WE32000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/we32000/we32100d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/we32000/we32100d.h")
end

--------------------------------------------------
-- DEC RX01
--@src/devices/cpu/rx01/rx01.h,CPUS["RX01"] = true
--------------------------------------------------

if CPUS["RX01"] then
	files {
--		MAME_DIR .. "src/devices/cpu/rx01/rx01.cpp",
--		MAME_DIR .. "src/devices/cpu/rx01/rx01.h",
	}
end

if opt_tool(CPUS, "RX01") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rx01/rx01dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/rx01/rx01dasm.h")
end

--------------------------------------------------
-- Motorola M88000
--@src/devices/cpu/m88000/m88000.h,CPUS["M88000"] = true
--------------------------------------------------

if CPUS["M88000"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m88000/m88000.cpp",
--		MAME_DIR .. "src/devices/cpu/m88000/m88000.h",
	}
end

if opt_tool(CPUS, "M88000") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m88000/m88000d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m88000/m88000d.h")
end

--------------------------------------------------
-- XAVIX2
--@src/devices/cpu/xavix2/xavix2.h,CPUS["XAVIX2"] = true
--------------------------------------------------

if CPUS["XAVIX2"] then
	files {
--		MAME_DIR .. "src/devices/cpu/xavix2/xavix2.cpp",
--		MAME_DIR .. "src/devices/cpu/xavix2/xavix2.h",
	}
end

if opt_tool(CPUS, "XAVIX2") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xavix2/xavix2d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xavix2/xavix2d.h")
end

--------------------------------------------------
-- NEC 78K
--@src/devices/cpu/upd78k/upd78k0.h,CPUS["UPD78K"] = true
--@src/devices/cpu/upd78k/upd78k2.h,CPUS["UPD78K"] = true
--@src/devices/cpu/upd78k/upd78k3.h,CPUS["UPD78K"] = true
--@src/devices/cpu/upd78k/upd78k4.h,CPUS["UPD78K"] = true
--------------------------------------------------

if CPUS["UPD78K"] then
	files {
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k0.cpp",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k0.h",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k2.cpp",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k2.h",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k3.cpp",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k3.h",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k4.cpp",
--		MAME_DIR .. "src/devices/cpu/upd78k/upd78k4.h",
	}
end

if opt_tool(CPUS, "UPD78K") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78kd.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78kd.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k0d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k0d.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k1d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k1d.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k1d.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k2d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k2d.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k3d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k3d.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k4d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd78k/upd78k4d.h")
end

--------------------------------------------------
-- IBM ROMP
--@src/devices/cpu/romp/romp.h,CPUS["ROMP"] = true
--------------------------------------------------

if CPUS["ROMP"] then
	files {
--		MAME_DIR .. "src/devices/cpu/romp/romp.cpp",
--		MAME_DIR .. "src/devices/cpu/romp/romp.h",
--		MAME_DIR .. "src/devices/cpu/romp/rsc.h",
	}
end

if opt_tool(CPUS, "ROMP") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/romp/rompdasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/romp/rompdasm.h")
end

--------------------------------------------------
-- KS0164
--@src/devices/cpu/ks0164/ks0164.h,CPUS["KS0164"] = true
--------------------------------------------------

if CPUS["KS0164"] then
	files {
--		MAME_DIR .. "src/devices/cpu/ks0164/ks0164.cpp",
--		MAME_DIR .. "src/devices/cpu/ks0164/ks0164.h",
	}
end

if opt_tool(CPUS, "KS0164") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ks0164/ks0164d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ks0164/ks0164d.h")
end

--------------------------------------------------
-- uPD177x - Disassembler only
--@src/devices/cpu/upd177x/upd177x.h,CPUS["UPD177X"] = true
--------------------------------------------------

if opt_tool(CPUS, "UPD177X") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd177x/upd177xd.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/upd177x/upd177xd.h")
end

--------------------------------------------------
-- Sanyo LC58 - Disassembler only
--@src/devices/cpu/lc58/lc58.h,CPUS["LC58"] = true
--------------------------------------------------

if opt_tool(CPUS, "LC58") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc58/lc58d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc58/lc58d.h")
end

--------------------------------------------------
-- OKI MSM6502/6512 - Disassembler only
--@src/devices/cpu/msm65x2/msm65x2.h,CPUS["MSM65X2"] = true
--------------------------------------------------

if opt_tool(CPUS, "MSM65X2") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/msm65x2/msm65x2d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/msm65x2/msm65x2d.h")
end

--------------------------------------------------
-- Sanyo LC57 - Disassembler only
--@src/devices/cpu/lc57/lc57.h,CPUS["LC57"] = true
--------------------------------------------------

if opt_tool(CPUS, "LC57") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc57/lc57d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/lc57/lc57d.h")
end

--------------------------------------------------
-- Mark I (Andrew Holme)
--@src/devices/cpu/mk1/mk1.h,CPUS["MK1"] = true
--------------------------------------------------

if CPUS["MK1"] then
	files {
--		MAME_DIR .. "src/devices/cpu/mk1/mk1.cpp",
--		MAME_DIR .. "src/devices/cpu/mk1/mk1.h",
	}
end

if opt_tool(CPUS, "MK1") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mk1/mk1dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/mk1/mk1dasm.h")
end

--------------------------------------------------
-- Motorola M68HC16 (CPU16)
--@src/devices/cpu/m68hc16/cpu16.h,CPUS["M68HC16"] = true
--------------------------------------------------

if CPUS["M68HC16"] then
	files {
--		MAME_DIR .. "src/devices/cpu/m68hc16/cpu16.cpp",
--		MAME_DIR .. "src/devices/cpu/m68hc16/cpu16.h",
--		MAME_DIR .. "src/devices/cpu/m68hc16/m68hc16z.cpp",
--		MAME_DIR .. "src/devices/cpu/m68hc16/m68hc16z.h",
	}
end

if opt_tool(CPUS, "M68HC16") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m68hc16/cpu16dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/m68hc16/cpu16dasm.h")
end

--------------------------------------------------
-- Varian 620, disassembler only
--------------------------------------------------

if opt_tool(CPUS, "V620") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/v620/v620dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/v620/v620dasm.h")
end

--------------------------------------------------
-- Altera Nios II
--@src/devices/cpu/nios2/nios2.h,CPUS["NIOS2"] = true
--------------------------------------------------

if CPUS["NIOS2"] then
	files {
--		MAME_DIR .. "src/devices/cpu/nios2/nios2.cpp",
--		MAME_DIR .. "src/devices/cpu/nios2/nios2.h",
	}
end

if opt_tool(CPUS, "NIOS2") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nios2/nios2dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nios2/nios2dasm.h")
end

--------------------------------------------------
-- IBM 1800, disassembler only
--@src/devices/cpu/ibm1800/ibm1800.h,CPUS["IBM1800"] = true
--------------------------------------------------

if opt_tool(CPUS, "IBM1800") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ibm1800/ibm1800d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ibm1800/ibm1800d.h")
end

--------------------------------------------------
-- Data General Nova, disassembler only
--@src/devices/cpu/nova/nova.h,CPUS["NOVA"] = true
--------------------------------------------------

if opt_tool(CPUS, "NOVA") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nova/novadasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/nova/novadasm.h")
end

--------------------------------------------------
-- Interdata Series 16, disassembler only
--@src/devices/cpu/interdata16/interdata16.h,CPUS["INTERDATA16"] = true
--------------------------------------------------

if opt_tool(CPUS, "INTERDATA16") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/interdata16/dasm16.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/interdata16/dasm16.h")
end

--------------------------------------------------
-- SGS-Thomson ST9
--@src/devices/cpu/st9/st905x.h,CPUS["ST9"] = true
--------------------------------------------------

if CPUS["ST9"] then
	files {
--		MAME_DIR .. "src/devices/cpu/st9/st905x.cpp",
--		MAME_DIR .. "src/devices/cpu/st9/st905x.h",
	}
end

if opt_tool(CPUS, "ST9") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/st9/st9dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/st9/st9dasm.h")
end

--------------------------------------------------
-- 3C/Honeywell DDP-516, disassembler only
--@src/devices/cpu/ddp516/ddp516.h,CPUS["DDP516"] = true
--------------------------------------------------

if opt_tool(CPUS, "DDP516") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ddp516/ddp516d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ddp516/ddp516d.h")
end

--------------------------------------------------
-- Whatever is in the Evolution
--@src/devices/cpu/evolution/evo.h,CPUS["EVOLUTION"] = true
--------------------------------------------------

if CPUS["EVOLUTION"] then
	files {
--		MAME_DIR .. "src/devices/cpu/evolution/evo.cpp",
--		MAME_DIR .. "src/devices/cpu/evolution/evo.h",
	}
end

if opt_tool(CPUS, "EVOLUTION") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/evolution/evod.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/evolution/evod.h")
end

--------------------------------------------------
-- Tensilica Xtensa
--@src/devices/cpu/xtensa/xtensa.h,CPUS["XTENSA"] = true
--------------------------------------------------

if CPUS["XTENSA"] then
	files {
--		MAME_DIR .. "src/devices/cpu/xtensa/xtensa.cpp",
--		MAME_DIR .. "src/devices/cpu/xtensa/xtensa.h",
--		MAME_DIR .. "src/devices/cpu/xtensa/xtensa_helper.cpp",
--		MAME_DIR .. "src/devices/cpu/xtensa/xtensa_helper.h",
	}
end

if opt_tool(CPUS, "XTENSA") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xtensa/xtensad.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xtensa/xtensad.h")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xtensa/xtensa_helper.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/xtensa/xtensa_helper.h")
end

--------------------------------------------------
-- Holtek HT1130
--@src/devices/cpu/ht1130/ht1130.h,CPUS["HT1130"] = true
--------------------------------------------------

if CPUS["HT1130"] then
	files {
--		MAME_DIR .. "src/devices/cpu/ht1130/ht1130.cpp",
--		MAME_DIR .. "src/devices/cpu/ht1130/ht1130.h",
	}
end

if opt_tool(CPUS, "HT1130") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ht1130/ht1130d.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/ht1130/ht1130d.h")
end

--------------------------------------------------
-- Epson C33 STD, C33 ADV, etc.
--@src/devices/cpu/c33/c33common.h,CPUS["C33"] = true
--------------------------------------------------

if CPUS["C33"] then
	files {
--		MAME_DIR .. "src/devices/cpu/c33/c33common.h",
--		MAME_DIR .. "src/devices/cpu/c33/c33helpers.ipp",
--		MAME_DIR .. "src/devices/cpu/c33/c33std.cpp",
--		MAME_DIR .. "src/devices/cpu/c33/c33std.h",
--		MAME_DIR .. "src/devices/cpu/c33/s1c33209.cpp",
--		MAME_DIR .. "src/devices/cpu/c33/s1c33209.h",
	}
end

if opt_tool(CPUS, "C33") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/c33/c33dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/c33/c33dasm.h")
end

--------------------------------------------------
-- IBM PALM
--@src/devices/cpu/palm/palm.h,CPUS["PALM"] = true
--------------------------------------------------

if CPUS["PALM"] then
	files {
--		MAME_DIR .. "src/devices/cpu/palm/palm.cpp",
--		MAME_DIR .. "src/devices/cpu/palm/palm.h",
	}
end

if opt_tool(CPUS, "PALM") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/palm/palmd.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/palm/palmd.h")
end

--------------------------------------------------
-- Oki OLMS-66K/nX-8 series
--@src/devices/cpu/olms66k/msm665xx.h,CPUS["OLMS66K"] = true
--------------------------------------------------

if CPUS["OLMS66K"] then
	files {
--		MAME_DIR .. "src/devices/cpu/olms66k/msm665xx.cpp",
--		MAME_DIR .. "src/devices/cpu/olms66k/msm665xx.h",
	}
end

if opt_tool(CPUS, "OLMS66K") then
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/olms66k/nx8dasm.cpp")
--	table.insert(disasm_files , MAME_DIR .. "src/devices/cpu/olms66k/nx8dasm.h")
end
