-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2025 a las 21:21:03
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_principal`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distritos_agentes`
--

CREATE TABLE `distritos_agentes` (
  `ID_DISTRITO_AGENTE` int(11) NOT NULL,
  `DISTRITO` varchar(8) DEFAULT NULL,
  `CANTON` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `distritos_agentes`
--

INSERT INTO `distritos_agentes` (`ID_DISTRITO_AGENTE`, `DISTRITO`, `CANTON`) VALUES
(1, 'CENTRO', 'IBARRA'),
(2, 'SUR', 'IBARRA'),
(3, 'NORTE', 'IBARRA'),
(4, 'CENTRO', 'PIMAMPIRO'),
(5, 'CENTRO', 'OTAVALO'),
(6, 'CENTRO', 'COTACACHI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones`
--

CREATE TABLE `funciones` (
  `ID_FUNCION` int(11) NOT NULL,
  `FUNCION` varchar(40) DEFAULT NULL,
  `ESTADO_FUNCION` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `funciones`
--

INSERT INTO `funciones` (`ID_FUNCION`, `FUNCION`, `ESTADO_FUNCION`) VALUES
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
(11, 'INSPECTOR DE CONTROL GENERAL', 'A'),
(12, 'INSPECTOR DE CONTROL GENERAL', 'A'),
(13, 'LOGÍSTICA P4', 'A'),
(14, 'COORDINACIÓN SIS.ECU.911', 'A'),
(15, 'COMISIONADO CENTRO RETENCIÓN', 'A'),
(16, 'GESTOR DE DATOS', 'A'),
(17, 'ESTADÍSTICAS GERENCIA OPERATIVA', 'A'),
(18, 'PROCESO DE CHATARRIZACIÓN', 'A'),
(19, 'CUSTODIA INSTALACIONES EPM', 'A'),
(20, 'DESPACHO-A', 'A'),
(21, 'DESPACHO-B', 'A'),
(22, 'DESPACHO-C', 'A'),
(23, 'DESPACHO-D', 'A'),
(24, 'DESPACHO-E', 'A'),
(25, 'VISOR-A', 'A'),
(26, 'VISOR-B', 'A'),
(27, 'VISOR-C', 'A'),
(28, 'VISOR-D', 'A'),
(29, 'VISOR-E', 'A'),
(30, 'CONTROL TRANSPORTE PÚBLICO', 'A'),
(31, 'CUSTODIA VEHÍCULOS RETENIDOS', 'A'),
(32, 'CUSTODIA INFRACTORES DETENIDOS', 'A'),
(33, 'GRUPO GESTIÓN OPERATIVA', 'A'),
(34, 'GRUPO OPERATIVO INFORMALIDAD', 'A'),
(35, 'GRUPO OPERATIVO EMBRIAGUEZ', 'A'),
(36, 'EDUCACIÓN VIAL', 'A'),
(37, 'CONDUCTOR PATRULLERO', 'A'),
(38, 'CONDUCTOR GRÚA', 'A'),
(39, 'CONDUCTOR MOTORIZADO', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_operativo`
--

CREATE TABLE `grupo_operativo` (
  `ID_GRUPO_OPERATIVO` int(11) NOT NULL,
  `GRUPO_OPERATIVO` varchar(50) DEFAULT NULL,
  `ID_TIPO_GRUPO` int(11) DEFAULT NULL,
  `ACTIVO` varchar(2) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupo_operativo`
--

INSERT INTO `grupo_operativo` (`ID_GRUPO_OPERATIVO`, `GRUPO_OPERATIVO`, `ID_TIPO_GRUPO`, `ACTIVO`) VALUES
(1, 'GRUPO DE GESTI├ôN OPERATIVA', 4, 'A'),
(2, 'GRUPO OPERATIVO INFORMALIDAD', 4, 'A'),
(3, 'GRUPO OPERATIVO ESTADOS DE EMBRIAGUEZ', 4, 'A'),
(4, 'EDUCACI├ôN VIAL', 4, 'A'),
(5, 'GRUPO PATRULLEROS A', 1, 'A'),
(6, 'GRUPO PATRULLEROS B', 1, 'A'),
(7, 'GRUPO MOTORIZADO', 1, 'A'),
(8, 'GRUPO ADMINISTRATIVO', 2, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indisponibilidad`
--

CREATE TABLE `indisponibilidad` (
  `ID_INDISPONIBILIDAD` int(11) NOT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `ID_TIPO_INDISPONIBILIDAD` int(11) DEFAULT NULL,
  `FECHA_DESDE` datetime DEFAULT NULL,
  `FECHA_HASTA` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `indisponibilidad`
--

INSERT INTO `indisponibilidad` (`ID_INDISPONIBILIDAD`, `ID_USUARIO`, `ID_TIPO_INDISPONIBILIDAD`, `FECHA_DESDE`, `FECHA_HASTA`) VALUES
(1, 15, 1, '2025-09-15 00:00:00', '2025-09-20 23:59:59'),
(2, 32, 2, '2025-09-18 00:00:00', '2025-09-19 23:59:59'),
(3, 45, 7, '2025-09-17 08:00:00', '2025-09-17 17:00:00'),
(4, 58, 4, '2025-09-16 08:00:00', '2025-09-20 17:00:00'),
(5, 72, 6, '2025-09-19 00:00:00', '2025-09-19 23:59:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `ID_PERSONA` int(11) NOT NULL,
  `ID_DISTRITO_AGENTE` int(11) DEFAULT NULL,
  `ID_FUNCION` int(11) DEFAULT NULL,
  `CEDULA` varchar(10) DEFAULT NULL,
  `NOMBRES` varchar(30) DEFAULT NULL,
  `APELLIDOS` varchar(30) DEFAULT NULL,
  `CODIGO_AGENTE` varchar(6) DEFAULT NULL,
  `TELEFONO_AGENTE` varchar(12) DEFAULT NULL,
  `AGENTE` char(2) DEFAULT NULL,
  `EMAIL` varchar(40) DEFAULT NULL,
  `ID_GRUPO_OPERATIVO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`ID_PERSONA`, `ID_DISTRITO_AGENTE`, `ID_FUNCION`, `CEDULA`, `NOMBRES`, `APELLIDOS`, `CODIGO_AGENTE`, `TELEFONO_AGENTE`, `AGENTE`, `EMAIL`, `ID_GRUPO_OPERATIVO`) VALUES
(1, 1, 1, '1001234567', 'MARLON', 'POZO', 'TCL001', '0998765432', 'A', 'marlon.pozo@epm.gob.ec', 8),
(2, 1, 2, '1001234568', 'GISELA', 'LOBATO', 'JT001', '0998765433', 'A', 'gisela.lobato@epm.gob.ec', 8),
(3, 1, 3, '1001234569', 'ABIGAIL', 'AMAGUAÑA', 'SJT001', '0998765434', 'A', 'abigail.amagua├▒a@epm.gob.ec', 8),
(4, 1, 4, '1001234570', 'ANDRÉS', 'VILLARRUEL', 'IDC001', '0998765435', 'A', 'andres.villarruel@epm.gob.ec', 1),
(5, 1, 5, '1001234571', 'ANDRÉS', 'IPIALES', 'OP3001', '0998765436', 'A', 'andres.ipiales@epm.gob.ec', 1),
(6, 2, 6, '1001234572', 'JEFFERSON', 'PASTRANA', 'IDS001', '0998765437', 'A', 'jefferson.pastrana@epm.gob.ec', 1),
(7, 3, 7, '1001234573', 'SANTIAGO', 'REYES', 'IDN001', '0998765438', 'A', 'santiago.reyes@epm.gob.ec', 1),
(8, 4, 8, '1001234574', 'ANDERSON', 'CALDERON', 'SIP001', '0998765439', 'A', 'anderson.calderon@epm.gob.ec', 1),
(9, 1, 9, '1001234575', 'RICHARD', 'TOBAR', 'CGO001', '0998765440', 'A', 'richard.tobar@epm.gob.ec', 8),
(10, 1, 10, '1001234576', 'ALEJANDRO', 'HUERTAS', 'CSJ001', '0998765441', 'A', 'alejandro.huertas@epm.gob.ec', 8),
(11, 1, 11, '1001234577', 'LILIAN', 'FRAGA', 'ICG001', '0998765442', 'A', 'lilian.fraga@epm.gob.ec', 1),
(12, 1, 12, '1001234578', 'LUIS', 'ORDOÑEZ', 'ICG002', '0998765443', 'A', 'luis.ordonez@epm.gob.ec', 1),
(13, 1, 11, '1001234579', 'ROSARIO', 'GUANANGA', 'ICG003', '0998765444', 'A', 'rosario.guananga@epm.gob.ec', 1),
(14, 1, 12, '1001234580', 'ANDRÉS', 'PINEDA', 'SIC001', '0998765445', 'A', 'andres.pineda@epm.gob.ec', 1),
(15, 1, 12, '1001234581', 'JOSELYN', 'COLIMBA', 'SIC002', '0998765446', 'A', 'joselyn.colimba@epm.gob.ec', 1),
(16, 1, 13, '1001234582', 'JHONNY', 'YUCAS', 'LP4001', '0998765447', 'A', 'jhonny.yucas@epm.gob.ec', 8),
(17, 1, 14, '1001234583', 'JULIO', 'BOSMEDIANO', 'CE911', '0998765448', 'A', 'julio.bosmediano@epm.gob.ec', 8),
(18, 1, 15, '1001234584', 'BAIRON', 'MOREJON', 'CRV001', '0998765449', 'A', 'bairon.morejon@epm.gob.ec', 8),
(19, 1, 16, '1001234585', 'EMILY', 'COLIMBA', 'GD001', '0998765450', 'A', 'emily.colimba@epm.gob.ec', 8),
(20, 1, 17, '1001234586', 'MARLON', 'CARVAJAL', 'EGO001', '0998765451', 'A', 'marlon.carvajal@epm.gob.ec', 8),
(21, 1, 18, '1001234587', 'KATHERINE', 'RIOS', 'PC001', '0998765452', 'A', 'katherine.rios@epm.gob.ec', 8),
(22, 1, 19, '1001234588', 'ISRAEL', 'SANDOVAL', 'CIE001', '0998765453', 'A', 'israel.sandoval@epm.gob.ec', 8),
(23, 1, 20, '1001234590', 'LIZETH', 'ORDOÑEZ', 'DA001', '0998765455', 'A', 'lizeth.ordonez@epm.gob.ec', 8),
(24, 1, 21, '1001234591', 'JESSICA', 'SUAREZ', 'DB001', '0998765456', 'A', 'jessica.suarez@epm.gob.ec', 8),
(25, 1, 22, '1001234592', 'PAUL', 'LUGO', 'DC001', '0998765457', 'A', 'paul.lugo@epm.gob.ec', 8),
(26, 1, 22, '1001234593', 'CESAR', 'PILACUAN', 'DC002', '0998765458', 'A', 'cesar.pilacuan@epm.gob.ec', 8),
(27, 1, 23, '1001234594', 'SILVIA', 'CHICAIZA', 'DD001', '0998765459', 'A', 'silvia.chicaiza@epm.gob.ec', 8),
(28, 1, 24, '1001234595', 'MIGUEL', 'OREJUELA', 'DE001', '0998765460', 'A', 'miguel.orejuela@epm.gob.ec', 8),
(29, 1, 25, '1001234596', 'ISRAEL', 'PEÑAFIEL', 'VA001', '0998765461', 'A', 'israel.penafiel@epm.gob.ec', 8),
(30, 1, 26, '1001234597', 'DAYSI', 'VILLALVA', 'VB001', '0998765462', 'A', 'daysi.villalva@epm.gob.ec', 8),
(31, 1, 27, '1001234598', 'JESSICA', 'BASTIDAS', 'VC001', '0998765463', 'A', 'jessica.bastidas@epm.gob.ec', 8),
(32, 1, 28, '1001234599', 'IORDAN', 'ESPINOZA', 'VD001', '0998765464', 'A', 'iordan.espinoza@epm.gob.ec', 8),
(33, 1, 29, '1001234600', 'KATHERINE', 'HEREMBAS', 'VE001', '0998765465', 'A', 'katherine.herembas@epm.gob.ec', 8),
(34, 1, 30, '1001234601', 'SUSANA', 'CONSTANTE', 'UCT001', '0998765466', 'A', 'susana.constante@epm.gob.ec', 1),
(35, 1, 30, '1001234602', 'EVELYN', 'QUEREMBAS', 'UCT002', '0998765467', 'A', 'evelyn.querembas@epm.gob.ec', 1),
(36, 1, 30, '1001234603', 'JHON', 'FLORES', 'UCT003', '0998765468', 'A', 'jhon.flores@epm.gob.ec', 1),
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
(48, 1, 32, '1001234615', 'CRISTIAN', 'LAHUATTE', 'CDI001', '0998765480', 'A', 'cristian.lahuatte@epm.gob.ec', 1),
(49, 1, 32, '1001234616', 'FRANKLIN', 'MAYORGA', 'CDI002', '0998765481', 'A', 'franklin.mayorga@epm.gob.ec', 1),
(50, 1, 32, '1001234617', 'JONATHAN', 'MANZO', 'CDI003', '0998765482', 'A', 'jonathan.manzo@epm.gob.ec', 1),
(51, 1, 32, '1001234618', 'MIGUEL', 'DIAZ', 'CDI004', '0998765483', 'A', 'miguel.diaz@epm.gob.ec', 1),
(52, 1, 32, '1001234619', 'HAMILTON', 'PUERRES', 'CDI005', '0998765484', 'A', 'hamilton.puerres@epm.gob.ec', 1),
(53, 1, 33, '1001234620', 'DARIO', 'ORTEGA', 'GGO001', '0998765485', 'A', 'dario.ortega@epm.gob.ec', 1),
(54, 1, 33, '1001234621', 'LEYNER', 'CONGO', 'GGO002', '0998765486', 'A', 'leyner.congo@epm.gob.ec', 1),
(55, 1, 34, '1001234622', 'ISRAEL', 'BASTIDAS', 'GOI001', '0998765487', 'A', 'israel.bastidas@epm.gob.ec', 2),
(56, 1, 34, '1001234623', 'RONALD', 'GONZALON', 'GOI002', '0998765488', 'A', 'ronald.gonzalon@epm.gob.ec', 2),
(57, 1, 35, '1001234624', 'ANDREA', 'MORILLO', 'GOE001', '0998765489', 'A', 'andrea.morillo@epm.gob.ec', 3),
(58, 1, 35, '1001234625', 'ANGELO', 'DIAZ', 'GOE002', '0998765490', 'A', 'angelo.diaz@epm.gob.ec', 3),
(59, 1, 36, '1001234626', 'ANDRÉS', 'SANCHEZ', 'EV001', '0998765491', 'A', 'andres.sanchez@epm.gob.ec', 4),
(60, 1, 36, '1001234627', 'XAVIER', 'MORENO', 'EV002', '0998765492', 'A', 'xavier.moreno@epm.gob.ec', 4),
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
(77, 1, 38, '1001234645', 'CARLOS', 'MEJÍA', 'CG001', '0998765510', 'A', 'carlos.mejia@epm.gob.ec', 1),
(78, 1, 37, '1001234646', 'ANDERSON', 'RAMOS', 'CF001', '0998765511', 'A', 'anderson.ramos@epm.gob.ec', 5),
(79, 1, 37, '1001234647', 'EDWIN', 'ILES', 'CF002', '0998765512', 'A', 'edwin.iles@epm.gob.ec', 5),
(80, 1, 37, '1001234648', 'JORGE', 'ROSERO', 'CF003', '0998765513', 'A', 'jorge.rosero@epm.gob.ec', 6),
(81, 1, 37, '1001234649', 'STALIN', 'BELTRAN', 'CF004', '0998765514', 'A', 'stalin.beltran@epm.gob.ec', 6),
(82, 1, 39, '1001234650', 'CARLOS', 'CAICEDO', 'M084', '0998765515', 'A', 'carlos.caicedo@epm.gob.ec', 7),
(83, 1, 39, '1001234651', 'FERNANDO', 'FALCON', 'M125', '0998765516', 'A', 'fernando.falcon@epm.gob.ec', 7),
(84, 1, 39, '1001234652', 'DANIELA', 'NAVARRO', 'M177', '0998765517', 'A', 'daniela.navarro@epm.gob.ec', 7),
(85, 1, 39, '1001234653', 'CRISTIAN', 'SANCHEZ', 'M531', '0998765518', 'A', 'cristian.sanchez@epm.gob.ec', 7),
(86, NULL, NULL, NULL, 'PAZMIÑO ARIAS', 'LUIS ALBERTO', '1', NULL, 'SI', NULL, NULL),
(87, NULL, NULL, NULL, 'MANUEL DIEGO', 'QUISHPE PICHO', '9', NULL, 'SI', NULL, NULL),
(88, NULL, NULL, NULL, 'FRANKLIN GUSTAVO', 'ARBOLEDA VALDERDE', '4', NULL, 'SI', NULL, NULL),
(89, NULL, NULL, NULL, 'ELVIS VINICIO', 'ARCINIEGASOLANO', '7', NULL, 'SI', NULL, NULL),
(90, NULL, NULL, NULL, 'HEREDIA MEJIA', 'JOSE DANILO', '3', NULL, 'SI', NULL, NULL),
(91, 1, 15, NULL, 'MAFLA', 'BRYAN', '001', NULL, 'SI', NULL, NULL),
(92, 1, 28, NULL, 'AVILA', 'JONATHAN', '002', NULL, 'SI', NULL, NULL),
(93, 1, 26, NULL, 'FERNANDEZ', 'MAYRA', '003', NULL, 'SI', NULL, NULL),
(94, 1, 33, NULL, 'BATIOJA', 'EDUARDO', '004', NULL, 'SI', NULL, NULL),
(95, 1, 17, NULL, 'POZO', 'ALEXANDER', '005', NULL, 'SI', NULL, NULL),
(96, 1, 28, NULL, 'QUELAL', 'JORGE', '006', NULL, 'SI', NULL, NULL),
(97, 1, 22, NULL, 'GRIJALVA', 'DARIO', '007', NULL, 'SI', NULL, NULL),
(98, 1, 38, NULL, 'CASTRO', 'OMAR', '008', NULL, 'SI', NULL, NULL),
(99, 1, 31, NULL, 'CUASATAR', 'BRYAN', '009', NULL, 'SI', NULL, NULL),
(100, 1, 39, NULL, 'CUAMACAS', 'ANA', '010', NULL, 'SI', NULL, NULL),
(101, 1, 33, NULL, 'TUZA', 'FATIMA', '011', NULL, 'SI', NULL, NULL),
(102, 1, 7, NULL, 'SALAZAR', 'JAVIER', '012', NULL, 'SI', NULL, NULL),
(103, 1, 6, NULL, 'GUERRA', 'GABRIELA', '013', NULL, 'SI', NULL, NULL),
(104, 1, 38, NULL, 'MONTESDEOCA', 'CRISTIAN', '014', NULL, 'SI', NULL, NULL),
(105, 1, 31, NULL, 'CASTRO', 'JUAN', '015', NULL, 'SI', NULL, NULL),
(106, 1, 7, NULL, 'VACA', 'KAREN', '016', NULL, 'SI', NULL, NULL),
(107, 1, 27, NULL, 'RODRIGUEZ', 'DAYSI', '017', NULL, 'SI', NULL, NULL),
(108, 1, 7, NULL, 'ENRIQUEZ', 'RICHARD', '018', NULL, 'SI', NULL, NULL),
(109, 1, 8, NULL, 'TORRES', 'FELIPE', '019', NULL, 'SI', NULL, NULL),
(110, 1, 39, NULL, 'LANDAZURI', 'LEONARDO', '020', NULL, 'SI', NULL, NULL),
(111, 1, 38, NULL, 'MONTENEGRO', 'MISHEL', '021', NULL, 'SI', NULL, NULL),
(112, 1, 9, NULL, 'REVELO', 'TANIA', '022', NULL, 'SI', NULL, NULL),
(113, 1, 29, NULL, 'BENAVIDES', 'GABRIELA', '023', NULL, 'SI', NULL, NULL),
(114, 1, 12, NULL, 'COLIMBA', 'LEONIDAS', '024', NULL, 'SI', NULL, NULL),
(115, 1, 14, NULL, 'CONGO', 'TAMARA', '025', NULL, 'SI', NULL, NULL),
(116, 1, 25, NULL, 'PUPIALES', 'GLORIA', '026', NULL, 'SI', NULL, NULL),
(117, 1, 16, NULL, 'GUERRA', 'DENISE', '027', NULL, 'SI', NULL, NULL),
(118, 1, 27, NULL, 'DELGADO', 'GABRIELA', '028', NULL, 'SI', NULL, NULL),
(119, 1, 24, NULL, 'TORRES', 'SANTIAGO', '029', NULL, 'SI', NULL, NULL),
(120, 1, 25, NULL, 'MAYANQUER', 'JHON', '030', NULL, 'SI', NULL, NULL),
(121, 1, 12, NULL, 'CASTILLO', 'CARLOS', '031', NULL, 'SI', NULL, NULL),
(122, 1, 17, NULL, 'SANDOVAL', 'ISRAEL', '032', NULL, 'SI', NULL, NULL),
(123, 1, 32, NULL, 'CAMPOS', 'JENIFFER', '033', NULL, 'SI', NULL, NULL),
(124, 1, 16, NULL, 'MORQUECHO', 'DIEGO', '034', NULL, 'SI', NULL, NULL),
(125, 1, 28, NULL, 'AYALA', 'JHONNY', '035', NULL, 'SI', NULL, NULL),
(126, 1, 12, NULL, 'MANTECA', 'CRISTINA', '036', NULL, 'SI', NULL, NULL),
(127, 1, 9, NULL, 'NAVARRO', 'KATHERINE', '037', NULL, 'SI', NULL, NULL),
(128, 1, 17, NULL, 'PLACENCIA', 'BYRON', '038', NULL, 'SI', NULL, NULL),
(129, 1, 11, NULL, 'CHAUCA', 'CRISTIAN', '039', NULL, 'SI', NULL, NULL),
(130, 1, 6, NULL, 'TOMAICO', 'MILTON', '040', NULL, 'SI', NULL, NULL),
(131, 1, 1, NULL, 'MINA', 'GRACE', '041', NULL, 'SI', NULL, NULL),
(132, 1, 21, NULL, 'UBIDIA', 'LUIS', '042', NULL, 'SI', NULL, NULL),
(133, 1, 35, NULL, 'CHISAGUANO', 'CRISTIAN', '043', NULL, 'SI', NULL, NULL),
(134, 1, 6, NULL, 'TANGOS', '', '044', NULL, 'SI', NULL, NULL),
(135, 1, 19, NULL, 'GOMEZ', 'CARLOS', '045', NULL, 'SI', NULL, NULL),
(136, 1, 29, NULL, 'VALENCIA', 'STALIN', '046', NULL, 'SI', NULL, NULL),
(137, 1, 3, NULL, 'RAMOS', 'ANDERSON', '047', NULL, 'SI', NULL, NULL),
(138, 1, 24, NULL, 'JACOME', 'BRYAN', '048', NULL, 'SI', NULL, NULL),
(139, 1, 27, NULL, 'ROSAS', 'PAUL', '049', NULL, 'SI', NULL, NULL),
(140, 1, 22, NULL, 'MANOSALVAS', 'ERICK', '050', NULL, 'SI', NULL, NULL),
(141, 1, 8, NULL, 'MORALES', 'LUIS', '051', NULL, 'SI', NULL, NULL),
(142, 1, 28, NULL, 'ILES', 'EDWIN', '052', NULL, 'SI', NULL, NULL),
(143, 1, 9, NULL, 'GUALACATA', 'EMERSON', '053', NULL, 'SI', NULL, NULL),
(144, 1, 12, NULL, 'ROBLES', 'DANIEL', '054', NULL, 'SI', NULL, NULL),
(145, 1, 18, NULL, 'PILLO', 'MISHEL', '055', NULL, 'SI', NULL, NULL),
(146, 1, 33, NULL, 'IRUA', 'SANTIAGO', '056', NULL, 'SI', NULL, NULL),
(147, 1, 29, NULL, 'BELTRAN', 'STALIN', '099', NULL, 'SI', NULL, NULL),
(148, 1, 31, NULL, 'ROSERO', 'JORGE', '100', NULL, 'SI', NULL, NULL),
(149, 1, 19, NULL, 'CONGO', 'CARLOS', '101', NULL, 'SI', NULL, NULL),
(150, 1, 26, NULL, 'CORTEZ', 'GEOVANNY', '102', NULL, 'SI', NULL, NULL),
(151, 1, 30, NULL, 'HEREDIA', 'JOSE', '103', NULL, 'SI', NULL, NULL),
(152, 1, 15, NULL, 'PLACA', '', '104', NULL, 'SI', NULL, NULL),
(153, 1, 20, NULL, 'CARRERA', 'DANIELA', '105', NULL, 'SI', NULL, NULL),
(154, 1, 18, NULL, 'CONGO', 'GRECIA', '106', NULL, 'SI', NULL, NULL),
(155, 1, 38, NULL, 'ENRIQUEZ', 'JIMMY', '108', NULL, 'SI', NULL, NULL),
(156, 1, 28, NULL, 'FLORES', 'DIANA', '109', NULL, 'SI', NULL, NULL),
(157, 1, 37, NULL, 'FRAGA', 'LILIAN', '110', NULL, 'SI', NULL, NULL),
(158, 1, 39, NULL, 'GARCIA', 'VERONICA', '111', NULL, 'SI', NULL, NULL),
(159, 1, 9, NULL, 'GRIJALVA', 'ISRAEL', '112', NULL, 'SI', NULL, NULL),
(160, 1, 38, NULL, 'MINA', 'ESTEFANIA', '113', NULL, 'SI', NULL, NULL),
(161, 1, 24, NULL, 'HERNANDEZ', 'CRISTIAN', '114', NULL, 'SI', NULL, NULL),
(162, 1, 7, NULL, 'TULCAN', 'EDISON', '115', NULL, 'SI', NULL, NULL),
(163, 1, 21, NULL, 'ANDRADEA', 'PAUL', '116', NULL, 'SI', NULL, NULL),
(164, 1, 33, NULL, 'COLIMBA', 'JOSELYN', '117', NULL, 'SI', NULL, NULL),
(165, 1, 17, NULL, 'MINA', 'EDGAR', '119', NULL, 'SI', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sistemas`
--

CREATE TABLE `sistemas` (
  `ID_SISTEMA` int(11) NOT NULL,
  `NOMBRE_SISTEMA` varchar(80) DEFAULT NULL,
  `ESTADO_SISTEMA` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sistemas`
--

INSERT INTO `sistemas` (`ID_SISTEMA`, `NOMBRE_SISTEMA`, `ESTADO_SISTEMA`) VALUES
(1, 'OSGO', 'A'),
(2, 'SIS.ECU.911', 'A'),
(3, 'SISTEMA DE RETENCI├ôN VEHICULAR', 'A'),
(4, 'SISTEMA DE DETENCI├ôN', 'A'),
(5, 'SISTEMA DE VIDEO VIGILANCIA', 'A'),
(6, 'SISTEMA DE DESPACHO', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_grupo`
--

CREATE TABLE `tipo_grupo` (
  `ID_TIPO_GRUPO` int(11) NOT NULL,
  `TIPO_GRUPO` varchar(50) DEFAULT NULL,
  `DESCRIPCION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_grupo`
--

INSERT INTO `tipo_grupo` (`ID_TIPO_GRUPO`, `TIPO_GRUPO`, `DESCRIPCION`) VALUES
(1, 'OPERATIVO', 'Grupo operativo de campo'),
(2, 'ADMINISTRATIVO', 'Grupo administrativo'),
(3, 'SUPERVISI├ôN', 'Grupo de supervisi├│n'),
(4, 'ESPECIALIZADO', 'Grupo especializado en tareas espec├¡ficas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_indisponibilidad`
--

CREATE TABLE `tipo_indisponibilidad` (
  `ID_TIPO_INDISPONIBILIDAD` int(11) NOT NULL,
  `TIPO_INDISPONIBILIDAD` varchar(60) DEFAULT NULL,
  `ESTADO` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_indisponibilidad`
--

INSERT INTO `tipo_indisponibilidad` (`ID_TIPO_INDISPONIBILIDAD`, `TIPO_INDISPONIBILIDAD`, `ESTADO`) VALUES
(1, 'VACACIONES', 'A'),
(2, 'ENFERMEDAD', 'A'),
(3, 'LICENCIA', 'A'),
(4, 'CAPACITACI?N', 'A'),
(5, 'COMISI?N DE SERVICIOS', 'A'),
(6, 'FRANCO', 'A'),
(7, 'PERMISO PERSONAL', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID_USUARIO` int(11) NOT NULL,
  `ID_PERSONA` int(11) DEFAULT NULL,
  `USUARIO` char(20) DEFAULT NULL,
  `PASS` varchar(256) DEFAULT NULL,
  `ESTADO` char(2) DEFAULT NULL,
  `HASH` varchar(250) DEFAULT NULL,
  `FECHA` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_disponibilidad_por_funcion`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_disponibilidad_por_funcion` (
`ID_FUNCION` int(11)
,`FUNCION` varchar(40)
,`TOTAL_PERSONAS` bigint(21)
,`DISPONIBLES` bigint(21)
,`NO_DISPONIBLES` bigint(21)
,`PORCENTAJE_DISPONIBILIDAD` decimal(26,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_disponibilidad_por_grupo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_disponibilidad_por_grupo` (
`ID_GRUPO_OPERATIVO` int(11)
,`GRUPO_OPERATIVO` varchar(50)
,`TIPO_GRUPO` varchar(50)
,`TOTAL_PERSONAS` bigint(21)
,`DISPONIBLES` bigint(21)
,`NO_DISPONIBLES` bigint(21)
,`PORCENTAJE_DISPONIBILIDAD` decimal(26,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_funciones_principales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_funciones_principales` (
`ID_FUNCION` int(11)
,`FUNCION` varchar(40)
,`total_personas` bigint(21)
,`personas_disponibles` mediumtext
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_opciones_funciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_opciones_funciones` (
`id` int(11)
,`opcion_texto` varchar(76)
,`FUNCION` varchar(40)
,`total_personas` bigint(21)
,`personas_disponibles` bigint(21)
,`personas_no_disponibles` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_opciones_personas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_opciones_personas` (
`id` int(11)
,`opcion_texto` varchar(70)
,`CODIGO_AGENTE` varchar(6)
,`NOMBRES` varchar(30)
,`APELLIDOS` varchar(30)
,`FUNCION` varchar(40)
,`ID_FUNCION` int(11)
,`GRUPO_OPERATIVO` varchar(50)
,`DISTRITO` varchar(8)
,`disponible` int(1)
,`motivo_indisponibilidad` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_personas_disponibles`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_personas_disponibles` (
`ID_PERSONA` int(11)
,`ID_FUNCION` int(11)
,`CODIGO_AGENTE` varchar(6)
,`NOMBRE_COMPLETO` varchar(61)
,`FUNCION` varchar(40)
,`AGENTE` char(2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_personas_no_disponibles`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_personas_no_disponibles` (
`ID_PERSONA` int(11)
,`CODIGO_AGENTE` varchar(6)
,`NOMBRE_COMPLETO` varchar(61)
,`NOMBRES` varchar(30)
,`APELLIDOS` varchar(30)
,`CEDULA` varchar(10)
,`TELEFONO_AGENTE` varchar(12)
,`EMAIL` varchar(40)
,`FUNCION` varchar(40)
,`ID_FUNCION` int(11)
,`GRUPO_OPERATIVO` varchar(50)
,`ID_GRUPO_OPERATIVO` int(11)
,`DISTRITO` varchar(8)
,`CANTON` varchar(20)
,`ID_DISTRITO_AGENTE` int(11)
,`ESTADO_DISPONIBILIDAD` varchar(13)
,`TIPO_INDISPONIBILIDAD` varchar(60)
,`ID_TIPO_INDISPONIBILIDAD` int(11)
,`FECHA_DESDE` datetime
,`FECHA_HASTA` datetime
,`DIAS_INDISPONIBLE` int(8)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_personas_por_distrito`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_personas_por_distrito` (
`ID_DISTRITO_AGENTE` int(11)
,`DISTRITO` varchar(8)
,`CANTON` varchar(20)
,`ID_PERSONA` int(11)
,`CODIGO_AGENTE` varchar(6)
,`NOMBRE_COMPLETO` varchar(61)
,`FUNCION` varchar(40)
,`ID_FUNCION` int(11)
,`GRUPO_OPERATIVO` varchar(50)
,`ESTADO_DISPONIBILIDAD` varchar(13)
,`TIPO_INDISPONIBILIDAD` varchar(60)
,`DISPONIBLE_DESDE` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_proximas_disponibilidades`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_proximas_disponibilidades` (
`ID_PERSONA` int(11)
,`CODIGO_AGENTE` varchar(6)
,`NOMBRE_COMPLETO` varchar(61)
,`FUNCION` varchar(40)
,`GRUPO_OPERATIVO` varchar(50)
,`DISTRITO` varchar(8)
,`TIPO_INDISPONIBILIDAD` varchar(60)
,`DISPONIBLE_DESDE` datetime
,`DIAS_PARA_DISPONIBILIDAD` int(7)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_disponibilidad_por_funcion`
--
DROP TABLE IF EXISTS `v_disponibilidad_por_funcion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_disponibilidad_por_funcion`  AS SELECT `f`.`ID_FUNCION` AS `ID_FUNCION`, `f`.`FUNCION` AS `FUNCION`, count(`p`.`ID_PERSONA`) AS `TOTAL_PERSONAS`, count(case when `disp`.`ID_PERSONA` is not null then 1 end) AS `DISPONIBLES`, count(case when `no_disp`.`ID_PERSONA` is not null then 1 end) AS `NO_DISPONIBLES`, round(count(case when `disp`.`ID_PERSONA` is not null then 1 end) * 100.0 / count(`p`.`ID_PERSONA`),2) AS `PORCENTAJE_DISPONIBILIDAD` FROM (((`funciones` `f` left join `personas` `p` on(`f`.`ID_FUNCION` = `p`.`ID_FUNCION` and `p`.`AGENTE` = 'A')) left join `v_personas_disponibles` `disp` on(`p`.`ID_PERSONA` = `disp`.`ID_PERSONA`)) left join `v_personas_no_disponibles` `no_disp` on(`p`.`ID_PERSONA` = `no_disp`.`ID_PERSONA`)) WHERE `f`.`ESTADO_FUNCION` = 'A' GROUP BY `f`.`ID_FUNCION`, `f`.`FUNCION` ORDER BY `f`.`ID_FUNCION` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_disponibilidad_por_grupo`
--
DROP TABLE IF EXISTS `v_disponibilidad_por_grupo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_disponibilidad_por_grupo`  AS SELECT `g`.`ID_GRUPO_OPERATIVO` AS `ID_GRUPO_OPERATIVO`, `g`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, `tg`.`TIPO_GRUPO` AS `TIPO_GRUPO`, count(`p`.`ID_PERSONA`) AS `TOTAL_PERSONAS`, count(case when `disp`.`ID_PERSONA` is not null then 1 end) AS `DISPONIBLES`, count(case when `no_disp`.`ID_PERSONA` is not null then 1 end) AS `NO_DISPONIBLES`, round(count(case when `disp`.`ID_PERSONA` is not null then 1 end) * 100.0 / count(`p`.`ID_PERSONA`),2) AS `PORCENTAJE_DISPONIBILIDAD` FROM ((((`grupo_operativo` `g` left join `tipo_grupo` `tg` on(`g`.`ID_TIPO_GRUPO` = `tg`.`ID_TIPO_GRUPO`)) left join `personas` `p` on(`g`.`ID_GRUPO_OPERATIVO` = `p`.`ID_GRUPO_OPERATIVO` and `p`.`AGENTE` = 'A')) left join `v_personas_disponibles` `disp` on(`p`.`ID_PERSONA` = `disp`.`ID_PERSONA`)) left join `v_personas_no_disponibles` `no_disp` on(`p`.`ID_PERSONA` = `no_disp`.`ID_PERSONA`)) WHERE `g`.`ACTIVO` = 'A' GROUP BY `g`.`ID_GRUPO_OPERATIVO`, `g`.`GRUPO_OPERATIVO`, `tg`.`TIPO_GRUPO` ORDER BY `g`.`ID_GRUPO_OPERATIVO` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_funciones_principales`
--
DROP TABLE IF EXISTS `v_funciones_principales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_funciones_principales`  AS SELECT `f`.`ID_FUNCION` AS `ID_FUNCION`, `f`.`FUNCION` AS `FUNCION`, count(`p`.`ID_PERSONA`) AS `total_personas`, group_concat(concat(`p`.`CODIGO_AGENTE`,' - ',`p`.`NOMBRES`,' ',`p`.`APELLIDOS`) order by `p`.`NOMBRES` ASC,`p`.`APELLIDOS` ASC separator '|') AS `personas_disponibles` FROM (`funciones` `f` left join `personas` `p` on(`f`.`ID_FUNCION` = `p`.`ID_FUNCION` and `p`.`AGENTE` = 'SI')) WHERE `f`.`ID_FUNCION` in (1,2,3,4,5,6,7,8,9,10) GROUP BY `f`.`ID_FUNCION`, `f`.`FUNCION` ORDER BY `f`.`ID_FUNCION` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_opciones_funciones`
--
DROP TABLE IF EXISTS `v_opciones_funciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_opciones_funciones`  AS SELECT `f`.`ID_FUNCION` AS `id`, concat(`f`.`FUNCION`,' (',coalesce(count(`disp`.`ID_PERSONA`),0),' disponibles)') AS `opcion_texto`, `f`.`FUNCION` AS `FUNCION`, coalesce(count(`p`.`ID_PERSONA`),0) AS `total_personas`, coalesce(count(`disp`.`ID_PERSONA`),0) AS `personas_disponibles`, coalesce(count(`no_disp`.`ID_PERSONA`),0) AS `personas_no_disponibles` FROM (((`funciones` `f` left join `personas` `p` on(`f`.`ID_FUNCION` = `p`.`ID_FUNCION` and `p`.`AGENTE` = 'A')) left join `v_personas_disponibles` `disp` on(`p`.`ID_PERSONA` = `disp`.`ID_PERSONA`)) left join `v_personas_no_disponibles` `no_disp` on(`p`.`ID_PERSONA` = `no_disp`.`ID_PERSONA`)) WHERE `f`.`ESTADO_FUNCION` = 'A' GROUP BY `f`.`ID_FUNCION`, `f`.`FUNCION` ORDER BY `f`.`ID_FUNCION` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_opciones_personas`
--
DROP TABLE IF EXISTS `v_opciones_personas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_opciones_personas`  AS SELECT `p`.`ID_PERSONA` AS `id`, concat(`p`.`CODIGO_AGENTE`,' - ',`p`.`APELLIDOS`,' ',`p`.`NOMBRES`) AS `opcion_texto`, `p`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, `p`.`NOMBRES` AS `NOMBRES`, `p`.`APELLIDOS` AS `APELLIDOS`, `f`.`FUNCION` AS `FUNCION`, `f`.`ID_FUNCION` AS `ID_FUNCION`, `g`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, `d`.`DISTRITO` AS `DISTRITO`, CASE WHEN `disp`.`ID_PERSONA` is not null THEN 1 ELSE 0 END AS `disponible`, CASE WHEN `no_disp`.`ID_PERSONA` is not null THEN `no_disp`.`TIPO_INDISPONIBILIDAD` ELSE NULL END AS `motivo_indisponibilidad` FROM (((((`personas` `p` join `funciones` `f` on(`p`.`ID_FUNCION` = `f`.`ID_FUNCION`)) join `grupo_operativo` `g` on(`p`.`ID_GRUPO_OPERATIVO` = `g`.`ID_GRUPO_OPERATIVO`)) join `distritos_agentes` `d` on(`p`.`ID_DISTRITO_AGENTE` = `d`.`ID_DISTRITO_AGENTE`)) left join `v_personas_disponibles` `disp` on(`p`.`ID_PERSONA` = `disp`.`ID_PERSONA`)) left join `v_personas_no_disponibles` `no_disp` on(`p`.`ID_PERSONA` = `no_disp`.`ID_PERSONA`)) WHERE `p`.`AGENTE` = 'A' AND `f`.`ESTADO_FUNCION` = 'A' AND `g`.`ACTIVO` = 'A' ORDER BY CASE WHEN `disp`.`ID_PERSONA` is not null THEN 1 ELSE 0 END DESC, `p`.`APELLIDOS` ASC, `p`.`NOMBRES` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_personas_disponibles`
--
DROP TABLE IF EXISTS `v_personas_disponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_personas_disponibles`  AS SELECT `p`.`ID_PERSONA` AS `ID_PERSONA`, `p`.`ID_FUNCION` AS `ID_FUNCION`, `p`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, concat(trim(`p`.`NOMBRES`),' ',trim(`p`.`APELLIDOS`)) AS `NOMBRE_COMPLETO`, `f`.`FUNCION` AS `FUNCION`, `p`.`AGENTE` AS `AGENTE` FROM (`personas` `p` left join `funciones` `f` on(`p`.`ID_FUNCION` = `f`.`ID_FUNCION`)) ORDER BY `p`.`NOMBRES` ASC, `p`.`APELLIDOS` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_personas_no_disponibles`
--
DROP TABLE IF EXISTS `v_personas_no_disponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_personas_no_disponibles`  AS SELECT `p`.`ID_PERSONA` AS `ID_PERSONA`, `p`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, concat(`p`.`NOMBRES`,' ',`p`.`APELLIDOS`) AS `NOMBRE_COMPLETO`, `p`.`NOMBRES` AS `NOMBRES`, `p`.`APELLIDOS` AS `APELLIDOS`, `p`.`CEDULA` AS `CEDULA`, `p`.`TELEFONO_AGENTE` AS `TELEFONO_AGENTE`, `p`.`EMAIL` AS `EMAIL`, `f`.`FUNCION` AS `FUNCION`, `f`.`ID_FUNCION` AS `ID_FUNCION`, `g`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, `g`.`ID_GRUPO_OPERATIVO` AS `ID_GRUPO_OPERATIVO`, `d`.`DISTRITO` AS `DISTRITO`, `d`.`CANTON` AS `CANTON`, `d`.`ID_DISTRITO_AGENTE` AS `ID_DISTRITO_AGENTE`, 'NO_DISPONIBLE' AS `ESTADO_DISPONIBILIDAD`, `ti`.`TIPO_INDISPONIBILIDAD` AS `TIPO_INDISPONIBILIDAD`, `ti`.`ID_TIPO_INDISPONIBILIDAD` AS `ID_TIPO_INDISPONIBILIDAD`, `i`.`FECHA_DESDE` AS `FECHA_DESDE`, `i`.`FECHA_HASTA` AS `FECHA_HASTA`, to_days(`i`.`FECHA_HASTA`) - to_days(`i`.`FECHA_DESDE`) + 1 AS `DIAS_INDISPONIBLE` FROM (((((`personas` `p` join `funciones` `f` on(`p`.`ID_FUNCION` = `f`.`ID_FUNCION`)) join `grupo_operativo` `g` on(`p`.`ID_GRUPO_OPERATIVO` = `g`.`ID_GRUPO_OPERATIVO`)) join `distritos_agentes` `d` on(`p`.`ID_DISTRITO_AGENTE` = `d`.`ID_DISTRITO_AGENTE`)) join `indisponibilidad` `i` on(`p`.`ID_PERSONA` = `i`.`ID_USUARIO`)) join `tipo_indisponibilidad` `ti` on(`i`.`ID_TIPO_INDISPONIBILIDAD` = `ti`.`ID_TIPO_INDISPONIBILIDAD`)) WHERE `p`.`AGENTE` = 'A' AND `f`.`ESTADO_FUNCION` = 'A' AND `g`.`ACTIVO` = 'A' AND `ti`.`ESTADO` = 'A' AND `i`.`FECHA_DESDE` <= current_timestamp() AND `i`.`FECHA_HASTA` >= current_timestamp() ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_personas_por_distrito`
--
DROP TABLE IF EXISTS `v_personas_por_distrito`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_personas_por_distrito`  AS SELECT `d`.`ID_DISTRITO_AGENTE` AS `ID_DISTRITO_AGENTE`, `d`.`DISTRITO` AS `DISTRITO`, `d`.`CANTON` AS `CANTON`, `p`.`ID_PERSONA` AS `ID_PERSONA`, `p`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, concat(`p`.`NOMBRES`,' ',`p`.`APELLIDOS`) AS `NOMBRE_COMPLETO`, `f`.`FUNCION` AS `FUNCION`, `f`.`ID_FUNCION` AS `ID_FUNCION`, `g`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, CASE WHEN `disp`.`ID_PERSONA` is not null THEN 'DISPONIBLE' WHEN `no_disp`.`ID_PERSONA` is not null THEN 'NO_DISPONIBLE' ELSE 'INACTIVO' END AS `ESTADO_DISPONIBILIDAD`, `no_disp`.`TIPO_INDISPONIBILIDAD` AS `TIPO_INDISPONIBILIDAD`, `no_disp`.`FECHA_HASTA` AS `DISPONIBLE_DESDE` FROM (((((`distritos_agentes` `d` left join `personas` `p` on(`d`.`ID_DISTRITO_AGENTE` = `p`.`ID_DISTRITO_AGENTE` and `p`.`AGENTE` = 'A')) left join `funciones` `f` on(`p`.`ID_FUNCION` = `f`.`ID_FUNCION`)) left join `grupo_operativo` `g` on(`p`.`ID_GRUPO_OPERATIVO` = `g`.`ID_GRUPO_OPERATIVO`)) left join `v_personas_disponibles` `disp` on(`p`.`ID_PERSONA` = `disp`.`ID_PERSONA`)) left join `v_personas_no_disponibles` `no_disp` on(`p`.`ID_PERSONA` = `no_disp`.`ID_PERSONA`)) ORDER BY `d`.`DISTRITO` ASC, `d`.`CANTON` ASC, `p`.`APELLIDOS` ASC, `p`.`NOMBRES` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_proximas_disponibilidades`
--
DROP TABLE IF EXISTS `v_proximas_disponibilidades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_proximas_disponibilidades`  AS SELECT `p`.`ID_PERSONA` AS `ID_PERSONA`, `p`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, concat(`p`.`NOMBRES`,' ',`p`.`APELLIDOS`) AS `NOMBRE_COMPLETO`, `f`.`FUNCION` AS `FUNCION`, `g`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, `d`.`DISTRITO` AS `DISTRITO`, `ti`.`TIPO_INDISPONIBILIDAD` AS `TIPO_INDISPONIBILIDAD`, `i`.`FECHA_HASTA` AS `DISPONIBLE_DESDE`, to_days(`i`.`FECHA_HASTA`) - to_days(current_timestamp()) AS `DIAS_PARA_DISPONIBILIDAD` FROM (((((`personas` `p` join `funciones` `f` on(`p`.`ID_FUNCION` = `f`.`ID_FUNCION`)) join `grupo_operativo` `g` on(`p`.`ID_GRUPO_OPERATIVO` = `g`.`ID_GRUPO_OPERATIVO`)) join `distritos_agentes` `d` on(`p`.`ID_DISTRITO_AGENTE` = `d`.`ID_DISTRITO_AGENTE`)) join `indisponibilidad` `i` on(`p`.`ID_PERSONA` = `i`.`ID_USUARIO`)) join `tipo_indisponibilidad` `ti` on(`i`.`ID_TIPO_INDISPONIBILIDAD` = `ti`.`ID_TIPO_INDISPONIBILIDAD`)) WHERE `p`.`AGENTE` = 'A' AND `f`.`ESTADO_FUNCION` = 'A' AND `g`.`ACTIVO` = 'A' AND `ti`.`ESTADO` = 'A' AND `i`.`FECHA_DESDE` <= current_timestamp() AND `i`.`FECHA_HASTA` >= current_timestamp() AND `i`.`FECHA_HASTA` <= current_timestamp() + interval 7 day ORDER BY `i`.`FECHA_HASTA` ASC, `p`.`APELLIDOS` ASC, `p`.`NOMBRES` ASC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `distritos_agentes`
--
ALTER TABLE `distritos_agentes`
  ADD PRIMARY KEY (`ID_DISTRITO_AGENTE`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`ID_FUNCION`);

--
-- Indices de la tabla `grupo_operativo`
--
ALTER TABLE `grupo_operativo`
  ADD PRIMARY KEY (`ID_GRUPO_OPERATIVO`);

--
-- Indices de la tabla `indisponibilidad`
--
ALTER TABLE `indisponibilidad`
  ADD PRIMARY KEY (`ID_INDISPONIBILIDAD`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`ID_PERSONA`);

--
-- Indices de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  ADD PRIMARY KEY (`ID_SISTEMA`);

--
-- Indices de la tabla `tipo_grupo`
--
ALTER TABLE `tipo_grupo`
  ADD PRIMARY KEY (`ID_TIPO_GRUPO`);

--
-- Indices de la tabla `tipo_indisponibilidad`
--
ALTER TABLE `tipo_indisponibilidad`
  ADD PRIMARY KEY (`ID_TIPO_INDISPONIBILIDAD`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID_USUARIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `distritos_agentes`
--
ALTER TABLE `distritos_agentes`
  MODIFY `ID_DISTRITO_AGENTE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `funciones`
--
ALTER TABLE `funciones`
  MODIFY `ID_FUNCION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `grupo_operativo`
--
ALTER TABLE `grupo_operativo`
  MODIFY `ID_GRUPO_OPERATIVO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `indisponibilidad`
--
ALTER TABLE `indisponibilidad`
  MODIFY `ID_INDISPONIBILIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `ID_PERSONA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  MODIFY `ID_SISTEMA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipo_grupo`
--
ALTER TABLE `tipo_grupo`
  MODIFY `ID_TIPO_GRUPO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_indisponibilidad`
--
ALTER TABLE `tipo_indisponibilidad`
  MODIFY `ID_TIPO_INDISPONIBILIDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
