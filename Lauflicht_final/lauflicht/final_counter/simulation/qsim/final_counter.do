onerror {quit -f}
vlib work
vlog -work work final_counter.vo
vlog -work work final_counter.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.final_counter_vlg_vec_tst
vcd file -direction final_counter.msim.vcd
vcd add -internal final_counter_vlg_vec_tst/*
vcd add -internal final_counter_vlg_vec_tst/i1/*
add wave /*
run -all
