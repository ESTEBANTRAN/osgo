-- ================================================================================
-- VISTAS ÚTILES PARA SISTEMA_PRINCIPAL
-- Facilitan consultas complejas y filtrado de datos para OSGO
-- ================================================================================

USE sistema_principal;

-- ================================================================================
-- 1. VISTA: Personas Disponibles (sin indisponibilidades activas)
-- ================================================================================

DROP VIEW IF EXISTS v_personas_disponibles;
CREATE VIEW v_personas_disponibles AS
SELECT 
    p.ID_PERSONA,
    p.CODIGO_AGENTE,
    CONCAT(p.NOMBRES, ' ', p.APELLIDOS) AS NOMBRE_COMPLETO,
    p.NOMBRES,
    p.APELLIDOS,
    p.CEDULA,
    p.TELEFONO_AGENTE,
    p.EMAIL,
    f.FUNCION,
    f.ID_FUNCION,
    g.GRUPO_OPERATIVO,
    g.ID_GRUPO_OPERATIVO,
    d.DISTRITO,
    d.CANTON,
    d.ID_DISTRITO_AGENTE,
    'DISPONIBLE' AS ESTADO_DISPONIBILIDAD
FROM personas p
JOIN funciones f ON p.ID_FUNCION = f.ID_FUNCION
JOIN grupo_operativo g ON p.ID_GRUPO_OPERATIVO = g.ID_GRUPO_OPERATIVO
JOIN distritos_agentes d ON p.ID_DISTRITO_AGENTE = d.ID_DISTRITO_AGENTE
WHERE p.AGENTE = 'A'
  AND f.ESTADO_FUNCION = 'A'
  AND g.ACTIVO = 'A'
  AND p.ID_PERSONA NOT IN (
    SELECT DISTINCT i.ID_USUARIO
    FROM indisponibilidad i
    WHERE i.FECHA_DESDE <= NOW()
      AND i.FECHA_HASTA >= NOW()
  );

-- ================================================================================
-- 2. VISTA: Personas No Disponibles (con indisponibilidades activas)
-- ================================================================================

DROP VIEW IF EXISTS v_personas_no_disponibles;
CREATE VIEW v_personas_no_disponibles AS
SELECT 
    p.ID_PERSONA,
    p.CODIGO_AGENTE,
    CONCAT(p.NOMBRES, ' ', p.APELLIDOS) AS NOMBRE_COMPLETO,
    p.NOMBRES,
    p.APELLIDOS,
    p.CEDULA,
    p.TELEFONO_AGENTE,
    p.EMAIL,
    f.FUNCION,
    f.ID_FUNCION,
    g.GRUPO_OPERATIVO,
    g.ID_GRUPO_OPERATIVO,
    d.DISTRITO,
    d.CANTON,
    d.ID_DISTRITO_AGENTE,
    'NO_DISPONIBLE' AS ESTADO_DISPONIBILIDAD,
    ti.TIPO_INDISPONIBILIDAD,
    ti.ID_TIPO_INDISPONIBILIDAD,
    i.FECHA_DESDE,
    i.FECHA_HASTA,
    DATEDIFF(i.FECHA_HASTA, i.FECHA_DESDE) + 1 AS DIAS_INDISPONIBLE
FROM personas p
JOIN funciones f ON p.ID_FUNCION = f.ID_FUNCION
JOIN grupo_operativo g ON p.ID_GRUPO_OPERATIVO = g.ID_GRUPO_OPERATIVO
JOIN distritos_agentes d ON p.ID_DISTRITO_AGENTE = d.ID_DISTRITO_AGENTE
JOIN indisponibilidad i ON p.ID_PERSONA = i.ID_USUARIO
JOIN tipo_indisponibilidad ti ON i.ID_TIPO_INDISPONIBILIDAD = ti.ID_TIPO_INDISPONIBILIDAD
WHERE p.AGENTE = 'A'
  AND f.ESTADO_FUNCION = 'A'
  AND g.ACTIVO = 'A'
  AND ti.ESTADO = 'A'
  AND i.FECHA_DESDE <= NOW()
  AND i.FECHA_HASTA >= NOW();

-- ================================================================================
-- 3. VISTA: Resumen de Disponibilidad por Función
-- ================================================================================

DROP VIEW IF EXISTS v_disponibilidad_por_funcion;
CREATE VIEW v_disponibilidad_por_funcion AS
SELECT 
    f.ID_FUNCION,
    f.FUNCION,
    COUNT(p.ID_PERSONA) AS TOTAL_PERSONAS,
    COUNT(CASE WHEN disp.ID_PERSONA IS NOT NULL THEN 1 END) AS DISPONIBLES,
    COUNT(CASE WHEN no_disp.ID_PERSONA IS NOT NULL THEN 1 END) AS NO_DISPONIBLES,
    ROUND((COUNT(CASE WHEN disp.ID_PERSONA IS NOT NULL THEN 1 END) * 100.0 / COUNT(p.ID_PERSONA)), 2) AS PORCENTAJE_DISPONIBILIDAD
FROM funciones f
LEFT JOIN personas p ON f.ID_FUNCION = p.ID_FUNCION AND p.AGENTE = 'A'
LEFT JOIN v_personas_disponibles disp ON p.ID_PERSONA = disp.ID_PERSONA
LEFT JOIN v_personas_no_disponibles no_disp ON p.ID_PERSONA = no_disp.ID_PERSONA
WHERE f.ESTADO_FUNCION = 'A'
GROUP BY f.ID_FUNCION, f.FUNCION
ORDER BY f.ID_FUNCION;

-- ================================================================================
-- 4. VISTA: Resumen de Disponibilidad por Grupo Operativo
-- ================================================================================

DROP VIEW IF EXISTS v_disponibilidad_por_grupo;
CREATE VIEW v_disponibilidad_por_grupo AS
SELECT 
    g.ID_GRUPO_OPERATIVO,
    g.GRUPO_OPERATIVO,
    tg.TIPO_GRUPO,
    COUNT(p.ID_PERSONA) AS TOTAL_PERSONAS,
    COUNT(CASE WHEN disp.ID_PERSONA IS NOT NULL THEN 1 END) AS DISPONIBLES,
    COUNT(CASE WHEN no_disp.ID_PERSONA IS NOT NULL THEN 1 END) AS NO_DISPONIBLES,
    ROUND((COUNT(CASE WHEN disp.ID_PERSONA IS NOT NULL THEN 1 END) * 100.0 / COUNT(p.ID_PERSONA)), 2) AS PORCENTAJE_DISPONIBILIDAD
FROM grupo_operativo g
LEFT JOIN tipo_grupo tg ON g.ID_TIPO_GRUPO = tg.ID_TIPO_GRUPO
LEFT JOIN personas p ON g.ID_GRUPO_OPERATIVO = p.ID_GRUPO_OPERATIVO AND p.AGENTE = 'A'
LEFT JOIN v_personas_disponibles disp ON p.ID_PERSONA = disp.ID_PERSONA
LEFT JOIN v_personas_no_disponibles no_disp ON p.ID_PERSONA = no_disp.ID_PERSONA
WHERE g.ACTIVO = 'A'
GROUP BY g.ID_GRUPO_OPERATIVO, g.GRUPO_OPERATIVO, tg.TIPO_GRUPO
ORDER BY g.ID_GRUPO_OPERATIVO;

-- ================================================================================
-- 5. VISTA: Personas por Distrito (para asignaciones geográficas)
-- ================================================================================

DROP VIEW IF EXISTS v_personas_por_distrito;
CREATE VIEW v_personas_por_distrito AS
SELECT 
    d.ID_DISTRITO_AGENTE,
    d.DISTRITO,
    d.CANTON,
    p.ID_PERSONA,
    p.CODIGO_AGENTE,
    CONCAT(p.NOMBRES, ' ', p.APELLIDOS) AS NOMBRE_COMPLETO,
    f.FUNCION,
    f.ID_FUNCION,
    g.GRUPO_OPERATIVO,
    CASE 
        WHEN disp.ID_PERSONA IS NOT NULL THEN 'DISPONIBLE'
        WHEN no_disp.ID_PERSONA IS NOT NULL THEN 'NO_DISPONIBLE'
        ELSE 'INACTIVO'
    END AS ESTADO_DISPONIBILIDAD,
    no_disp.TIPO_INDISPONIBILIDAD,
    no_disp.FECHA_HASTA AS DISPONIBLE_DESDE
FROM distritos_agentes d
LEFT JOIN personas p ON d.ID_DISTRITO_AGENTE = p.ID_DISTRITO_AGENTE AND p.AGENTE = 'A'
LEFT JOIN funciones f ON p.ID_FUNCION = f.ID_FUNCION
LEFT JOIN grupo_operativo g ON p.ID_GRUPO_OPERATIVO = g.ID_GRUPO_OPERATIVO
LEFT JOIN v_personas_disponibles disp ON p.ID_PERSONA = disp.ID_PERSONA
LEFT JOIN v_personas_no_disponibles no_disp ON p.ID_PERSONA = no_disp.ID_PERSONA
ORDER BY d.DISTRITO, d.CANTON, p.APELLIDOS, p.NOMBRES;

-- ================================================================================
-- 6. VISTA: Opciones de Personas para Formularios (formato optimizado para dropdowns)
-- ================================================================================

DROP VIEW IF EXISTS v_opciones_personas;
CREATE VIEW v_opciones_personas AS
SELECT 
    p.ID_PERSONA AS id,
    CONCAT(p.CODIGO_AGENTE, ' - ', p.APELLIDOS, ' ', p.NOMBRES) AS opcion_texto,
    p.CODIGO_AGENTE,
    p.NOMBRES,
    p.APELLIDOS,
    f.FUNCION,
    f.ID_FUNCION,
    g.GRUPO_OPERATIVO,
    d.DISTRITO,
    CASE 
        WHEN disp.ID_PERSONA IS NOT NULL THEN 1
        ELSE 0
    END AS disponible,
    CASE 
        WHEN no_disp.ID_PERSONA IS NOT NULL THEN no_disp.TIPO_INDISPONIBILIDAD
        ELSE NULL
    END AS motivo_indisponibilidad
FROM personas p
JOIN funciones f ON p.ID_FUNCION = f.ID_FUNCION
JOIN grupo_operativo g ON p.ID_GRUPO_OPERATIVO = g.ID_GRUPO_OPERATIVO
JOIN distritos_agentes d ON p.ID_DISTRITO_AGENTE = d.ID_DISTRITO_AGENTE
LEFT JOIN v_personas_disponibles disp ON p.ID_PERSONA = disp.ID_PERSONA
LEFT JOIN v_personas_no_disponibles no_disp ON p.ID_PERSONA = no_disp.ID_PERSONA
WHERE p.AGENTE = 'A'
  AND f.ESTADO_FUNCION = 'A'
  AND g.ACTIVO = 'A'
ORDER BY disponible DESC, p.APELLIDOS, p.NOMBRES;

-- ================================================================================
-- 7. VISTA: Opciones de Funciones con Contador de Personal Disponible
-- ================================================================================

DROP VIEW IF EXISTS v_opciones_funciones;
CREATE VIEW v_opciones_funciones AS
SELECT 
    f.ID_FUNCION AS id,
    CONCAT(f.FUNCION, ' (', COALESCE(COUNT(disp.ID_PERSONA), 0), ' disponibles)') AS opcion_texto,
    f.FUNCION,
    COALESCE(COUNT(p.ID_PERSONA), 0) AS total_personas,
    COALESCE(COUNT(disp.ID_PERSONA), 0) AS personas_disponibles,
    COALESCE(COUNT(no_disp.ID_PERSONA), 0) AS personas_no_disponibles
FROM funciones f
LEFT JOIN personas p ON f.ID_FUNCION = p.ID_FUNCION AND p.AGENTE = 'A'
LEFT JOIN v_personas_disponibles disp ON p.ID_PERSONA = disp.ID_PERSONA
LEFT JOIN v_personas_no_disponibles no_disp ON p.ID_PERSONA = no_disp.ID_PERSONA
WHERE f.ESTADO_FUNCION = 'A'
GROUP BY f.ID_FUNCION, f.FUNCION
ORDER BY f.ID_FUNCION;

-- ================================================================================
-- 8. VISTA: Próximas Disponibilidades (personal que estará disponible pronto)
-- ================================================================================

DROP VIEW IF EXISTS v_proximas_disponibilidades;
CREATE VIEW v_proximas_disponibilidades AS
SELECT 
    p.ID_PERSONA,
    p.CODIGO_AGENTE,
    CONCAT(p.NOMBRES, ' ', p.APELLIDOS) AS NOMBRE_COMPLETO,
    f.FUNCION,
    g.GRUPO_OPERATIVO,
    d.DISTRITO,
    ti.TIPO_INDISPONIBILIDAD,
    i.FECHA_HASTA AS DISPONIBLE_DESDE,
    DATEDIFF(i.FECHA_HASTA, NOW()) AS DIAS_PARA_DISPONIBILIDAD
FROM personas p
JOIN funciones f ON p.ID_FUNCION = f.ID_FUNCION
JOIN grupo_operativo g ON p.ID_GRUPO_OPERATIVO = g.ID_GRUPO_OPERATIVO
JOIN distritos_agentes d ON p.ID_DISTRITO_AGENTE = d.ID_DISTRITO_AGENTE
JOIN indisponibilidad i ON p.ID_PERSONA = i.ID_USUARIO
JOIN tipo_indisponibilidad ti ON i.ID_TIPO_INDISPONIBILIDAD = ti.ID_TIPO_INDISPONIBILIDAD
WHERE p.AGENTE = 'A'
  AND f.ESTADO_FUNCION = 'A'
  AND g.ACTIVO = 'A'
  AND ti.ESTADO = 'A'
  AND i.FECHA_DESDE <= NOW()
  AND i.FECHA_HASTA >= NOW()
  AND i.FECHA_HASTA <= DATE_ADD(NOW(), INTERVAL 7 DAY)  -- Próximos 7 días
ORDER BY i.FECHA_HASTA, p.APELLIDOS, p.NOMBRES;

-- ================================================================================
-- VALIDACIÓN DE VISTAS CREADAS
-- ================================================================================

SELECT 'Vistas creadas exitosamente en sistema_principal' AS mensaje;

-- Mostrar resumen de las vistas
SELECT 
    'v_personas_disponibles' AS vista,
    (SELECT COUNT(*) FROM v_personas_disponibles) AS registros;

SELECT 
    'v_personas_no_disponibles' AS vista,
    (SELECT COUNT(*) FROM v_personas_no_disponibles) AS registros;

SELECT 
    'v_disponibilidad_por_funcion' AS vista,
    (SELECT COUNT(*) FROM v_disponibilidad_por_funcion) AS registros;

SELECT 
    'v_disponibilidad_por_grupo' AS vista,
    (SELECT COUNT(*) FROM v_disponibilidad_por_grupo) AS registros;

-- Mostrar ejemplo de consulta útil
SELECT 'Ejemplo: Personal disponible para CONDUCTOR PATRULLERO' AS descripcion;
SELECT 
    CODIGO_AGENTE,
    NOMBRE_COMPLETO,
    GRUPO_OPERATIVO,
    DISTRITO
FROM v_personas_disponibles 
WHERE FUNCION = 'CONDUCTOR PATRULLERO'
LIMIT 5;
