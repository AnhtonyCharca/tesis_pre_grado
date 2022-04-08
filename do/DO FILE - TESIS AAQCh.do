/*Universidad Nacionalidad del Altiplano
Facultad de Ingeniería Económica
Tesista: Alex Antoni Quispe Charca */

cd "E:\TESIS\DATA"
use "datatesis.dta" , clear
*keep n rdap1  dap1 rdap2 dap2 VIU CBP conamb cenlb  RNDP GEN  ING PROF NAC EDU ECIVL EDAD
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
label define cenlb 1"Sector Privado"	0"Sector Publico"
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
5"Otros especifique"
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

graph bar, over(rdob)
lab val rdob rdob
fre rdob
tab rdap1 rdap2
********************
*VARIABLES DEL MODELO FINAL
br n rdap1 dap1 rdap2 dap2 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
********************************
****DESCRIBCION DE VARIABLES
summarize
br n rdap1  dap1 rdap2 dap2 VIU CBP conamb cenlb  RNDP GEN  ING PROF NAC EDU ECIVL EDAD
*gen edad2=EDAD*EDAD
**cuadro 51: MEJOR MODELO: 
logit rdap2 rdap1 dap2 dap1 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
wtpcikr  rdap1 dap2 dap1 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF

logit rdap1 dap1 rdap2 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
linktest
wtpcikr dap1 rdap2 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
estimates store LOGIT1
stepwise, pr(0.1):logit rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
wtpcikr dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN ING
estimates store LOGIT2
stepwise, pr(0.05):logit rdap1 dap1 rdap2 VIU VAPN CBP conamb cenlb  RNDP GEN EDAD ed2 NAC PROF EDU ECIVL ING NTF
estimates store LOGIT3
wtpcikr dap1 rdap2 VIU cenlb CBP conamb
est tab LOGIT*, star(0.01 0.05 0.1) stat(r2_p, chi2 aic bic p ll N)
*cuadro 51: portafolio de modelos
outreg2 [LOG*] using portafolio_modelos, e(all) see excel replace 
sum rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING
logit  rdap1  dap1 rdap2 VIU CBP conamb cenlb GEN  ING , nolog
graph matrix rdap1  VIU CBP conamb cenlb  RNDP GEN  ING , half


***********************
*********DISCUSION
************************
***Media de variables independientes: rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING
egen dap1_m=mean(dap1)
egen rdap2_m=mean(rdap2 )
egen VIU_m=mean(VIU)
egen CBP_m =mean(CBP)
egen conamb_m =mean(conamb)
egen cenlb_m =mean(cenlb)
egen RNDP_m =mean(RNDP)
egen GEN_m =mean(GEN )
egen ING_m=mean(ING)
*******************************
**** HANEMAN 1984**************
*******************************

matrix define A=J(4,2,0)
matrix colname A= Logit Probit
matrix rowname A= Lineal_Simpleb Lineal_Doubled Semilog Exponencial

** UTILIDAD LINEAL

	**** LOGIT
	logit rdap1 dap1, nolog
	estimates store logit_lineal_simple
	wtpcikr dap1
	local lineal_logit1 = r(mean_WTP)
	matrix define A[1,1] = `lineal_logit1'
	**** LOGIT : LOG1
	 logit rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING , nolog
	 estimates store logit_lineal_simple_all
		wtpcikr dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING 
	local lineal_logit2 = r(mean_WTP)
	matrix define A[2,1] = `lineal_logit2'
	
	*** PROBIT

	probit rdap1 dap1, nolog
	estimates store probit_lineal_simple
	wtpcikr dap1
	local lineal_probit = r(mean_WTP)
	matrix define A[1,2] = `lineal_probit'
		**** PROBIT FULL
	 probit rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING , nolog
	estimates store probit_lineal_simple_all
		wtpcikr dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING 
	local lineal_lprobit2 = r(mean_WTP)
	matrix define A[2,2] = `lineal_lprobit2'

****UTILIDAD SEMILOG CON INGRESOS
*drop ing
gen ing=ING*950
	*gen ing = uniform()*6653+uniform()*102325
	sum ing

	gen bid1 = ln(1-(dap1/ing)) 

	**** LOGIT
	logit rdap1 bid1, nolog
	estimates store logit_semilog_simple
	gen wtp1 = ing*(1-exp(-_b[_cons]/_b[bid1]))
	
	ci mean wtp1 
	local semi_logit = r(mean)
	matrix define A[3,1] = `semi_logit'
	
	*** PROBIT
	probit rdap1 bid1, nolog
	estimates store probit_semilog_simple
	gen wtp2 = ing*(1-exp(-_b[_cons]/_b[bid1]))
	
	ci mean wtp2
	local semi_probit = r(mean)
	matrix define A[3,2] = `semi_probit'

	
****UTILIDAD EXPONENCIAL
	*drop bid2
	*gen bid2 = ln(dap1)
	
	**** LOGIT
	logit rdap1 bid2, nolog
	estimates store logit_expo_simple
	wtpcikr bid2, expo
	local expo_logit = r(median_WTP)
	matrix define A[4,1] = `expo_logit'
	*** PROBIT

	probit rdap1 bid2, nolog
	estimates store probit_expo_simple
	wtpcikr bid2, expo
	local expo_probit = r(median_WTP)
	matrix define A[4,2] = `expo_probit'
**** TABLA RESUMEN MODELO DE HANEMAN 1984
matlist A, border(rows) rowtitle("Hanemann (1984)") left(4)  twidth(15) format(%12.2f)

****************************************
********** CAMERON 1987 ****************
****************************************
matrix define C=J(3,3,0)
matrix colname C= Cameron1987 Haneman1991 Cameron1997
matrix rowname C= "Sin Ingreso" "Con Ingreso" "S/I_all" 

singleb dap1 rdap1
nlcom (DAP_doubled1 : (_b[_cons])), noheader
estimates store singleb1
matrix single1 = r(table)
local single_1= single1[1,1]
matrix define C[1,1] = `single_1'

egen ing_m=mean(ing)
singleb dap1 rdap1 ing
estimates store singleb2
nlcom (DAP_singleb2 : (_b[_cons]+_b[ing]*ing_m)), noheader
quietly nlcom (DAP_singleb2 : (_b[_cons]+_b[ing]*ing_m)), noheader post
matrix single2 = _b[DAP_singleb2] 
local single_2= single2[1,1]
matrix define C[2,1] = `single_2'

singleb dap1 rdap1 VIU CBP conamb cenlb  RNDP GEN  ING
estimates store singleb3
**Calculo de WTP, con los valores promedio de X's
nlcom (DAP_singleb : (_b[_cons]+_b[VIU]*VIU_m+_b[CBP]*CBP_m+_b[conamb]*conamb_m+_b[cenlb]*cenlb_m+_b[RNDP]*RNDP_m+_b[GEN]*GEN_m+_b[ING]*ING_m)), noheader
*****Para capturar en matriz*********
quietly nlcom (DAP_singleb : (_b[_cons]+_b[VIU]*VIU_m+_b[CBP]*CBP_m+_b[conamb]*conamb_m+_b[cenlb]*cenlb_m+_b[RNDP]*RNDP_m+_b[GEN]*GEN_m+_b[ING]*ING_m)), noheader post
matrix single3 = _b[DAP_singleb] 
local single_3= single3[1,1]
matrix define C[3,1] = `single_3'


****************************************
******* HANEMANN ET AL 1991 ************
****************************************

doubleb dap1 dap2 rdap1 rdap2
estimates store doubleb1
nlcom (DAP_doubled1 : (_b[_cons])), noheader
matrix Inter = r(table)
local interval= Inter[1,1]
matrix define C[1,2] = `interval'

doubleb dap1 dap2 rdap1 rdap2 ing
estimates store doubleb2
nlcom (DAP_doubled2 : (_b[_cons]+_b[ing]*ing_m)), noheader
quietly nlcom (DAP_doubled2 : (_b[_cons]+_b[ing]*ing_m)), noheader post
matrix doubled2 = _b[DAP_doubled2] 
local doubled_2= doubled2[1,1]
matrix define C[2,2] = `doubled_2'

doubleb dap1 dap2 rdap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING
estimates store doubleb3
**Calculo de WTP, con los valores promedio de X's
nlcom (WTP_ : (_b[_cons]+_b[VIU]*VIU_m+_b[CBP]*CBP_m+_b[conamb]*conamb_m+_b[cenlb]*cenlb_m+_b[RNDP]*RNDP_m+_b[GEN]*GEN_m+_b[ING]*ING_m)), noheader
****Para capturar en matriz*******
quietly nlcom (WTP_ : (_b[_cons]+_b[VIU]*VIU_m+_b[CBP]*CBP_m+_b[conamb]*conamb_m+_b[cenlb]*cenlb_m+_b[RNDP]*RNDP_m+_b[GEN]*GEN_m+_b[ING]*ING_m)), noheader post
matrix Inter2 = _b[WTP_] 
local interval2= Inter2[1,1]
matrix define C[3,2] = `interval2'


***************************************
************ CAMERON 1997 ************
**************************************

biprobit (rdap1 dap1)(rdap2 dap2), nolog
wtpcikr dap1
estimates store bivariado
local biprobit = r(mean_WTP)
matrix define C[1,3] = `biprobit'

biprobit (rdap1 ldap1)(rdap2 ldap2), nolog
estimates store bivariado_ex
wtpcikr ldap1, expo
local biprobit_expo = r(median_WTP)
matrix define C[2,3] = `biprobit_expo'

********************************************************
***************** TABLAS RESUMEN ***********************
********************************************************

matlist A, border(rows) rowtitle("Hanemann (1984)") left(4)  twidth(15) format(%12.2f)
matlist C, border(rows) rowtitle("WTP Estimadas") left(4)  twidth(17) format(%12.2f)

****
outreg2 [logit* probit*] using result1.xls, title("Contingente Simple")  excel word e(all) replace 

outreg2 [logit_ex probit_ex] using result2.xls, title("Contingente Simple - Exponencial") excel word e(all) replace 

outreg2 [bivariado bivariado_ex] using result3.xls, title("Contingente Doble - Bivariado")  ///
word  e(all) replace 

*outreg2 [single* doubleb*] using result4.xls, title("Singled& Doubled") excel word se adds(log likelihood, e(ll)) replace 
*****************************************************
*****************************************************
*****************************************************

************************
*****acciones auxiliares
************************
logit rdap1 dap1 rdap2 VIU CBP conamb cenlb  RNDP GEN  ING, nolog
gen MA=_b[_cons]+_b[VIU]*VIU+_b[CBP]*CBP+_b[rdap2]*rdap2+_b[conamb]*conamb +_b[cenlb]*cenlb+_b[RNDP]*RNDP+_b[GEN]*GEN+_b[ING]*ING
gen b=-_b[dap1]
gen DPAs=MA/b
//Cuadro 56: Media de la Disposición A Pagar
mean DPAs, level(95)
****GENERANDO LA VARIABLE DOBLE LIMITE
gen DIPS01=.
replace DIPS01=DAPM2
replace DIPS01=DAPM1 if DIPS01==.
gen mdap01=.
replace mdap01=DAPMX2
replace mdap01=DAPMX1 if mdap01==.
******ARMANDO EL MODELO DOBLE LIMITE
** PRIMER LIMITE: dips00 monto0
** Segundo Limite:DIPS01 MDAP
gen dap1=monto0
gen dap2=mdap01
gen rdap1=DIPS
gen rdap2=DIPS01
br DIPS rdap1 dips00
br dap1 monto0 dap2 mdap01 DAPMX1 DAPMX2 rdap1 DIPS dips00 rdap2 DIPS01 DAPM1 DAPM2
**************
/*Comandos postestimation logit
estat classification /*informe de varias estadísticas resumidas, incluida la tabla de clasificación*/
asdoc estat gof , replace /*prueba de bondad de ajuste de Pearson o Hosmer-Lemeshow*/
estat ic /* criterios de información bayesianos de Akaike y Schwarz (AIC y BIC)*/
asdoc linktest, append /*prueba de enlace para la especificación del modelo*/
asdoc mfx, dydx append /*efecto marginal*/ 
**********************/