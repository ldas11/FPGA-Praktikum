onerror {quit -f}
vlib work
vlog -work work Vergleich_Faltungscodierer.vo
vlog -work work Vergleich_Faltungscodierer.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Vergleich_Faltungscodierer_vlg_vec_tst
vcd file -direction Vergleich_Faltungscodierer.msim.vcd
vcd add -internal Vergleich_Faltungscodierer_vlg_vec_tst/*
vcd add -internal Vergleich_Faltungscodierer_vlg_vec_tst/i1/*
add wave /*
run -all
