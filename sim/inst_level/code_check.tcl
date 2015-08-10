transcript file code_check.log
vlib work
vlog -work work +incdir+../../src/include +incdir+../../src/core/include ./tb/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../model/sim_memory_model/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../model/altera/*.v
vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/peripheral_interface_controller/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/lib/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/primitive/altera_primitive_sync_fifo_showahead_32in_32out_8depth/*.v

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/primitive/altera_primitive_sync_fifo_showahead_97in_97out_32depth/*.v

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/primitive/ram_512bit_16word/*.v

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/allocate/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/decode/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/execute/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/fetch/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/instruction_buffer/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/l1_data/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/l1_inst/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/pipeline_control/*.sv

vlog -work work +incdir+../../src/include +incdir+../../src/core/include ../../src/core/interrupt_control/*.sv
quit
