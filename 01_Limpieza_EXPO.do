*****************************************************
* LIMPIEZA EXPORTACIONES 2025
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

log using "07_Logs\01_Limpieza_EXPO.smcl", replace

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

    use "01_RawData\Exportaciones_dta\\`mes'.dta", clear

    *************************************************
    * LIMPIAR VARIABLES NUMÉRICAS
    *************************************************

    foreach var in FOBDOL FOBPES CANTI AGRENA FLETES SEGURO OTROSG {

        capture confirm string variable `var'

        if !_rc {

            replace `var' = trim(`var')

            replace `var' = subinstr(`var',".","",.)

            replace `var' = subinstr(`var',",",".",.)

            destring `var', replace force
        }
    }

    *************************************************
    * LIMPIAR PNK
    *************************************************

    capture confirm string variable PNK

    if !_rc {

        replace PNK = trim(PNK)

        replace PNK = subinstr(PNK,".","",.)

        replace PNK = subinstr(PNK,",",".",.)

        destring PNK, replace force
    }

    *************************************************
    * HOMOLOGAR PBK COMO TEXTO
    *************************************************

    capture tostring PBK, replace force

    *************************************************
    * REVISIÓN GENERAL
    *************************************************

    describe

    *************************************************
    * GUARDAR ARCHIVO LIMPIO
    *************************************************

    save "01_RawData\Exportaciones_Limpias\\`mes'_limpio.dta", replace

    display "ARCHIVO GUARDADO CORRECTAMENTE"

}

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "LIMPIEZA FINALIZADA"
display "====================================="
