onerror {quit -f}
vlib work
vlog -work work Faltungscodierer_Diagramm.vo
vlog -work work Faltungscodierer_Diagramm.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Faltungscodierer_Diagramm_vlg_vec_tst
vcd file -direction Faltungscodierer_Diagramm.msim.vcd
vcd add -internal Faltungscodierer_Diagramm_vlg_vec_tst/*
vcd add -internal Faltungscodierer_Diagramm_vlg_vec_tst/i1/*
add wave /*
run -all
