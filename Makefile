DESIGN_FILES := defines.v $(shell find duv/modules -type f -name '*.v')
DESIGN_FILES += duv/topLevelCircuit.v
TESTBENCH_FILES := tb/package.sv tb/interface.sv tb/top.sv 

compile:
	vlib work
	vlog -coveropt 3 +cover=sbfec +acc -v $(DESIGN_FILES) $(TESTBENCH_FILES)

sim: compile
	vsim -vopt work.top -c -do run -all; exit"

cmd:	
	vcover report -verbose COV > report.txt

run_all: 
	compile sim cmd

clean:
	rm -rf work transcript vsim.wlf