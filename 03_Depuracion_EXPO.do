*****************************************************
* DEPURACIÓN EXPORTACIONES
* UNIVERSIDAD PONTIFICIA BOLIVARIANA
*****************************************************

clear all
set more off

*****************************************************
* DIRECTORIO
* - Reemplazar por la ruta de ubicación de su directorio 
*****************************************************

cd "C:\Users\oztal\Desktop\Trabajo_Metodos_Cuantitativos"

*****************************************************
* CREAR LOG
*****************************************************

capture log close

log using "07_Logs\03_Depuracion_EXPO.smcl", replace

*****************************************************
* ABRIR BASE CONSOLIDADA
*****************************************************

use "02_Bases_Stata\expo_2025_consolidada.dta", clear

*****************************************************
* VERIFICAR DEPARTAMENTOS
*****************************************************

tab DPTO1

*****************************************************
* FILTRAR DEPARTAMENTOS
* 68 = Santander
* 76 = Valle del Cauca
*****************************************************

keep if DPTO1 == 68 | DPTO1 == 76

*****************************************************
* VERIFICAR FILTRO
*****************************************************

tab DPTO1

count

*****************************************************
* CONSERVAR VARIABLES RELEVANTES
*****************************************************

keep FECH DPTO1 PAIS POSAR VIA ADUA MODAD FOBDOL FOBPES CANTI

*****************************************************
* CREAR ETIQUETAS DEPARTAMENTO
*****************************************************

label define depto ///
68 "Santander" ///
76 "Valle del Cauca"

label values DPTO1 depto

*****************************************************
* CREAR VARIABLE MES
*****************************************************

gen MES = .

replace MES = 1 if FECH == 2501
replace MES = 2 if FECH == 2502
replace MES = 3 if FECH == 2503
replace MES = 4 if FECH == 2504
replace MES = 5 if FECH == 2505
replace MES = 6 if FECH == 2506
replace MES = 7 if FECH == 2507
replace MES = 8 if FECH == 2508
replace MES = 9 if FECH == 2509
replace MES = 10 if FECH == 2510
replace MES = 11 if FECH == 2511
replace MES = 12 if FECH == 2512

*****************************************************
* ETIQUETAS MESES
*****************************************************

label define meses ///
1 "Enero" ///
2 "Febrero" ///
3 "Marzo" ///
4 "Abril" ///
5 "Mayo" ///
6 "Junio" ///
7 "Julio" ///
8 "Agosto" ///
9 "Septiembre" ///
10 "Octubre" ///
11 "Noviembre" ///
12 "Diciembre"

label values MES meses

*****************************************************
* REVISIÓN GENERAL
*****************************************************

describe

summarize FOBDOL FOBPES CANTI

tab MES

*****************************************************
* GUARDAR BASE ANALÍTICA
*****************************************************

save "04_Resultados\expo_analitica_2025.dta", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "DEPURACIÓN FINALIZADA"
display "====================================="
