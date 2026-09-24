-- =====================================================================
-- PROYECTO: Análisis del Mercado del Cobre en Chile
-- Autor: Maximiliano De Gennaro
-- Descripción: Modelo de datos y consultas base para el análisis.
-- NOTA: Las columnas exactas se ajustarán una vez descarguemos los
--       archivos reales de Cochilco/BCCh/INE. Esta es la plantilla
--       de partida basada en la estructura típica de esos boletines.
-- =====================================================================

-- -------------------------------
-- 1. MODELO DE DATOS (creación de tablas)
-- -------------------------------

DROP TABLE IF EXISTS produccion_cobre;
CREATE TABLE produccion_cobre (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    empresa         TEXT NOT NULL,          -- ej: Codelco, Escondida, Collahuasi
    region          TEXT,                   -- región donde opera la faena
    anio            INTEGER NOT NULL,
    mes             INTEGER,                -- 1-12, NULL si el dato es anual
    toneladas       REAL NOT NULL,          -- producción en toneladas métricas
    tipo_empresa    TEXT                    -- 'Estatal' / 'Privada'
);

DROP TABLE IF EXISTS precio_cobre;
CREATE TABLE precio_cobre (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    anio            INTEGER NOT NULL,
    mes             INTEGER NOT NULL,
    precio_libra_usd REAL NOT NULL          -- precio promedio mensual, USD/libra
);

DROP TABLE IF EXISTS exportaciones_cobre;
CREATE TABLE exportaciones_cobre (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    anio            INTEGER NOT NULL,
    mes             INTEGER,
    destino         TEXT,                   -- país o región de destino
    valor_usd       REAL NOT NULL,
    volumen_ton     REAL
);

-- -------------------------------
-- 2. CONSULTAS DE ANÁLISIS (ejemplos que iremos ajustando con datos reales)
-- -------------------------------

-- 2.1 Producción total nacional por año
SELECT
    anio,
    ROUND(SUM(toneladas), 0) AS produccion_total_ton
FROM produccion_cobre
GROUP BY anio
ORDER BY anio;

-- 2.2 Variación % interanual de producción total
WITH produccion_anual AS (
    SELECT anio, SUM(toneladas) AS total
    FROM produccion_cobre
    GROUP BY anio
)
SELECT
    anio,
    total AS produccion_ton,
    ROUND(
        (total - LAG(total) OVER (ORDER BY anio))
        / LAG(total) OVER (ORDER BY anio) * 100
    , 2) AS variacion_pct_interanual
FROM produccion_anual
ORDER BY anio;

-- 2.3 Ranking de empresas por producción (últimos 3 años disponibles)
SELECT
    empresa,
    tipo_empresa,
    ROUND(SUM(toneladas), 0) AS produccion_total_ton,
    RANK() OVER (ORDER BY SUM(toneladas) DESC) AS ranking
FROM produccion_cobre
WHERE anio >= (SELECT MAX(anio) - 2 FROM produccion_cobre)
GROUP BY empresa, tipo_empresa
ORDER BY ranking;

-- 2.4 Participación Codelco (estatal) vs. privados en el total nacional
SELECT
    anio,
    tipo_empresa,
    ROUND(SUM(toneladas), 0) AS produccion_ton,
    ROUND(
        100.0 * SUM(toneladas) / SUM(SUM(toneladas)) OVER (PARTITION BY anio)
    , 1) AS participacion_pct
FROM produccion_cobre
GROUP BY anio, tipo_empresa
ORDER BY anio, tipo_empresa;

-- 2.5 Relación precio del cobre vs. producción mensual (para analizar correlación en Power BI/Excel)
SELECT
    p.anio,
    p.mes,
    SUM(p.toneladas) AS produccion_ton,
    pr.precio_libra_usd
FROM produccion_cobre p
JOIN precio_cobre pr
    ON p.anio = pr.anio AND p.mes = pr.mes
GROUP BY p.anio, p.mes, pr.precio_libra_usd
ORDER BY p.anio, p.mes;

-- 2.6 Exportaciones por destino, últimos 12 meses disponibles
SELECT
    destino,
    ROUND(SUM(valor_usd), 0) AS valor_total_usd,
    ROUND(SUM(volumen_ton), 0) AS volumen_total_ton
FROM exportaciones_cobre
GROUP BY destino
ORDER BY valor_total_usd DESC;
