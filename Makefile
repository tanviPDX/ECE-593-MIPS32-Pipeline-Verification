DESIGN_FILES := defines.v $(shell find duv/modules -type f -name '*.v')
DESIGN_FILES += duv/topLevelCircuit.sv
TESTBENCH_FILES := tb/interface.sv tb/package.sv tb/top.sv 

compile:
	vlib work
	vlog -coveropt 3 +cover=sbfec +acc -v $(DESIGN_FILES) $(TESTBENCH_FILES)

sim: compile
	vsim -coverage -vopt work.top -c -do "coverage save -onexit -directive -cvg -codeall COV;run -all; exit"

cmd:	
	vcover report -verbose COV > report.txt
	vcover report -html COV

run_all: 
	compile sim cmd

clean:
	rm -rf work transcript vsim.wlf