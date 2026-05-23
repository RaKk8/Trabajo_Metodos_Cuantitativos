*****************************************************
* LIMPIEZA IMPORTACIONES 2025
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

log using "07_Logs\05_Limpieza_IMPO.smcl", replace

*****************************************************
* LISTA DE MESES
*****************************************************

local meses Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre

*****************************************************
* RECORRER ARCHIVOS
*****************************************************

foreach mes in `meses' {

    display "====================================="
    display "PROCESANDO: `mes'"
    display "====================================="

    *************************************************
    * ABRIR ARCHIVO
    *************************************************

    use "01_RawData\Importaciones_dta\\`mes'.dta", clear

    *************************************************
    * LIMPIAR VARIABLES MONETARIAS
    *************************************************

    foreach var in VAFODO VACID VACIP FLETE SEGUROS OTROSG {

        capture confirm string variable `var'

        if !_rc {

            replace `var' = trim(`var')

            replace `var' = subinstr(`var',".","",.)

            replace `var' = subinstr(`var',",",".",.)

            destring `var', replace force
        }
    }

    *************************************************
    * HOMOGENEIZAR VARIABLES PROBLEMÁTICAS
    *************************************************

    capture tostring PBK, replace force

    capture tostring PNK, replace force

    capture tostring CANU, replace force

    capture tostring OTROSP, replace force

    capture tostring OTROSBASE, replace force

    capture tostring TOTALIVAYO, replace force

    capture tostring BASEIVA, replace force

    *************************************************
    * REVISIÓN GENERAL
    *************************************************

    describe

    *************************************************
    * GUARDAR ARCHIVO LIMPIO
    *************************************************

    save "01_RawData\Importaciones_Limpias\\`mes'_limpio.dta", replace

    display "ARCHIVO GUARDADO CORRECTAMENTE"

}

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "LIMPIEZA IMPORTACIONES FINALIZADA"
display "====================================="
