-- ================================================================================
-- DATOS DE PRUEBA CORREGIDOS PARA BASE DE DATOS SISTEMA_PRINCIPAL
-- Basado en estructuras reales y ejemplos de órdenes de servicio
-- ================================================================================

USE sistema_principal;

-- Limpiar datos existentes (opcional)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE funciones;
TRUNCATE TABLE personas;
TRUNCATE TABLE grupo_operativo;
TRUNCATE TABLE distritos_agentes;
TRUNCATE TABLE indisponibilidad;
TRUNCATE TABLE tipo_indisponibilidad;
TRUNCATE TABLE tipo_grupo;
TRUNCATE TABLE sistemas;
SET FOREIGN_KEY_CHECKS = 1;

-- ================================================================================
-- 1. FUNCIONES (estructura real: ID_FUNCION, FUNCION, ESTADO_FUNCION)
-- ================================================================================

INSERT INTO funciones (ID_FUNCION, FUNCION, ESTADO_FUNCION) VALUES
-- Funciones principales de gerencia y operaciones
(1, 'GERENTE OPERATIVO DE TRÁNSITO', 'A'),
(2, 'JEFE DE TRÁNSITO', 'A'),
(3, 'SUB JEFE DE TRÁNSITO', 'A'),
(4, 'INSPECTOR DISTRITO CENTRO', 'A'),
(5, 'OPERACIONES P3', 'A'),
(6, 'INSPECTOR DISTRITO SUR', 'A'),
(7, 'INSPECTOR DISTRITO NORTE', 'A'),
(8, 'SUB INSPECTOR CANTÓN PIMAMPIRO', 'A'),
(9, 'CONDUCTOR G.O.T.', 'A'),
(10, 'CONDUCTOR SUB JEFE DE TRÁNSITO', 'A'),

-- Funciones de control de distrito
(11, 'INSPECTOR DE CONTROL GENERAL', 'A'),
(12, 'SUB INSPECTOR DE CONTROL GENERAL', 'A'),

-- Funciones administrativas
(13, 'LOGISTICA P4', 'A'),
(14, 'COORDINACIÓN SIS.ECU.911', 'A'),
(15, 'COMISIONADO CENTRO RETENCIÓN', 'A'),
(16, 'GESTOR DE DATOS', 'A'),
(17, 'ESTADISTICAS GERENCIA OPERATIVA', 'A'),
(18, 'PROCESO DE CHATARRIZACIÓN', 'A'),
(19, 'CUSTODIA INSTALACIONES EPM', 'A'),

-- Funciones de despacho
(20, 'DESPACHO-A', 'A'),
(21, 'DESPACHO-B', 'A'),
(22, 'DESPACHO-C', 'A'),
(23, 'DESPACHO-D', 'A'),
(24, 'DESPACHO-E', 'A'),

-- Funciones de video vigilancia
(25, 'VISOR-A', 'A'),
(26, 'VISOR-B', 'A'),
(27, 'VISOR-C', 'A'),
(28, 'VISOR-D', 'A'),
(29, 'VISOR-E', 'A'),

-- Funciones de control de transporte
(30, 'CONTROL TRANSPORTE PÚBLICO', 'A'),

-- Funciones de retención vehicular
(31, 'CUSTODIA VEHÍCULOS RETENIDOS', 'A'),

-- Funciones de detención de infractores
(32, 'CUSTODIA INFRACTORES DETENIDOS', 'A'),

-- Funciones de grupos operativos
(33, 'GRUPO GESTIÓN OPERATIVA', 'A'),
(34, 'GRUPO OPERATIVO INFORMALIDAD', 'A'),
(35, 'GRUPO OPERATIVO EMBRIAGUEZ', 'A'),
(36, 'EDUCACIÓN VIAL', 'A'),

-- Funciones de conductores
(37, 'CONDUCTOR PATRULLERO', 'A'),
(38, 'CONDUCTOR GRÚA', 'A'),
(39, 'CONDUCTOR MOTORIZADO', 'A');

-- ================================================================================
-- 2. TIPO_GRUPO (estructura: ID_TIPO_GRUPO, TIPO_GRUPO, DESCRIPCION)
-- ================================================================================

INSERT INTO tipo_grupo (ID_TIPO_GRUPO, TIPO_GRUPO, DESCRIPCION) VALUES
(1, 'OPERATIVO', 'Grupo operativo de campo'),
(2, 'ADMINISTRATIVO', 'Grupo administrativo'),
(3, 'SUPERVISIÓN', 'Grupo de supervisión'),
(4, 'ESPECIALIZADO', 'Grupo especializado en tareas específicas');

-- ================================================================================
-- 3. GRUPO_OPERATIVO (estructura: ID_GRUPO_OPERATIVO, GRUPO_OPERATIVO, ID_TIPO_GRUPO, ACTIVO)
-- ================================================================================

INSERT INTO grupo_operativo (ID_GRUPO_OPERATIVO, GRUPO_OPERATIVO, ID_TIPO_GRUPO, ACTIVO) VALUES
(1, 'GRUPO DE GESTIÓN OPERATIVA', 4, 'A'),
(2, 'GRUPO OPERATIVO INFORMALIDAD', 4, 'A'),
(3, 'GRUPO OPERATIVO ESTADOS DE EMBRIAGUEZ', 4, 'A'),
(4, 'EDUCACIÓN VIAL', 4, 'A'),
(5, 'GRUPO PATRULLEROS A', 1, 'A'),
(6, 'GRUPO PATRULLEROS B', 1, 'A'),
(7, 'GRUPO MOTORIZADO', 1, 'A'),
(8, 'GRUPO ADMINISTRATIVO', 2, 'A');

-- ================================================================================
-- 4. DISTRITOS_AGENTES (estructura: ID_DISTRITO_AGENTE, DISTRITO, CANTON)
-- ================================================================================

INSERT INTO distritos_agentes (ID_DISTRITO_AGENTE, DISTRITO, CANTON) VALUES
(1, 'CENTRO', 'IBARRA'),
(2, 'SUR', 'IBARRA'),
(3, 'NORTE', 'IBARRA'),
(4, 'CENTRO', 'PIMAMPIRO'),
(5, 'CENTRO', 'OTAVALO'),
(6, 'CENTRO', 'COTACACHI');

-- ================================================================================
-- 5. PERSONAS (estructura real)
-- ================================================================================

INSERT INTO personas (ID_PERSONA, ID_DISTRITO_AGENTE, ID_FUNCION, CEDULA, NOMBRES, APELLIDOS, CODIGO_AGENTE, TELEFONO_AGENTE, AGENTE, EMAIL, ID_GRUPO_OPERATIVO) VALUES
-- Gerencia y jefaturas
(1, 1, 1, '1001234567', 'MARLON', 'POZO', 'TCL001', '0998765432', 'A', 'marlon.pozo@epm.gob.ec', 8),
(2, 1, 2, '1001234568', 'GISELA', 'LOBATO', 'JT001', '0998765433', 'A', 'gisela.lobato@epm.gob.ec', 8),
(3, 1, 3, '1001234569', 'ABIGAIL', 'AMAGUAÑA', 'SJT001', '0998765434', 'A', 'abigail.amaguaña@epm.gob.ec', 8),
(4, 1, 4, '1001234570', 'ANDRÉS', 'VILLARRUEL', 'IDC001', '0998765435', 'A', 'andres.villarruel@epm.gob.ec', 1),
(5, 1, 5, '1001234571', 'ANDRÉS', 'IPIALES', 'OP3001', '0998765436', 'A', 'andres.ipiales@epm.gob.ec', 1),
(6, 2, 6, '1001234572', 'JEFFERSON', 'PASTRANA', 'IDS001', '0998765437', 'A', 'jefferson.pastrana@epm.gob.ec', 1),
(7, 3, 7, '1001234573', 'SANTIAGO', 'REYES', 'IDN001', '0998765438', 'A', 'santiago.reyes@epm.gob.ec', 1),
(8, 4, 8, '1001234574', 'ANDERSON', 'CALDERON', 'SIP001', '0998765439', 'A', 'anderson.calderon@epm.gob.ec', 1),
(9, 1, 9, '1001234575', 'RICHARD', 'TOBAR', 'CGO001', '0998765440', 'A', 'richard.tobar@epm.gob.ec', 8),
(10, 1, 10, '1001234576', 'ALEJANDRO', 'HUERTAS', 'CSJ001', '0998765441', 'A', 'alejandro.huertas@epm.gob.ec', 8),

-- Inspectores de control
(11, 1, 11, '1001234577', 'LILIAN', 'FRAGA', 'ICG001', '0998765442', 'A', 'lilian.fraga@epm.gob.ec', 1),
(12, 1, 12, '1001234578', 'LUIS', 'ORDOÑEZ', 'ICG002', '0998765443', 'A', 'luis.ordonez@epm.gob.ec', 1),
(13, 1, 11, '1001234579', 'ROSARIO', 'GUANANGA', 'ICG003', '0998765444', 'A', 'rosario.guananga@epm.gob.ec', 1),
(14, 1, 12, '1001234580', 'ANDRÉS', 'PINEDA', 'SIC001', '0998765445', 'A', 'andres.pineda@epm.gob.ec', 1),
(15, 1, 12, '1001234581', 'JOSELYN', 'COLIMBA', 'SIC002', '0998765446', 'A', 'joselyn.colimba@epm.gob.ec', 1),

-- Personal administrativo
(16, 1, 13, '1001234582', 'JHONNY', 'YUCAS', 'LP4001', '0998765447', 'A', 'jhonny.yucas@epm.gob.ec', 8),
(17, 1, 14, '1001234583', 'JULIO', 'BOSMEDIANO', 'CE911', '0998765448', 'A', 'julio.bosmediano@epm.gob.ec', 8),
(18, 1, 15, '1001234584', 'BAIRON', 'MOREJON', 'CRV001', '0998765449', 'A', 'bairon.morejon@epm.gob.ec', 8),
(19, 1, 16, '1001234585', 'EMILY', 'COLIMBA', 'GD001', '0998765450', 'A', 'emily.colimba@epm.gob.ec', 8),
(20, 1, 17, '1001234586', 'MARLON', 'CARVAJAL', 'EGO001', '0998765451', 'A', 'marlon.carvajal@epm.gob.ec', 8),
(21, 1, 18, '1001234587', 'KATHERINE', 'RIOS', 'PC001', '0998765452', 'A', 'katherine.rios@epm.gob.ec', 8),
(22, 1, 19, '1001234588', 'ISRAEL', 'SANDOVAL', 'CIE001', '0998765453', 'A', 'israel.sandoval@epm.gob.ec', 8),

-- Personal de despacho
(23, 1, 20, '1001234590', 'LIZETH', 'ORDOÑEZ', 'DA001', '0998765455', 'A', 'lizeth.ordonez@epm.gob.ec', 8),
(24, 1, 21, '1001234591', 'JESSICA', 'SUAREZ', 'DB001', '0998765456', 'A', 'jessica.suarez@epm.gob.ec', 8),
(25, 1, 22, '1001234592', 'PAUL', 'LUGO', 'DC001', '0998765457', 'A', 'paul.lugo@epm.gob.ec', 8),
(26, 1, 22, '1001234593', 'CESAR', 'PILACUAN', 'DC002', '0998765458', 'A', 'cesar.pilacuan@epm.gob.ec', 8),
(27, 1, 23, '1001234594', 'SILVIA', 'CHICAIZA', 'DD001', '0998765459', 'A', 'silvia.chicaiza@epm.gob.ec', 8),
(28, 1, 24, '1001234595', 'MIGUEL', 'OREJUELA', 'DE001', '0998765460', 'A', 'miguel.orejuela@epm.gob.ec', 8),

-- Personal de video vigilancia
(29, 1, 25, '1001234596', 'ISRAEL', 'PEÑAFIEL', 'VA001', '0998765461', 'A', 'israel.penafiel@epm.gob.ec', 8),
(30, 1, 26, '1001234597', 'DAYSI', 'VILLALVA', 'VB001', '0998765462', 'A', 'daysi.villalva@epm.gob.ec', 8),
(31, 1, 27, '1001234598', 'JESSICA', 'BASTIDAS', 'VC001', '0998765463', 'A', 'jessica.bastidas@epm.gob.ec', 8),
(32, 1, 28, '1001234599', 'IORDAN', 'ESPINOZA', 'VD001', '0998765464', 'A', 'iordan.espinoza@epm.gob.ec', 8),
(33, 1, 29, '1001234600', 'KATHERINE', 'HEREMBAS', 'VE001', '0998765465', 'A', 'katherine.herembas@epm.gob.ec', 8),

-- Personal de control de transporte
(34, 1, 30, '1001234601', 'SUSANA', 'CONSTANTE', 'UCT001', '0998765466', 'A', 'susana.constante@epm.gob.ec', 1),
(35, 1, 30, '1001234602', 'EVELYN', 'QUEREMBAS', 'UCT002', '0998765467', 'A', 'evelyn.querembas@epm.gob.ec', 1),
(36, 1, 30, '1001234603', 'JHON', 'FLORES', 'UCT003', '0998765468', 'A', 'jhon.flores@epm.gob.ec', 1),

-- Personal de retención vehicular
(37, 1, 31, '1001234604', 'MISHEL', 'ORTIZ', 'CRV001', '0998765469', 'A', 'mishel.ortiz@epm.gob.ec', 1),
(38, 1, 31, '1001234605', 'CRISTIAN', 'TUZA', 'CRV002', '0998765470', 'A', 'cristian.tuza@epm.gob.ec', 1),
(39, 1, 31, '1001234606', 'RONNIE', 'RECALDE', 'CRV003', '0998765471', 'A', 'ronnie.recalde@epm.gob.ec', 1),
(40, 1, 31, '1001234607', 'WILIAM', 'PINTO', 'CRV004', '0998765472', 'A', 'wiliam.pinto@epm.gob.ec', 1),
(41, 1, 31, '1001234608', 'SANTIAGO', 'DURAN', 'CRV005', '0998765473', 'A', 'santiago.duran@epm.gob.ec', 1),
(42, 1, 31, '1001234609', 'KEVIN', 'JACOME', 'CRV006', '0998765474', 'A', 'kevin.jacome@epm.gob.ec', 1),
(43, 1, 31, '1001234610', 'LENIN', 'MOLINA', 'CRV007', '0998765475', 'A', 'lenin.molina@epm.gob.ec', 1),
(44, 1, 31, '1001234611', 'FRANCISCO', 'NEGRETE', 'CRV008', '0998765476', 'A', 'francisco.negrete@epm.gob.ec', 1),
(45, 1, 31, '1001234612', 'JHON', 'CADENA', 'CRV009', '0998765477', 'A', 'jhon.cadena@epm.gob.ec', 1),
(46, 1, 31, '1001234613', 'BYRON', 'TORRES', 'CRV010', '0998765478', 'A', 'byron.torres@epm.gob.ec', 1),
(47, 1, 31, '1001234614', 'MARCO', 'CARLOSAMA', 'CRV011', '0998765479', 'A', 'marco.carlosama@epm.gob.ec', 1),

-- Personal de detención de infractores
(48, 1, 32, '1001234615', 'CRISTIAN', 'LAHUATTE', 'CDI001', '0998765480', 'A', 'cristian.lahuatte@epm.gob.ec', 1),
(49, 1, 32, '1001234616', 'FRANKLIN', 'MAYORGA', 'CDI002', '0998765481', 'A', 'franklin.mayorga@epm.gob.ec', 1),
(50, 1, 32, '1001234617', 'JONATHAN', 'MANZO', 'CDI003', '0998765482', 'A', 'jonathan.manzo@epm.gob.ec', 1),
(51, 1, 32, '1001234618', 'MIGUEL', 'DIAZ', 'CDI004', '0998765483', 'A', 'miguel.diaz@epm.gob.ec', 1),
(52, 1, 32, '1001234619', 'HAMILTON', 'PUERRES', 'CDI005', '0998765484', 'A', 'hamilton.puerres@epm.gob.ec', 1),

-- Grupos operativos
(53, 1, 33, '1001234620', 'DARIO', 'ORTEGA', 'GGO001', '0998765485', 'A', 'dario.ortega@epm.gob.ec', 1),
(54, 1, 33, '1001234621', 'LEYNER', 'CONGO', 'GGO002', '0998765486', 'A', 'leyner.congo@epm.gob.ec', 1),
(55, 1, 34, '1001234622', 'ISRAEL', 'BASTIDAS', 'GOI001', '0998765487', 'A', 'israel.bastidas@epm.gob.ec', 2),
(56, 1, 34, '1001234623', 'RONALD', 'GONZALON', 'GOI002', '0998765488', 'A', 'ronald.gonzalon@epm.gob.ec', 2),
(57, 1, 35, '1001234624', 'ANDREA', 'MORILLO', 'GOE001', '0998765489', 'A', 'andrea.morillo@epm.gob.ec', 3),
(58, 1, 35, '1001234625', 'ANGELO', 'DIAZ', 'GOE002', '0998765490', 'A', 'angelo.diaz@epm.gob.ec', 3),
(59, 1, 36, '1001234626', 'ANDRÉS', 'SANCHEZ', 'EV001', '0998765491', 'A', 'andres.sanchez@epm.gob.ec', 4),
(60, 1, 36, '1001234627', 'XAVIER', 'MORENO', 'EV002', '0998765492', 'A', 'xavier.moreno@epm.gob.ec', 4),

-- Conductores de patrulleros
(61, 1, 37, '1001234629', 'STALIN', 'VALENCIA', 'CP001', '0998765494', 'A', 'stalin.valencia@epm.gob.ec', 5),
(62, 1, 37, '1001234630', 'MISHEL', 'MONTENEGRO', 'CP002', '0998765495', 'A', 'mishel.montenegro@epm.gob.ec', 5),
(63, 1, 37, '1001234631', 'ERICK', 'MANOSALVAS', 'CP003', '0998765496', 'A', 'erick.manosalvas@epm.gob.ec', 5),
(64, 1, 37, '1001234632', 'LEONIDAS', 'COLIMBA', 'CP004', '0998765497', 'A', 'leonidas.colimba@epm.gob.ec', 5),
(65, 1, 37, '1001234633', 'MISHEL', 'PILLO', 'CP005', '0998765498', 'A', 'mishel.pillo@epm.gob.ec', 5),
(66, 1, 37, '1001234634', 'RICHARD', 'ENRIQUEZ', 'CP006', '0998765499', 'A', 'richard.enriquez@epm.gob.ec', 6),
(67, 1, 37, '1001234635', 'ANDRÉS', 'LOZA', 'CP007', '0998765500', 'A', 'andres.loza@epm.gob.ec', 6),
(68, 1, 37, '1001234636', 'LUIS', 'MORALES', 'CP008', '0998765501', 'A', 'luis.morales@epm.gob.ec', 6),
(69, 1, 37, '1001234637', 'FATIMA', 'TUZA', 'CP009', '0998765502', 'A', 'fatima.tuza@epm.gob.ec', 6),
(70, 1, 37, '1001234638', 'CRISTIAN', 'MONTESDEOCA', 'CP010', '0998765503', 'A', 'cristian.montesdeoca@epm.gob.ec', 6),
(71, 1, 37, '1001234639', 'SANTIAGO', 'IRUA', 'CP011', '0998765504', 'A', 'santiago.irua@epm.gob.ec', 5),
(72, 1, 37, '1001234640', 'CARLOS', 'GOMEZ', 'CP012', '0998765505', 'A', 'carlos.gomez@epm.gob.ec', 5),
(73, 1, 37, '1001234641', 'DANIEL', 'ROBLES', 'CP013', '0998765506', 'A', 'daniel.robles@epm.gob.ec', 5),
(74, 1, 37, '1001234642', 'PAUL', 'ROSAS', 'CP014', '0998765507', 'A', 'paul.rosas@epm.gob.ec', 6),
(75, 1, 37, '1001234643', 'FELIPE', 'TORRES', 'CP015', '0998765508', 'A', 'felipe.torres@epm.gob.ec', 6),
(76, 1, 37, '1001234644', 'CARLOS', 'CONGO', 'CP016', '0998765509', 'A', 'carlos.congo@epm.gob.ec', 6),

-- Conductores de grúa
(77, 1, 38, '1001234645', 'CARLOS', 'MEJÍA', 'CG001', '0998765510', 'A', 'carlos.mejia@epm.gob.ec', 1),

-- Conductores franco
(78, 1, 37, '1001234646', 'ANDERSON', 'RAMOS', 'CF001', '0998765511', 'A', 'anderson.ramos@epm.gob.ec', 5),
(79, 1, 37, '1001234647', 'EDWIN', 'ILES', 'CF002', '0998765512', 'A', 'edwin.iles@epm.gob.ec', 5),
(80, 1, 37, '1001234648', 'JORGE', 'ROSERO', 'CF003', '0998765513', 'A', 'jorge.rosero@epm.gob.ec', 6),
(81, 1, 37, '1001234649', 'STALIN', 'BELTRAN', 'CF004', '0998765514', 'A', 'stalin.beltran@epm.gob.ec', 6),

-- Personal motorizado
(82, 1, 39, '1001234650', 'CARLOS', 'CAICEDO', 'M084', '0998765515', 'A', 'carlos.caicedo@epm.gob.ec', 7),
(83, 1, 39, '1001234651', 'FERNANDO', 'FALCON', 'M125', '0998765516', 'A', 'fernando.falcon@epm.gob.ec', 7),
(84, 1, 39, '1001234652', 'DANIELA', 'NAVARRO', 'M177', '0998765517', 'A', 'daniela.navarro@epm.gob.ec', 7),
(85, 1, 39, '1001234653', 'CRISTIAN', 'SANCHEZ', 'M531', '0998765518', 'A', 'cristian.sanchez@epm.gob.ec', 7);

-- ================================================================================
-- 6. TIPO_INDISPONIBILIDAD (estructura: ID_TIPO_INDISPONIBILIDAD, TIPO_INDISPONIBILIDAD, ESTADO)
-- ================================================================================

INSERT INTO tipo_indisponibilidad (ID_TIPO_INDISPONIBILIDAD, TIPO_INDISPONIBILIDAD, ESTADO) VALUES
(1, 'VACACIONES', 'A'),
(2, 'ENFERMEDAD', 'A'),
(3, 'LICENCIA', 'A'),
(4, 'CAPACITACIÓN', 'A'),
(5, 'COMISIÓN DE SERVICIOS', 'A'),
(6, 'FRANCO', 'A'),
(7, 'PERMISO PERSONAL', 'A');

-- ================================================================================
-- 7. INDISPONIBILIDAD (estructura: ID_INDISPONIBILIDAD, ID_USUARIO, ID_TIPO_INDISPONIBILIDAD, FECHA_DESDE, FECHA_HASTA)
-- Nota: Usamos ID_USUARIO que debe corresponder a ID_PERSONA
-- ================================================================================

INSERT INTO indisponibilidad (ID_INDISPONIBILIDAD, ID_USUARIO, ID_TIPO_INDISPONIBILIDAD, FECHA_DESDE, FECHA_HASTA) VALUES
-- Algunas indisponibilidades de ejemplo
(1, 15, 1, '2025-09-15 00:00:00', '2025-09-20 23:59:59'),
(2, 32, 2, '2025-09-18 00:00:00', '2025-09-19 23:59:59'),
(3, 45, 7, '2025-09-17 08:00:00', '2025-09-17 17:00:00'),
(4, 58, 4, '2025-09-16 08:00:00', '2025-09-20 17:00:00'),
(5, 72, 6, '2025-09-19 00:00:00', '2025-09-19 23:59:59');

-- ================================================================================
-- 8. SISTEMAS (estructura: ID_SISTEMA, NOMBRE_SISTEMA, ESTADO_SISTEMA)
-- ================================================================================

INSERT INTO sistemas (ID_SISTEMA, NOMBRE_SISTEMA, ESTADO_SISTEMA) VALUES
(1, 'OSGO', 'A'),
(2, 'SIS.ECU.911', 'A'),
(3, 'SISTEMA DE RETENCIÓN VEHICULAR', 'A'),
(4, 'SISTEMA DE DETENCIÓN', 'A'),
(5, 'SISTEMA DE VIDEO VIGILANCIA', 'A'),
(6, 'SISTEMA DE DESPACHO', 'A');

-- ================================================================================
-- MENSAJES DE CONFIRMACIÓN
-- ================================================================================

SELECT 'Datos de prueba insertados correctamente en sistema_principal' AS mensaje;
SELECT 
    (SELECT COUNT(*) FROM funciones) AS total_funciones,
    (SELECT COUNT(*) FROM personas) AS total_personas,
    (SELECT COUNT(*) FROM grupo_operativo) AS total_grupos,
    (SELECT COUNT(*) FROM distritos_agentes) AS total_distritos,
    (SELECT COUNT(*) FROM indisponibilidad) AS total_indisponibilidades,
    (SELECT COUNT(*) FROM tipo_indisponibilidad) AS total_tipos_indisponibilidad,
    (SELECT COUNT(*) FROM tipo_grupo) AS total_tipos_grupo,
    (SELECT COUNT(*) FROM sistemas) AS total_sistemas;
