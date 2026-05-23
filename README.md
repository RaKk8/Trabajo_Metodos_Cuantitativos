# README

Este archivo explica cómo ejecutar el código del proyecto y en qué orden corren los archivos `.do`.

## Requisitos

- Stata 14 o superior.
- Mantener la estructura de carpetas del proyecto sin cambiar nombres.
- Abrir el proyecto desde la carpeta raíz `Trabajo_Metodos_Cuantitativos`.

## Cómo ejecutar

Ejecuta únicamente el archivo maestro:

```stata
do 03_DoFiles/00_Master.do
```

El archivo maestro se encarga de:

- limpiar la sesión de Stata,
- crear las carpetas necesarias si no existen,
- abrir el log general,
- ejecutar todos los procesos en el orden correcto,
- generar bases intermedias y finales,
- exportar resultados, tablas y gráficos,
- cerrar el log al finalizar.

## Orden de ejecución

El flujo completo que sigue el master es este:

1. `01_Limpieza_EXPO.do`
2. `02_Consolidacion_EXPO.do`
3. `03_Depuracion_EXPO.do`
4. `04_Analisis_EXPO.do`
5. `05_Limpieza_IMPO.do`
6. `06_Consolidacion_IMPO.do`
7. `07_Depuracion_IMPO.do`
8. `08_Analisis_IMPO.do`
9. `09_Preparacion_Comparativo.do`
10. `10_Analisis_Comparativo.do`

No es necesario ejecutar estos archivos manualmente si se usa el master.

## Salidas generadas

Al terminar la ejecución se guardan archivos en estas carpetas:

- `02_Bases_Stata/`
- `04_Resultados/`
- `05_Graficas/`
- `06_Tablas/`
- `07_Logs/`

## Recomendaciones

- No renombres los archivos mensuales de entrada.
- No cambies las rutas internas del proyecto.
- Si el proyecto se mueve de ubicación, ajusta la línea `cd` dentro de `00_Master.do` y los demás archivos '.do' o 'do-files'.

## Verificación rápida

Si algo falla, revisa primero:

1. que la ruta base del proyecto sea correcta,
2. que existan los archivos `.dta` y `.csv` esperados,
3. que Stata tenga permisos para escribir en las carpetas de salida,
4. el log generado en `07_Logs/master_log.smcl`.