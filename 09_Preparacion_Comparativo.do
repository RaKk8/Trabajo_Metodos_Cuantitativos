*****************************************************
* PREPARACIÓN BASE COMPARATIVA
* EXPORTACIONES VS IMPORTACIONES
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

log using "07_Logs\09_Preparacion_Comparativo.smcl", replace

*****************************************************
* =========================================
* EXPORTACIONES
* =========================================
*****************************************************

use "04_Resultados\expo_analitica_2025.dta", clear

*****************************************************
* HOMOLOGAR VARIABLES
*****************************************************

rename DPTO1 DEPARTAMENTO

rename FOBDOL VALOR

rename POSAR PRODUCTO

gen TIPO = "EXPORTACION"

*****************************************************
* CONSERVAR VARIABLES CLAVE
*****************************************************

keep FECH ///
     MES ///
     DEPARTAMENTO ///
     PAIS ///
     PRODUCTO ///
     VIA ///
     VALOR ///
     TIPO

*****************************************************
* GUARDAR TEMPORAL
*****************************************************

save "04_Resultados\expo_comparativa.dta", replace

*****************************************************
* =========================================
* IMPORTACIONES
* =========================================
*****************************************************

use "04_Resultados\impo_limpia_2025.dta", clear

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
* HOMOLOGAR VARIABLES
*****************************************************

rename DEPTODES DEPARTAMENTO

rename VAFODO VALOR

rename NABAN PRODUCTO

rename PAISGEN PAIS

rename VIATRANS VIA

gen TIPO = "IMPORTACION"

*****************************************************
* CONSERVAR VARIABLES CLAVE
*****************************************************

keep FECH ///
     MES ///
     DEPARTAMENTO ///
     PAIS ///
     PRODUCTO ///
     VIA ///
     VALOR ///
     TIPO

*****************************************************
* GUARDAR TEMPORAL
*****************************************************

save "04_Resultados\impo_comparativa.dta", replace

*****************************************************
* =========================================
* UNIR BASES
* =========================================
*****************************************************

use "04_Resultados\expo_comparativa.dta", clear

append using "04_Resultados\impo_comparativa.dta"

*****************************************************
* ETIQUETAS DEPARTAMENTO
*****************************************************

capture label drop depto

label define depto ///
68 "Santander" ///
76 "Valle del Cauca"

label values DEPARTAMENTO depto

*****************************************************
* REVISIÓN GENERAL
*****************************************************

describe

tab TIPO

tab DEPARTAMENTO

summarize VALOR

*****************************************************
* GUARDAR BASE FINAL
*****************************************************

save "04_Resultados\base_comparativa_2025.dta", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "BASE COMPARATIVA FINALIZADA"
display "====================================="
