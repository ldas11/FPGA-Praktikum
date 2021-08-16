onerror {quit -f}
vlib work
vlog -work work ZustandsdiagrammLAufzeiten.vo
vlog -work work ZustandsdiagrammLAufzeiten.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ZustandsdiagrammLAufzeiten_vlg_vec_tst
vcd file -direction ZustandsdiagrammLAufzeiten.msim.vcd
vcd add -internal ZustandsdiagrammLAufzeiten_vlg_vec_tst/*
vcd add -internal ZustandsdiagrammLAufzeiten_vlg_vec_tst/i1/*
add wave /*
run -all
