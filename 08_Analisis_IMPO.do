*****************************************************
* ANÁLISIS IMPORTACIONES 2025
* UNIVERSIDAD PONTIFICIA BOLIVARIANA
*****************************************************

clear all
set more off

*****************************************************
* DIRECTORIO PRINCIPAL
* - Reemplazar por la ruta de ubicación de su directorio 
*****************************************************

cd "C:\Users\oztal\Desktop\Trabajo_Metodos_Cuantitativos"

*****************************************************
* CREAR LOG
*****************************************************

capture log close

log using "07_Logs\08_Analisis_IMPO.smcl", replace

*****************************************************
* ABRIR BASE LIMPIA
*****************************************************

use "04_Resultados\impo_limpia_2025.dta", clear

*****************************************************
* EXPLORAR VARIABLES PRINCIPALES
*****************************************************

tab DEPTODES

tab VIATRANS

tab ADUA

tab REGIMEN

*****************************************************
* REVISAR ESTRUCTURA
*****************************************************

codebook VIATRANS

codebook ADUA

codebook REGIMEN

*****************************************************
* VALORES PROMEDIO IMPORTADOS
*****************************************************

tabstat VAFODO, by(DEPTODES) ///
stat(mean sum min max n)

*****************************************************
* ESTADÍSTICAS GENERALES
*****************************************************

summarize VAFODO

*****************************************************
* PRINCIPALES PAÍSES DE ORIGEN
*****************************************************

tab PAISGEN

*****************************************************
* PAÍSES POR DEPARTAMENTO
*****************************************************

tab PAISGEN DEPTODES

*****************************************************
* TOP 20 PRODUCTOS IMPORTADOS
*****************************************************

preserve

contract NABAN

gsort -_freq

list NABAN _freq in 1/20

restore

*****************************************************
* TOP PRODUCTOS SANTANDER
*****************************************************

preserve

keep if DEPTODES == 68

contract NABAN

gsort -_freq

list NABAN _freq in 1/10

restore

*****************************************************
* TOP PRODUCTOS VALLE DEL CAUCA
*****************************************************

preserve

keep if DEPTODES == 76

contract NABAN

gsort -_freq

list NABAN _freq in 1/10

restore

*****************************************************
* EXPLORAR FECHAS
*****************************************************

summarize FECH

tab FECH

*****************************************************
* IMPORTACIONES POR MES
*****************************************************

tab FECH DEPTODES

*****************************************************
* VALOR IMPORTADO POR MES
*****************************************************

tabstat VAFODO, by(FECH) ///
stat(sum mean n)

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "ANÁLISIS IMPORTACIONES FINALIZADO"
display "====================================="
