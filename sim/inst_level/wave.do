onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/iPREV_VALID
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/iPREV_PC
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/oDATAIO_REQ
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/oDATAIO_RW
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/oDATAIO_ADDR
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/oDATAIO_DATA
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/iDATAIO_REQ
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/iDATAIO_CACHE_HIT
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/iDATAIO_DATA
add wave -noupdate -radix hexadecimal /tb_inst_level/TARGET/CORE/CORE_PIPELINE/EXECUTE/load_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {535550 ps} 0}
configure wave -namecolwidth 135
configure wave -valuecolwidth 85
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {25586 ps} {772901 ps}
