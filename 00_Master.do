*****************************************************
* DINÁMICA DEL COMERCIO EXTERIOR COLOMBIANO
* ANÁLISIS COMPARATIVO 2025
* UNIVERSIDAD PONTIFICIA BOLIVARIANA
* STATA 14
*****************************************************

*****************************************************
* AUTORES
*****************************************************

* Juan Diego Rojas
* Danny Mejía Pérez
* Laura Martínez Ovalle

*****************************************************
* LIMPIEZA TOTAL DEL ENTORNO
*****************************************************

clear all
clear matrix
clear mata
macro drop _all
program drop _all

set more off

capture log close
graph drop _all

*****************************************************
* DEFINIR DIRECTORIO PRINCIPAL
* - Reemplazar por la ruta de ubicación de su directorio 
*****************************************************

cd "C:\Users\oztal\Desktop\Trabajo_Metodos_Cuantitativos"

*****************************************************
* CREAR ESTRUCTURA AUTOMÁTICA
*****************************************************

capture mkdir "01_RawData"

capture mkdir "01_RawData\Exportaciones_dta"
capture mkdir "01_RawData\Importaciones_dta"

capture mkdir "01_RawData\Exportaciones_Limpias"
capture mkdir "01_RawData\Importaciones_Limpias"

capture mkdir "02_Bases_Stata"

capture mkdir "03_DoFiles"

capture mkdir "04_Resultados"

capture mkdir "05_Graficas"

capture mkdir "06_Tablas"

capture mkdir "07_Logs"


*****************************************************
* VERIFICAR DIRECTORIO
*****************************************************

pwd

*****************************************************
* CREAR LOG GENERAL
*****************************************************

capture log close

log using "07_Logs\master_log.smcl", replace

*****************************************************
* INFORMACIÓN DEL SISTEMA
*****************************************************

display "====================================="
display "INICIO DEL PROYECTO"
display c(current_date)
display c(current_time)
display "====================================="

display "VERSION STATA:"
display c(stata_version)

display "SISTEMA OPERATIVO:"
display c(os)

*****************************************************
* EJECUTAR DO-FILES
*****************************************************

display "====================================="
display "1. LIMPIEZA EXPORTACIONES"
display "====================================="

do "03_DoFiles\01_Limpieza_EXPO.do"

display "====================================="
display "2. CONSOLIDACIÓN EXPORTACIONES"
display "====================================="

do "03_DoFiles\02_Consolidacion_EXPO.do"

display "====================================="
display "3. DEPURACIÓN EXPORTACIONES"
display "====================================="

do "03_DoFiles\03_Depuracion_EXPO.do"

display "====================================="
display "4. ANÁLISIS EXPORTACIONES"
display "====================================="

do "03_DoFiles\04_Analisis_EXPO.do"

display "====================================="
display "5. LIMPIEZA IMPORTACIONES"
display "====================================="

do "03_DoFiles\05_Limpieza_IMPO.do"

display "====================================="
display "6. CONSOLIDACIÓN IMPORTACIONES"
display "====================================="

do "03_DoFiles\06_Consolidacion_IMPO.do"

display "====================================="
display "7. DEPURACIÓN IMPORTACIONES"
display "====================================="

do "03_DoFiles\07_Depuracion_IMPO.do"

display "====================================="
display "8. ANÁLISIS IMPORTACIONES"
display "====================================="

do "03_DoFiles\08_Analisis_IMPO.do"

display "====================================="
display "9. ESTANDARIZACIÓN DE DATOS"
display "====================================="

do "03_DoFiles\09_Preparacion_Comparativo.do"

display "====================================="
display "10. ANALISIS COMPARATIVO"
display "====================================="

do "03_DoFiles\10_Analisis_Comparativo.do"

*****************************************************
* FINALIZAR LOG
*****************************************************

log close

display "====================================="
display "PROYECTO FINALIZADO CORRECTAMENTE"
display "TODOS LOS DO-FILES EJECUTADOS"
display "GRÁFICOS GENERADOS"
display "RESULTADOS EXPORTADOS"
display "====================================="
