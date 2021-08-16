onerror {quit -f}
vlib work
vlog -work work AlleFilter.vo
vlog -work work AlleFilter.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.AlleFilter_vlg_vec_tst
vcd file -direction AlleFilter.msim.vcd
vcd add -internal AlleFilter_vlg_vec_tst/*
vcd add -internal AlleFilter_vlg_vec_tst/i1/*
add wave /*
run -all
