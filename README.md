# Análisis del Mercado del Cobre en Chile 🇨🇱⛏️

Dashboard y análisis de datos sobre la producción, precio y exportación de cobre en Chile, construido con **SQL, Power Query y Power BI** a partir de datos públicos de Cochilco, Banco Central de Chile e INE.

> Proyecto personal de portafolio — Maximiliano De Gennaro | Data Analyst / Business Intelligence
> [LinkedIn](https://linkedin.com/in/maximilianodegennaro/) · maximiliano.degennarof@gmail.com

---

## 🎯 Objetivo del proyecto

Chile es el mayor productor de cobre del mundo, pero mucha de la información sobre el sector está dispersa en boletines PDF y planillas sueltas. Este proyecto integra esos datos en un modelo limpio y construye un dashboard que responde preguntas de negocio reales:

- ¿Cómo ha evolucionado la producción de cobre por empresa y región en los últimos años?
- ¿Qué relación existe entre el precio internacional del cobre y los volúmenes producidos/exportados?
- ¿Qué empresas concentran la mayor parte de la producción nacional (Codelco vs. privados)?
- ¿Cómo varían las exportaciones mes a mes y año a año?

## 🧰 Herramientas utilizadas

| Etapa | Herramienta |
|---|---|
| Extracción y limpieza | Excel + Power Query |
| Modelamiento y consultas | SQL (SQLite) |
| Visualización | Power BI + DAX |
| Control de versiones | Git / GitHub |

## 📂 Estructura del repositorio

```
├── data/
│   ├── raw/            # Datos originales descargados (Cochilco, BCCh, INE)
│   └── processed/      # Datos limpios, listos para cargar al modelo
├── sql/
│   └── modelo_y_consultas.sql   # Creación de tablas + consultas de análisis
├── powerbi/
│   └── dashboard_cobre.pbix     # Archivo del dashboard
├── docs/
│   └── capturas/        # Screenshots del dashboard para este README
└── README.md
```

## 📊 Fuentes de datos

- [Cochilco – Estadísticas](https://www.cochilco.cl) — producción por empresa, precios, anuario de estadísticas del cobre.
- [Banco Central de Chile](https://www.bcentral.cl) — tipo de cambio, indicadores macro.
- [INE Chile](https://www.ine.gob.cl) — estadísticas del sector minero.

## 🔎 Metodología

1. **Extracción**: descarga de boletines/estadísticas públicas de Cochilco en formato Excel/CSV.
2. **Limpieza**: normalización de nombres de empresas, unificación de periodos (año-mes), tratamiento de valores faltantes con Power Query.
3. **Modelamiento**: carga a una base SQLite, creación de tablas relacionadas (producción, precios, exportaciones) y consultas SQL para KPIs base.
4. **Visualización**: construcción de medidas DAX (producción total, variación % interanual, participación por empresa) y dashboard interactivo en Power BI.

## 📈 Principales hallazgos

*(sección a completar una vez cargados los datos — aquí van 3-4 insights concretos con números, ej: "La producción nacional cayó X% entre 2023 y 2024, explicado principalmente por...")*

## 🖼️ Vista del dashboard

*(capturas de pantalla del Power BI van aquí)*

## 🚀 Cómo reproducir este análisis

1. Clona este repositorio: `git clone https://github.com/TU-USUARIO/analisis-mercado-cobre-chile.git`
2. Los datos crudos están en `data/raw/`. El script de limpieza en Power Query se documenta en `docs/`.
3. Ejecuta `sql/modelo_y_consultas.sql` sobre una base SQLite para recrear el modelo de datos.
4. Abre `powerbi/dashboard_cobre.pbix` con Power BI Desktop para ver el dashboard interactivo.

---
*Este proyecto usa exclusivamente información pública. No contiene datos confidenciales de empleadores anteriores.*
