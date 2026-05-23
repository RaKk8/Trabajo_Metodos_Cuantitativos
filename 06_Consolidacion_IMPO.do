*****************************************************
* CONSOLIDACIÓN IMPORTACIONES 2025
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

log using "07_Logs\06_Consolidacion_IMPO.smcl", replace

*****************************************************
* ABRIR ENERO
*****************************************************

use "01_RawData\Importaciones_Limpias\Enero_limpio.dta", clear

*****************************************************
* APPEND MESES
*****************************************************

append using "01_RawData\Importaciones_Limpias\Febrero_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Marzo_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Abril_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Mayo_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Junio_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Julio_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Agosto_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Septiembre_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Octubre_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Noviembre_limpio.dta"
append using "01_RawData\Importaciones_Limpias\Diciembre_limpio.dta"

*****************************************************
* REVISIÓN GENERAL
*****************************************************

describe

count

summarize VAFODO VACID VACIP

*****************************************************
* GUARDAR BASE CONSOLIDADA
*****************************************************

save "02_Bases_Stata\impo_2025_completa.dta", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "CONSOLIDACIÓN IMPORTACIONES FINALIZADA"
display "====================================="
