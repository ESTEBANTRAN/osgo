-- ================================================================================
-- TABLAS PARA TIPOS DE SERVICIO Y DISPOSICIONES
-- Base de datos: OSGO
-- ================================================================================

USE osgo;

-- ================================================================================
-- 1. TABLA: osgo_tipos_servicio
-- ================================================================================

CREATE TABLE IF NOT EXISTS osgo_tipos_servicio (
    ID_TIPO_SERVICIO INT AUTO_INCREMENT PRIMARY KEY,
    TIPO_SERVICIO VARCHAR(50) NOT NULL,
    DESCRIPCION TEXT,
    CATEGORIA ENUM('MOTORIZADO', 'PEDESTRE', 'GRUA', 'ESPECIAL', 'MERCADO') NOT NULL,
    REQUIERE_VEHICULO BOOLEAN DEFAULT FALSE,
    REQUIERE_HORARIO BOOLEAN DEFAULT TRUE,
    REQUIERE_SECTOR BOOLEAN DEFAULT TRUE,
    ACTIVO BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ================================================================================
-- 2. TABLA: osgo_servicios_orden (relación con orden de servicio)
-- ================================================================================

CREATE TABLE IF NOT EXISTS osgo_servicios_orden (
    ID_SERVICIO_ORDEN INT AUTO_INCREMENT PRIMARY KEY,
    ID_ORDEN_SERVICIO INT NOT NULL,
    ID_TIPO_SERVICIO INT NOT NULL,
    HORARIO VARCHAR(50),
    PLACA_VEHICULO VARCHAR(20),
    GRUPO_ASIGNADO VARCHAR(30),
    RESPONSABLE VARCHAR(100),
    CODIGO_RESPONSABLE VARCHAR(20),
    SECTOR_DESCRIPCION TEXT,
    NOVEDADES TEXT,
    OBSERVACIONES TEXT,
    ACTIVO BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (ID_ORDEN_SERVICIO) REFERENCES osgo_orden_servicio(ID_ORDEN_SERVICIO) ON DELETE CASCADE,
    FOREIGN KEY (ID_TIPO_SERVICIO) REFERENCES osgo_tipos_servicio(ID_TIPO_SERVICIO)
);

-- ================================================================================
-- 3. TABLA: osgo_disposiciones_generales
-- ================================================================================

CREATE TABLE IF NOT EXISTS osgo_disposiciones_generales (
    ID_DISPOSICION INT AUTO_INCREMENT PRIMARY KEY,
    NUMERO_DISPOSICION INT NOT NULL,
    TITULO VARCHAR(200) NOT NULL,
    CONTENIDO TEXT NOT NULL,
    CATEGORIA ENUM('ACCIDENTES', 'OPERATIVOS', 'NORMATIVAS', 'ORDENES', 'MOTOCICLETAS', 'REPORTES', 'GENERAL') NOT NULL,
    ES_OBLIGATORIA BOOLEAN DEFAULT TRUE,
    ACTIVO BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ================================================================================
-- 4. TABLA: osgo_disposiciones_orden (relación con orden de servicio)
-- ================================================================================

CREATE TABLE IF NOT EXISTS osgo_disposiciones_orden (
    ID_DISPOSICION_ORDEN INT AUTO_INCREMENT PRIMARY KEY,
    ID_ORDEN_SERVICIO INT NOT NULL,
    ID_DISPOSICION INT NOT NULL,
    INCLUIDA BOOLEAN DEFAULT TRUE,
    OBSERVACIONES TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (ID_ORDEN_SERVICIO) REFERENCES osgo_orden_servicio(ID_ORDEN_SERVICIO) ON DELETE CASCADE,
    FOREIGN KEY (ID_DISPOSICION) REFERENCES osgo_disposiciones_generales(ID_DISPOSICION)
);

-- ================================================================================
-- 5. INSERTAR TIPOS DE SERVICIO BASADOS EN EJEMPLOS
-- ================================================================================

INSERT INTO osgo_tipos_servicio (TIPO_SERVICIO, DESCRIPCION, CATEGORIA, REQUIERE_VEHICULO, REQUIERE_SECTOR) VALUES
-- Servicios Motorizados
('SERVICIO MOTORIZADO', 'Servicio de patrullaje en motocicleta con circuitos específicos', 'MOTORIZADO', TRUE, TRUE),
('SERVICIO MOTORIZADO FRANCO', 'Personal motorizado en día franco disponible para emergencias', 'MOTORIZADO', TRUE, FALSE),

-- Servicios Pedestres
('SERVICIO PEDESTRE', 'Servicio de control de tránsito a pie en intersecciones', 'PEDESTRE', FALSE, TRUE),
('SERVICIO PEDESTRE FRANCO', 'Personal pedestre en día franco para apoyo', 'PEDESTRE', FALSE, FALSE),
('SERVICIOS PEDESTRE', 'Servicios múltiples de control pedestre', 'PEDESTRE', FALSE, TRUE),

-- Servicios de Grúa
('SERVICIO DE GRÚA PARTICULAR', 'Servicio de grúa contratada en caso de no disponer grúas de la empresa', 'GRUA', TRUE, FALSE),

-- Servicios Especiales
('SERVICIO MERCADO MAYORISTA', 'Servicio especial para control en mercado mayorista', 'MERCADO', FALSE, TRUE),
('SERVICIO DESDE LAS 16:15', 'Servicio especial con horario específico', 'ESPECIAL', FALSE, TRUE),

-- Servicios Específicos por Zona
('SERVICIO CONTROL INTERPROVINCIALES', 'Control específico de buses interprovinciales', 'ESPECIAL', FALSE, TRUE),
('SERVICIO CONTROL SEMÁFORO', 'Control específico en semáforos', 'ESPECIAL', FALSE, TRUE);

-- ================================================================================
-- 6. INSERTAR DISPOSICIONES GENERALES BASADAS EN EJEMPLOS
-- ================================================================================

INSERT INTO osgo_disposiciones_generales (NUMERO_DISPOSICION, TITULO, CONTENIDO, CATEGORIA) VALUES
(1, 'Procedimiento en caso de accidentes de tránsito', 
'Para en caso de accidentes de tránsito, a los que acuden el cuerpo de agentes civiles de tránsito se dispone el envío inmediato y obligatorio del extracto una vez finalizado el procedimiento así mismo la entrega del parte en físico dentro de las 24 horas a la coordinadora de operaciones.', 
'ACCIDENTES'),

(2, 'Facultades para ejecución de operativos de control', 
'Sin perjuicio de la ejecución de operativos de control de tránsito, en sus distintas modalidades, cualquier miembro del cuerpo de agentes civiles de tránsito se encuentra facultado de acuerdo con las disposiciones normativas establecidas en la Constitución y la Ley para ejecutar procedimientos de control de tránsito de acuerdo con cualquiera de los tipos contravencionales establecidos en el COIP.', 
'OPERATIVOS'),

(3, 'Obediencia a órdenes superiores', 
'De conformidad con las disposiciones y normativas establecidas en el COESCOP (ART.289#11) es obligación de los miembros del cuerpo de agentes civiles de tránsito obedecer las órdenes legítimas, verbales o escritas emitidas por su jefe inmediato superior.', 
'NORMATIVAS'),

(4, 'Flexibilidad de órdenes de servicio', 
'Las órdenes de servicio están sujetas a cambios en horarios, intersecciones y otras disposiciones según la necesidad y operatividad, razón por la cual se deberá revisar la orden de servicio día anterior a la fecha de trabajo del servidor ACT.', 
'ORDENES'),

(5, 'Operativos de control de motocicletas', 
'En atención con el memorando NRO. EPM-DDCT-2022-0859-M se dispone ejecutar operativos de control de motocicletas, en función a lo establecido en la normativa del artículo 160 del reglamento a la LOTTTSV; así mismo se efectúe operativos de control aquellas motocicletas con modificaciones que no cumplan las condiciones de homologación pertinente.', 
'MOTOCICLETAS'),

(6, 'Reporte obligatorio al ECU 911', 
'Los miembros del cuerpo de agentes civiles de tránsito deberá reportar al ECU.911 todo procedimiento que vayan a tomar con vehículos que cometa contravención en los diferentes sectores de la ciudad de Ibarra.', 
'REPORTES'),

(7, 'Capacidad permitida en motocicletas', 
'De acuerdo a la resolución NRO. 010-DIR-ANT-2022 reglamento que norma la capacidad permitida de personas que se transportan en motocicletas dentro del territorio nacional, el presente tipo contravencional forma parte del glosario de contravenciones de quinta clase, y sanciona a los conductores de motocicletas que transporten un número de personas superior a la capacidad permitida (se ha limitado su capacidad a una persona).', 
'MOTOCICLETAS');

-- ================================================================================
-- VERIFICACIÓN DE DATOS INSERTADOS
-- ================================================================================

SELECT 'Tablas y datos creados exitosamente' AS mensaje;

SELECT 
    (SELECT COUNT(*) FROM osgo_tipos_servicio) AS tipos_servicio_creados,
    (SELECT COUNT(*) FROM osgo_disposiciones_generales) AS disposiciones_creadas;
