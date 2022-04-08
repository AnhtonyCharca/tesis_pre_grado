clear all

global files "E:\Nueva carpeta (3)\TESIS"
global outp "E:\Nueva carpeta (3)\TESIS\outputs"
global grafics "E:\Nueva carpeta (3)\TESIS\graphs"
global dof "E:\Nueva carpeta (3)\TESIS\do"

cd "$files"

use "DATA\datatesis AAQCh.dta", clear

*ETIQUETANDO DATA
do "do\etiquetas graph tesis.do"

**GRAFICOS**
set scheme white_tableau

 splitvallabels RNDP
 graph bar, over(RNDP, label(labsize(medium)) relabel(`r(relabel)')) ///
	blabel(bar, format(%3.1f) size(medium) ) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall)) ///
	name(graph_01_rndp, replace) 

graph export "$grafics/graph_01_rndp.png", as(png) name("graph_01_rndp") replace

	
graph bar, over(VIU , label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_02_viu, replace) 
graph export "$grafics/graph_02_viu.png", as(png) name("graph_02_viu") replace

graph bar, over(CBP, label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_03_cbp, replace) 
graph export "$grafics/graph_03_cbp.png", as(png) name("graph_03_cbp") replace

graph bar, over(cenlb, label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_04_cenlb, replace) 
graph export "$grafics/graph_04_cenlb.png", as(png) name("graph_04_cenlb") replace

graph bar, over(GEN, label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_05_gen, replace) 
graph export "$grafics/graph_05_gen.png", as(png) name("graph_05_gen") replace
	
splitvallabels ING
 graph bar, over(ING, relabel(`r(relabel)') label(labsize(small)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_06_ing, replace) 
graph export "$grafics/graph_06_ing.png", as(png) name("graph_06_ing") replace

graph bar, over(rdap1, label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_07_rdap1, replace) 
graph export "$grafics/graph_07_rdap1.png", as(png) name("graph_07_rdap1") replace

graph bar, over(rdap2, label(labsize(medium)) ) ///
	blabel(bar, format(%3.1f) size(medium)) bar(1, color(blue)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	name(graph_08_rdap2, replace) 
graph export "$grafics/graph_08_rdap2.png", as(png) name("graph_08_rdap2") replace

cd "$outp"
tab dap1 rdap1, matcell(freq) matrow(names)
matrix list freq
matrix list names
putexcel set results2, replace
putexcel A1=("DAP inicial") B1=("Freq.") D1=("Percent")
putexcel B2=("NO") C2=("SI") D2=("NO") E2=("SI")
putexcel A3=matrix(names) B3=matrix(freq) D3=matrix(freq/r(N))

tab dap1 rdap2, matcell(freq) matrow(names)
putexcel F1=("DAP 2") G1=("Freq.") H1=("Percent")
putexcel F2=("NO") G2=("SI") H2=("NO") I2=("SI")
putexcel F3=matrix(freq) H3=matrix(freq/r(N))


use "DATA\frecuencia dap1-rdap1-rdap2.dta", clear
label var dap1 "Tarifa DAP inicial"
label define dap1 3"S/ 3.00" 5"S/ 5.00" 10"S/ 10.00" 15"S/ 15.00"
label values dap1 dap1
replace pd1si=100*pd1si
replace pd2si=100*pd2si

set scheme rainbow
graph bar pd1si pd2si, over(dap1, label(labsize(medium))) ///
	blabel(bar, format(%3.1f) size(medium)) ///
	bar(1, color(blue)) bar(2, color(orange)) ///
	ytitle("Porcentaje (%)", size(12pt)) ymtick(, labsize(medsmall))  ///
	bargap(-10) b2title("Tarifas DAP inicial", size(medium)) ///
	legend( label(1 "Si RDAP1") label(2 "Si RDAP2") size(medium)) ///
	name(graph_09_rdaps, replace) 
graph export "$grafics/graph_09_rdaps.png", as(png) name("graph_09_rdaps") replace





