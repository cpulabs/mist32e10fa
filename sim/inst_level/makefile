####################################################################
# Simulator Target
####################################################################
default: modelsim_compile modelsim_sim_run sim_summary
#Wave
wave: modelsim_compile modelsim_sim_run_wave sim_summary

####################################################################



########## Modelsim ##########
modelsim_compile:
	python gen_tcl.py False ./sim_list.txt ../../com/src_list.txt ../../com/inc_list.txt code_check.log code_check.tcl
	vsim -do code_check.tcl

modelsim_sim_run:
	python sim_run.py False tb_inst_level sim_software.hex ./sim_list.txt ../../com/src_list.txt ../../com/inc_list.txt bin/
	
modelsim_sim_run_wave:
	python sim_run.py True tb_inst_level sim_software.hex ./sim_list.txt ../../com/src_list.txt ../../com/inc_list.txt bin/

########## Simulation Summary ##########
sim_summary:
	python sim_summary.py sim/
	
