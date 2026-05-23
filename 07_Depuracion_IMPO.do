*****************************************************
* DEPURACIÓN IMPORTACIONES 2025
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

log using "07_Logs\07_Depuracion_IMPO.smcl", replace

*****************************************************
* ABRIR BASE CONSOLIDADA
*****************************************************

use "02_Bases_Stata\impo_2025_completa.dta", clear

*****************************************************
* EXPLORAR DEPARTAMENTOS
*****************************************************

tab DEPTODES

*****************************************************
* FILTRAR SANTANDER Y VALLE
*****************************************************

keep if DEPTODES == 68 | DEPTODES == 76

*****************************************************
* VERIFICAR FILTRO
*****************************************************

tab DEPTODES

count

*****************************************************
* CONSERVAR VARIABLES RELEVANTES
*****************************************************

keep FECH ///
     DEPTODES ///
     PAISGEN ///
     PAISPRO ///
     PAISCOM ///
     NABAN ///
     VIATRANS ///
     ADUA ///
     REGIMEN ///
     VAFODO ///
     VACID ///
     VACIP ///
     FLETE ///
     SEGUROS ///
     OTROSG

*****************************************************
* REVISIÓN GENERAL
*****************************************************

describe

summarize VAFODO VACID VACIP

*****************************************************
* GUARDAR BASE LIMPIA
*****************************************************

save "04_Resultados\impo_limpia_2025.dta", replace

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "DEPURACIÓN IMPORTACIONES FINALIZADA"
display "====================================="
