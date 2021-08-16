onerror {quit -f}
vlib work
vlog -work work bandpass.vo
vlog -work work bandpass.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.bandpass_vlg_vec_tst
vcd file -direction bandpass.msim.vcd
vcd add -internal bandpass_vlg_vec_tst/*
vcd add -internal bandpass_vlg_vec_tst/i1/*
add wave /*
run -all
