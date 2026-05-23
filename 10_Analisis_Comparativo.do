*****************************************************
* ANÁLISIS COMPARATIVO FINAL
* EXPORTACIONES VS IMPORTACIONES
* SANTANDER VS VALLE DEL CAUCA
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

log using "07_Logs\10_Analisis_Comparativo.smcl", replace

*****************************************************
* ABRIR BASE COMPARATIVA
*****************************************************

use "04_Resultados\base_comparativa_2025.dta", clear

*****************************************************
* CREAR VARIABLE EN MILLONES USD
*****************************************************

gen VALOR_MILL = VALOR/1000000

*****************************************************
* ETIQUETAS DE MESES
*****************************************************

capture label drop meses_lbl

label define meses_lbl ///
1 "Ene" ///
2 "Feb" ///
3 "Mar" ///
4 "Abr" ///
5 "May" ///
6 "Jun" ///
7 "Jul" ///
8 "Ago" ///
9 "Sep" ///
10 "Oct" ///
11 "Nov" ///
12 "Dic"

label values MES meses_lbl

*****************************************************
* REVISIÓN GENERAL
*****************************************************

tab TIPO

tab DEPARTAMENTO

summarize VALOR

*****************************************************
* GRÁFICO 1
* EXPORTACIONES VS IMPORTACIONES
*****************************************************

preserve

collapse (sum) VALOR_MILL, by(MES TIPO)

twoway ///
(line VALOR_MILL MES if TIPO=="EXPORTACION", ///
sort lcolor(navy) lwidth(medthick) msymbol(circle)) ///
(line VALOR_MILL MES if TIPO=="IMPORTACION", ///
sort lcolor(maroon) lwidth(medthick) msymbol(circle)), ///
title("Exportaciones vs Importaciones - 2025") ///
subtitle("Santander y Valle del Cauca") ///
xtitle("Mes") ///
ytitle("Valor FOB (Millones USD)") ///
xlabel(1(1)12, valuelabel angle(0)) ///
ylabel(, format(%9.0fc)) ///
legend(order(1 "Exportaciones" 2 "Importaciones")) ///
graphregion(color(white))

graph export ///
"05_Graficas\01_Expo_vs_Impo.png", replace

restore

*****************************************************
* GRÁFICO 2
* BALANZA COMERCIAL MENSUAL
*****************************************************

preserve

collapse (sum) VALOR_MILL, by(MES TIPO)

reshape wide VALOR_MILL, i(MES) j(TIPO) string

gen BALANZA = VALOR_MILLEXPORTACION - ///
              VALOR_MILLIMPORTACION

graph bar BALANZA, ///
over(MES, relabel(1 "Ene" 2 "Feb" 3 "Mar" ///
4 "Abr" 5 "May" 6 "Jun" ///
7 "Jul" 8 "Ago" 9 "Sep" ///
10 "Oct" 11 "Nov" 12 "Dic")) ///
title("Balanza Comercial Mensual") ///
subtitle("Exportaciones - Importaciones") ///
ytitle("Millones USD") ///
bar(1, color(navy)) ///
graphregion(color(white))

graph export ///
"05_Graficas\02_Balanza_Comercial.png", ///
replace

restore

*****************************************************
* GRÁFICO 3
* PARTICIPACIÓN POR DEPARTAMENTO
*****************************************************

preserve

collapse (sum) VALOR_MILL, by(DEPARTAMENTO)

graph pie VALOR_MILL, ///
over(DEPARTAMENTO) ///
title("Participación Comercial por Departamento") ///
subtitle("Santander vs Valle del Cauca")

graph export ///
"05_Graficas\03_Participacion_Departamento.png", ///
replace

restore

*****************************************************
* GRÁFICO 4
* EXPORTACIONES VS IMPORTACIONES
* POR DEPARTAMENTO
*****************************************************

preserve

collapse (sum) VALOR_MILL, ///
by(DEPARTAMENTO TIPO)

graph bar VALOR_MILL, ///
over(TIPO) ///
over(DEPARTAMENTO) ///
title("Exportaciones vs Importaciones") ///
subtitle("Por Departamento") ///
ytitle("Millones USD") ///
graphregion(color(white))

graph export ///
"05_Graficas\04_Expo_Impo_Departamento.png", ///
replace

restore

*****************************************************
* GRÁFICO 5
* EVOLUCIÓN POR DEPARTAMENTO
*****************************************************

preserve

collapse (sum) VALOR_MILL, ///
by(MES DEPARTAMENTO)

twoway ///
(line VALOR_MILL MES if DEPARTAMENTO==68, ///
sort lcolor(navy) lwidth(medthick)) ///
(line VALOR_MILL MES if DEPARTAMENTO==76, ///
sort lcolor(forest_green) lwidth(medthick)), ///
title("Evolución Comercial por Departamento") ///
subtitle("Santander vs Valle del Cauca") ///
xtitle("Mes") ///
ytitle("Millones USD") ///
xlabel(1(1)12, valuelabel) ///
legend(order(1 "Santander" ///
2 "Valle del Cauca")) ///
graphregion(color(white))

graph export ///
"05_Graficas\05_Evolucion_Departamentos.png", ///
replace

restore

*****************************************************
* GRÁFICO 6
* TOP 10 PAÍSES
*****************************************************

preserve

contract PAIS

gsort -_freq

keep in 1/10

graph hbar _freq, ///
over(PAIS, sort(1) descending) ///
title("Top 10 Países Comerciales") ///
ytitle("Frecuencia") ///
bar(1, color(navy)) ///
graphregion(color(white))

graph export ///
"05_Graficas\06_Top_Paises.png", ///
replace

restore

*****************************************************
* GRÁFICO 7
* TOP 10 PRODUCTOS
*****************************************************

preserve

contract PRODUCTO

gsort -_freq

keep in 1/10

graph hbar _freq, ///
over(PRODUCTO, sort(1) descending) ///
title("Top 10 Productos") ///
ytitle("Frecuencia") ///
ylabel(, angle(0)) ///
bar(1, color(forest_green)) ///
graphregion(color(white))

graph export ///
"05_Graficas\07_Top_Productos.png", ///
replace

restore
*****************************************************
* GRÁFICO 8
* MEDIOS DE TRANSPORTE
*****************************************************

preserve

graph bar (count), ///
over(VIA) ///
over(TIPO) ///
title("Medios de Transporte Utilizados") ///
ytitle("Frecuencia") ///
graphregion(color(white))

graph export ///
"05_Graficas\08_Vias_Transporte.png", ///
replace

restore

*****************************************************
* GRÁFICO 9
* DISTRIBUCIÓN FOB - HISTOGRAMA
*****************************************************

preserve

keep if VALOR_MILL < 2

*****************************************************
* HISTOGRAMA SANTANDER
*****************************************************

histogram VALOR_MILL if DEPARTAMENTO==68, ///
width(0.05) ///
frequency ///
title("Distribución FOB - Santander") ///
xtitle("Millones USD") ///
ytitle("Frecuencia") ///
color(navy) ///
graphregion(color(white))

graph export ///
"05_Graficas\09_Histograma_Santander.png", ///
replace

*****************************************************
* HISTOGRAMA VALLE DEL CAUCA
*****************************************************

histogram VALOR_MILL if DEPARTAMENTO==76, ///
width(0.05) ///
frequency ///
title("Distribución FOB - Valle del Cauca") ///
xtitle("Millones USD") ///
ytitle("Frecuencia") ///
color(forest_green) ///
graphregion(color(white))

graph export ///
"05_Graficas\10_Histograma_Valle.png", ///
replace

restore
*****************************************************
* TABLAS IMPORTANTES
*****************************************************

tabstat VALOR, by(TIPO) ///
stat(sum mean min max n)

tabstat VALOR, by(DEPARTAMENTO) ///
stat(sum mean min max n)

table DEPARTAMENTO TIPO, ///
c(sum VALOR mean VALOR n VALOR)

*****************************************************
* CERRAR LOG
*****************************************************

log close

display "====================================="
display "ANÁLISIS COMPARATIVO FINALIZADO"
display "GRÁFICOS GENERADOS CORRECTAMENTE"
display "====================================="
