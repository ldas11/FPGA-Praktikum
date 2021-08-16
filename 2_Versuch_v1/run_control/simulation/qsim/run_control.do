onerror {quit -f}
vlib work
vlog -work work run_control.vo
vlog -work work run_control.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.run_control_vlg_vec_tst
vcd file -direction run_control.msim.vcd
vcd add -internal run_control_vlg_vec_tst/*
vcd add -internal run_control_vlg_vec_tst/i1/*
add wave /*
run -all
