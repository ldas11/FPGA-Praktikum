onerror {quit -f}
vlib work
vlog -work work tiefpass.vo
vlog -work work tiefpass.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.tiefpass_vlg_vec_tst
vcd file -direction tiefpass.msim.vcd
vcd add -internal tiefpass_vlg_vec_tst/*
vcd add -internal tiefpass_vlg_vec_tst/i1/*
add wave /*
run -all
