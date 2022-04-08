clear all
global files "E:\Nueva carpeta (3)\TESIS"
global outp "E:\Nueva carpeta (3)\TESIS\outputs"
global grafics "E:\Nueva carpeta (3)\TESIS\graphs"
global dof "E:\Nueva carpeta (3)\TESIS\do"

cd "$files"
/* use "DATA\agua potable - no.dta"
input lugx
1
2
3
4
end

label var lugx "Zona, Puno"
label define lugx 1"Perú" 2"Departamento" 3"Provincia" 4"Distrito"
label values lugx lugx

graph bar lugx, over(total)

 graph bar total urbano rural, over(lugx) ///
	blabel(bar, format(%3.2f)) ///
	bar(1, color(red)) bar(2, color(blue)) bar(3, color(orange)) bar(4, color(green)) ///
	ytitle("Porcentaje (%)") ///
	name(graph_010_nagua, replace) 

*/

input tipo
1
2
3
end

label var tipo "Zona, Puno"
label define tipo 1"Total" 2"Urbano" 3"Rural"
label values tipo tipo

set scheme rainbow

graph bar lugx, over(total)
replace Perú =100*Perú 
replace departamento =departamento *100
replace provincia = 100*provincia
replace distrito = 100*distrito

 graph bar Perú departamento provincia distrito, over(tipo) ///
	blabel(bar, format(%3.2f) size(10pt))  ///
	bar(1, color(red)) bar(2, color(blue)) bar(3, color(green)) bar(4, color(orange)) ///
	ytitle("Porcentaje (%)" , size(10pt)) ///
	legend(label(1 "Perú") label(2 "Departamento Puno") label(3 "Provincia Puno") label(4 "Distrito Puno") size(10pt)) ///
	name(graph_010_nagua, replace) 

graph export "$grafics/graph_010_nagua.png", as(png) name("graph_010_nagua") replace