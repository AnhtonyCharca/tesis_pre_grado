*********ETIQUETANDO DATOS***************
label var rdap1 "Dispuesto a pagar: Inicial "
label define rdap1 1"Si" 0"No"
label values rdap1 rdap1
label var dap1 "Tarifa DAP inicial"
label define dap1 3"S/ 3.00" 5"S/ 5.00" 10"S/ 10.00" 15"S/15.00"
label values dap1 dap1
label var rdap2 "Dispuesto a pagar: Final"
label define rdap2 1"Si" 0"No"
label values rdap2 rdap2
label var dap2 "Tarifa DAP final"
label var VIU "¿Alguna vez usted visitó la isla de los Uros?"
label define VIU 1"Si" 0"No"
label values VIU VIU
label var VAPN "¿Suele visitar áreas protegidas o lugares de naturaleza?"
label define VAPN 1"Si" 0"No"
label values VAPN VAPN
label var CBP "¿Conoce usted la Bahía de Puno o ha oído hablar de ello?"
label define CBP 1"Si" 0"No"
label values CBP CBP
label var conamb "¿cree ud, nos falta conciencia ambiental?"
label define conamb 1"Si" 0"No"
label values conamb conamb
label var ECIVL "Estado Civil"
label define ECIVL 1"Soltero"	2"Casado o Conviviente" ///
3"Separado" 4" Divorciado"	5"Viudo"
label values ECIVL ECIVL
label var GEN "Sexo"
label define GEN 1"Hombre" 0"Mujer"
label values GEN GEN
label var cenlb "Centro de laboral"
label define cenlb 1"Sector Privado"	0"Sector Público"
label values cenlb cenlb 
label var EDU "Nivel de estudios"
label define EDU 1"Primaria" 2"Secundaria"	3"Universitario"	4"Post Grado"	5"Técnica superior"
label values EDU EDU
label var ING "Nivel de Ingreso"
label define ING 1"Menos de 1000" 2"Entre 1000 y 1999" ///
3"Entre 2000 y 2999" 4"Entre 3000 y 3999" ///
5"Entre 4000 y 4999" 6"Mayor de 5000"
label values ING ING
label var PROF "Area  de activad o profesión"
label define PROF 1"Ingeniería" 3"Ciencias de la Salud" ///
2"Ciencias Sociales" 4"Negocios - Empresa" 5"Agricultura / Ganadería / Pesca"
label values PROF PROF
label var RNDP "Razon por que no que no pagar más"
label define RNDP 1"No es mi responsabilidad" ///
2"No cuento con ingresos económicos suficientes" ///
3"El gobierno debe asumir esos daños" ///
4"No tengo confianza en el uso de los fondos recaudados" ///
5"Otros"
label value RNDP RNDP
label var EDAD "Edad"
label var NAC "Nacionalidad"
label define NAC 1"Peruano" 2"Latinoamerica" 3"Estados Unidos"
label values NAC NAC
label var NTF "Número total de Integrantes de la familia"
label values NTF
********************
gen rdob=. //Tabulacion de las respuestas dobe limite
replace rdob=1 if rdap1==1 & rdap2==1
replace rdob=2 if rdap1==1 & rdap2==0
replace rdob=3 if rdap1==0 & rdap2==1
replace rdob=4 if rdap1==0 & rdap2==0
lab def rdob 1"Si/Si" 2"Si/No"  3"No/Si" 4"No/No"

********************