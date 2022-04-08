clear all

global files "E:\Nueva carpeta (3)\TESIS"
global outp "E:\Nueva carpeta (3)\TESIS\outputs"
global grafics "E:\Nueva carpeta (3)\TESIS\graphs"
global dof "E:\Nueva carpeta (3)\TESIS\do"

cd "$files"

use "DATA\turistas.dta", clear

tsset año

twoway  (tsline total, lcolor(orange)) ///
		(tsline extr, lcolor(black)) ///
		(tsline nac, lcolor(black)) 