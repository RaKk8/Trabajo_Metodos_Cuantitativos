*****************************************************
* ANÁLISIS EXPORTACIONES
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

log using "07_Logs\04_Analisis_EXPO.smcl", replace

*****************************************************
* ABRIR BASE ANALÍTICA
*****************************************************

use "04_Resultados\expo_analitica_2025.dta", clear

*****************************************************
* ESTADÍSTICAS GENERALES
*****************************************************

summarize FOBDOL FOBPES CANTI

*****************************************************
* EXPORTACIONES POR DEPARTAMENTO
*****************************************************

tab DPTO1

tabstat FOBDOL, by(DPTO1) stat(mean sum min max n)

*****************************************************
* EXPORTACIONES POR MES
*****************************************************

tab MES

tabstat FOBDOL, by(MES) stat(mean sum n)

*****************************************************
* EXPORTACIONES POR MES Y DEPARTAMENTO
*****************************************************

tab MES DPTO1

*****************************************************
* PRINCIPALES PAÍSES DESTINO
*****************************************************

contract PAIS

gsort -_freq

list PAIS _freq in 1/15

*****************************************************
* VOLVER A BASE ORIGINAL
*****************************************************

use "04_Resultados\expo_analitica_2025.dta", clear

*****************************************************
* TOP PRODUCTOS SANTANDER
*****************************************************

preserve

keep if DPTO1 == 68

contract POSAR

gsort -_freq

list POSAR _freq in 1/10

restore

*****************************************************
* TOP PRODUCTOS VALLE DEL CAUCA
*****************************************************

preserve

keep if DPTO1 == 76

contract POSAR

gsort -_freq

list POSAR _freq in 1/10

restore

*****************************************************
* EXPORTACIONES TOTALES POR MES
*****************************************************

collapse (sum) FOBDOL, by(MES)

*****************************************************
* GRÁFICO DE EXPORTACIONES MENSUALES
*****************************************************

graph bar FOBDOL, over(MES) ///
title("Exportaciones Totales por Mes - 2025") ///
ytitle("FOB USD")

graph export "05_Graficas\exportaciones_mensuales.png", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "ANÁLISIS FINALIZADO"
display "====================================="
