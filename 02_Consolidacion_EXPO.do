*****************************************************
* CONSOLIDACIÓN EXPORTACIONES LIMPIAS
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

log using "07_Logs\02_Consolidacion_EXPO.smcl", replace

*****************************************************
* ABRIR ENERO
*****************************************************

use "01_RawData\Exportaciones_Limpias\Enero_limpio.dta", clear

*****************************************************
* UNIR RESTO DE MESES
*****************************************************

append using "01_RawData\Exportaciones_Limpias\Febrero_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Marzo_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Abril_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Mayo_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Junio_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Julio_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Agosto_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Septiembre_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Octubre_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Noviembre_limpio.dta"

append using "01_RawData\Exportaciones_Limpias\Diciembre_limpio.dta"

*****************************************************
* REVISIÓN GENERAL
*****************************************************

describe

count

summarize FOBDOL FOBPES CANTI

*****************************************************
* VERIFICAR FECHAS
*****************************************************

tab FECH

*****************************************************
* GUARDAR BASE CONSOLIDADA
*****************************************************

save "02_Bases_Stata\expo_2025_consolidada.dta", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "CONSOLIDACIÓN FINALIZADA"
display "====================================="
