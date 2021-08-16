onerror {quit -f}
vlib work
vlog -work work hochpass.vo
vlog -work work hochpass.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.hochpass_vlg_vec_tst
vcd file -direction hochpass.msim.vcd
vcd add -internal hochpass_vlg_vec_tst/*
vcd add -internal hochpass_vlg_vec_tst/i1/*
add wave /*
run -all
