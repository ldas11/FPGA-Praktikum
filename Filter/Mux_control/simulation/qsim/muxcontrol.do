onerror {quit -f}
vlib work
vlog -work work muxcontrol.vo
vlog -work work muxcontrol.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.muxcontrol_vlg_vec_tst
vcd file -direction muxcontrol.msim.vcd
vcd add -internal muxcontrol_vlg_vec_tst/*
vcd add -internal muxcontrol_vlg_vec_tst/i1/*
add wave /*
run -all
