onerror {quit -f}
vlib work
vlog -work work speed_control.vo
vlog -work work speed_control.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.speed_control_vlg_vec_tst
vcd file -direction speed_control.msim.vcd
vcd add -internal speed_control_vlg_vec_tst/*
vcd add -internal speed_control_vlg_vec_tst/i1/*
add wave /*
run -all
