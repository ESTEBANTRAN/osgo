-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2025 a las 21:20:54
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
-- Base de datos: `osgo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_16_092726_create_osgo_roles_table', 2),
(5, '2025_09_16_094137_update_osgo_users_columns_to_uppercase', 3),
(6, '2025_05_06_084712_change_fecha_actual_nullable_on_orden_servicio_table', 4),
(7, '2025_05_22_142034_add_id_sector_to_detalle_orden_servicio_table', 4),
(8, '2025_05_29_095052_add_id_funcion_to_detalle_orden_servicio_table', 4),
(9, '2025_05_29_122618_add_id_funcion_to_detalle_orden_servicio_table', 4),
(10, '2025_06_11_091837_drop_id_tipo_grupo_from_grupo_operativo', 4),
(11, '2025_06_17_101033_create_servicio_grua_table', 4),
(12, '2025_06_17_101035_create_orden_servicio_grua_table', 4),
(13, '2025_06_30_151914_add_fk_grupo_operativo_to_funciones', 4),
(14, '2025_09_11_100000_create_osgo_anexo_table', 4),
(15, '2025_09_11_100100_create_osgo_anexo_detalle_table', 4),
(16, '2025_09_11_100200_create_osgo_anexo_recurso_table', 4),
(17, '2025_09_11_100300_create_osgo_control_horas_table', 4),
(18, '2025_09_11_100400_create_osgo_historial_horas_table', 4),
(19, '2025_09_11_100600_create_osgo_horarios_table', 4),
(20, '2025_09_11_150000_rename_users_to_osgo_users', 4),
(21, '2025_09_11_151000_add_fks_to_osgo_anexo_children', 4),
(22, '2025_09_11_152000_normalize_osgo_database', 4),
(23, '2025_09_11_153000_make_vehicles_resources_orphan', 4),
(24, '2025_09_11_154000_fix_sessions_table_structure', 4),
(25, '2025_09_11_156000_recreate_anexo_recurso_table', 4),
(26, '2025_09_11_158000_clean_duplicate_columns', 4),
(27, '2025_09_11_159000_add_missing_horarios_fields', 4),
(28, '2025_09_11_161000_fix_database_improvements', 4),
(29, '2025_09_12_135952_create_osgo_recursos_table', 4),
(30, '2025_09_12_135956_modify_osgo_anexo_recurso_table', 4),
(31, '2025_09_16_092722_rename_users_table_to_osgo_users_table', 4),
(32, '2025_09_16_093323_drop_users_table', 4),
(33, '2025_09_16_093926_ensure_osgo_roles_table_exists', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_anexo`
--

CREATE TABLE `osgo_anexo` (
  `ID_ANEXO` int(10) UNSIGNED NOT NULL,
  `ID_ORDEN_SERVICIO` int(11) NOT NULL,
  `TIPO_ANEXO` varchar(20) NOT NULL,
  `NOMBRE` varchar(300) NOT NULL,
  `ORGANIZADOR` varchar(200) NOT NULL,
  `TELEFONO_ORGANIZADOR` varchar(20) DEFAULT NULL,
  `FECHA` date NOT NULL,
  `HORA_FORMACION` time DEFAULT NULL,
  `HORA_INICIO` time NOT NULL,
  `HORA_FIN` time NOT NULL,
  `LUGAR` varchar(255) NOT NULL,
  `MANDO` varchar(200) DEFAULT NULL,
  `JEFE_CONTROL` varchar(200) DEFAULT NULL,
  `MISION` text DEFAULT NULL,
  `GESTION_REQUERIDA` text DEFAULT NULL,
  `RECORRIDO` text DEFAULT NULL,
  `ANTECEDENTES` text DEFAULT NULL,
  `INSTRUCCIONES_COORDINACION` text DEFAULT NULL,
  `RUTAGRAMA_IMAGEN` varchar(500) DEFAULT NULL,
  `NOTAS_RUTAGRAMA` text DEFAULT NULL,
  `ESTADO` enum('PLANIFICADO','EN_CURSO','COMPLETADO','CANCELADO') NOT NULL DEFAULT 'PLANIFICADO',
  `CREADO_POR` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_anexo_detalle`
--

CREATE TABLE `osgo_anexo_detalle` (
  `ID_ANEXO_DETALLE` int(10) UNSIGNED NOT NULL,
  `ID_ANEXO` int(10) UNSIGNED NOT NULL,
  `ORDEN` int(11) NOT NULL,
  `RESPONSABLE` varchar(200) NOT NULL,
  `FUNCION` varchar(100) NOT NULL,
  `PUESTO_SERVICIO` varchar(300) DEFAULT NULL,
  `OBSERVACION` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_anexo_recurso`
--

CREATE TABLE `osgo_anexo_recurso` (
  `ID_ANEXO_RECURSO` int(11) NOT NULL,
  `ID_ANEXO` int(11) NOT NULL,
  `ID_RECURSO` bigint(20) UNSIGNED DEFAULT NULL,
  `TIPO_RECURSO` varchar(50) NOT NULL,
  `CANTIDAD` int(11) NOT NULL DEFAULT 1,
  `OBSERVACIONES` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_circuitos`
--

CREATE TABLE `osgo_circuitos` (
  `ID_CIRCUITO` int(11) NOT NULL,
  `NOMBRE_CIRCUITO` varchar(100) NOT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `ACTIVO` enum('SI','NO') DEFAULT 'SI'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_circuitos`
--

INSERT INTO `osgo_circuitos` (`ID_CIRCUITO`, `NOMBRE_CIRCUITO`, `DESCRIPCION`, `ACTIVO`) VALUES
(1, 'CIRCUITO UNO', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, LA MERCED, LA GALLERA, MERCADO MAYORISTA, HUERTOS FAMILIARES, ALPACHACA, JARDIN DE PAZ, EL MILAGRO, PARQUE DE LA MILIER, REDONDLE DE AJAVI, MOVIDELNOR, EMELNORTE, AV. JAIME RIVADENEIRA', 'SI'),
(2, 'CIRCUITO DOS', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, GAD IBARRA, PARQUE PEDRO MONCAYO, CALLE BOLIVAR, SUCRE, OLMEDO, UE SAN FRANCISCO, UTN, PUCESI, SECTOR LA CAT├ôLICA, SECTOR EL OLIVO, SECTOR DE PRIORATO, SECTOR DE YAHLUARCOCHA, BARRIO OLIVO ALTO, ARCANGEL', 'SI'),
(3, 'CIRCUITO TRES', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, CALLES, OLMEDO, COL├ôN, AV. PEREZ GUERREZ, BOLIVAR, AV. TEODORO GOMEZ DE LA TORRES, AV. EL RETORNO, AV. ATAHUALPA, SUCRE, SECTOR DE LA ESPERANZA, SECTOR LOMA DE GUAYABILLAS, SECTOR ROMERILLO BAJO Y ALTO, SECTOR DE CARANQUIL', 'SI'),
(4, 'CIRCUITO CUATRO', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, CALLES CHICA NARVAEZ, AV. MARIANO ACOSTA, AV. BUGENIO ESPEJO, AV. TEODORO GOMEZ, AV. CAMILO PONCE, PERIFERICO SUR, SECTOR DE CHORLAVI, SECTOR DE LA FLORIDA, CENTRO DE MATRICULACI├ôN, SECTOR LOS GALEANOS, SECTOR EJIDO DE CARAQUI, SECTOR DE TANGUARIN, SECTOR DE SAN ANTONIO', 'SI'),
(5, 'CIRCUITO UNO', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, LA MERCED, LA GALLERA, MERCADO MAYORISTA, HUERTOS FAMILIARES, ALPACHACA, JARDIN DE PAZ, EL MILAGRO, PARQUE DE LA MILIER, REDONDLE DE AJAVI, MOVIDELNOR, EMELNORTE, AV. JAIME RIVADENEIRA', 'SI'),
(6, 'CIRCUITO DOS', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, GAD IBARRA, PARQUE PEDRO MONCAYO, CALLE BOLIVAR, SUCRE, OLMEDO, UE SAN FRANCISCO, UTN, PUCESI, SECTOR LA CATÓLICA, SECTOR EL OLIVO, SECTOR DE PRIORATO, SECTOR DE YAHLUARCOCHA, BARRIO OLIVO ALTO, ARCANGEL', 'SI'),
(7, 'CIRCUITO TRES', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, CALLES, OLMEDO, COLÓN, AV. PEREZ GUERREZ, BOLIVAR, AV. TEODORO GOMEZ DE LA TORRES, AV. EL RETORNO, AV. ATAHUALPA, SUCRE, SECTOR DE LA ESPERANZA, SECTOR LOMA DE GUAYABILLAS, SECTOR ROMERILLO BAJO Y ALTO, SECTOR DE CARANQUIL', 'SI'),
(8, 'CIRCUITO CUATRO', 'DESDE LA SANCHEZ Y CIFUENTES Y VELASCO, CALLES CHICA NARVAEZ, AV. MARIANO ACOSTA, AV. BUGENIO ESPEJO, AV. TEODORO GOMEZ, AV. CAMILO PONCE, PERIFERICO SUR, SECTOR DE CHORLAVI, SECTOR DE LA FLORIDA, CENTRO DE MATRICULACIÓN, SECTOR LOS GALEANOS, SECTOR EJIDO DE CARAQUI, SECTOR DE TANGUARIN, SECTOR DE SAN ANTONIO', 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_control_horas`
--

CREATE TABLE `osgo_control_horas` (
  `ID_CONTROL_HORAS` int(11) NOT NULL,
  `ID_PERSONA` int(11) NOT NULL,
  `FECHA` date NOT NULL,
  `HORAS_TRABAJADAS` decimal(5,2) NOT NULL DEFAULT 0.00,
  `ESTADO` varchar(30) NOT NULL DEFAULT 'DISPONIBLE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_control_horas_mensuales`
--

CREATE TABLE `osgo_control_horas_mensuales` (
  `ID_CONTROL_MENSUAL` int(11) NOT NULL,
  `CODIGO_AGENTE` varchar(25) DEFAULT NULL,
  `NOMBRES` varchar(100) DEFAULT NULL,
  `APELLIDOS` varchar(100) DEFAULT NULL,
  `ANIO` int(11) DEFAULT NULL,
  `MES` int(11) DEFAULT NULL,
  `HORAS_TRABAJADAS` int(11) DEFAULT 0,
  `HORAS_EXTRAS` int(11) DEFAULT 0,
  `HORAS_FALTANTES` int(11) GENERATED ALWAYS AS (greatest(160 - `HORAS_TRABAJADAS`,0)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_detalle_orden_servicio`
--

CREATE TABLE `osgo_detalle_orden_servicio` (
  `ID_DET_ORDEN_SERVICIO` int(11) NOT NULL,
  `ID_ORDEN_SERVICIO` int(11) DEFAULT NULL,
  `ID_FUNCION` int(11) DEFAULT NULL,
  `GRUPO_FUNCIONAL` varchar(50) DEFAULT NULL,
  `FUNCION` varchar(100) DEFAULT NULL,
  `CODIGO_RESPONSABLE` varchar(20) DEFAULT NULL,
  `RESPONSABLE` varchar(50) DEFAULT NULL,
  `SECTOR` varchar(255) DEFAULT NULL,
  `NOVEDADES` varchar(2500) DEFAULT NULL,
  `OBSERVACION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_disposiciones_generales`
--

CREATE TABLE `osgo_disposiciones_generales` (
  `ID_DISPOSICION` int(11) NOT NULL,
  `NUMERO_DISPOSICION` int(11) NOT NULL,
  `TITULO` varchar(200) NOT NULL,
  `CONTENIDO` text NOT NULL,
  `CATEGORIA` enum('ACCIDENTES','OPERATIVOS','NORMATIVAS','ORDENES','MOTOCICLETAS','REPORTES','GENERAL') NOT NULL,
  `ES_OBLIGATORIA` tinyint(1) DEFAULT 1,
  `ACTIVO` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `osgo_disposiciones_generales`
--

INSERT INTO `osgo_disposiciones_generales` (`ID_DISPOSICION`, `NUMERO_DISPOSICION`, `TITULO`, `CONTENIDO`, `CATEGORIA`, `ES_OBLIGATORIA`, `ACTIVO`, `created_at`, `updated_at`) VALUES
(1, 1, 'Procedimiento en caso de accidentes de tránsito', 'Para en caso de accidentes de tránsito, a los que acuden el cuerpo de agentes civiles de tránsito se dispone el env¡o inmediato y obligatorio del extracto una vez finalizado el procedimiento as¡ mismo la entrega del parte en f¡sico dentro de las 24 horas a la coordinadora de operaciones.', 'ACCIDENTES', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(2, 2, 'Facultades para ejecución de operativos de control', 'Sin perjuicio de la ejecución de operativos de control de tránsito, en sus distintas modalidades, cualquier miembro del cuerpo de agentes civiles de tránsito se encuentra facultado de acuerdo con las disposiciones normativas establecidas en la Constituci├│n y la Ley para ejecutar procedimientos de control de tránsito de acuerdo con cualquiera de los tipos contravencionales establecidos en el COIP.', 'OPERATIVOS', 1, 1, '2025-09-17 17:31:49', '2025-09-17 17:51:23'),
(3, 3, 'Obediencia a órdenes superiores', 'De conformidad con las disposiciones y normativas establecidas en el COESCOP (ART.289#11) es obligaci├│n de los miembros del cuerpo de agentes civiles de tránsito obedecer las órdenes leg¡timas, verbales o escritas emitidas por su jefe inmediato superior.', 'NORMATIVAS', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(4, 4, 'Flexibilidad de órdenes de servicio', 'Las órdenes de servicio estÁn sujetas a cambios en horarios, intersecciones y otras disposiciones segÚn la necesidad y operatividad, raz├│n por la cual se deberÁ revisar la orden de servicio d¡a anterior a la fecha de trabajo del servidor ACT.', 'ORDENES', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(5, 5, 'Operativos de control de motocicletas', 'En atención con el memorando NRO. EPM-DDCT-2022-0859-M se dispone ejecutar operativos de control de motocicletas, en funci├│n a lo establecido en la normativa del art¡culo 160 del reglamento a la LOTTTSV; as¡ mismo se efectÚe operativos de control aquellas motocicletas con modificaciones que no cumplan las condiciones de homologaci├│n pertinente.', 'MOTOCICLETAS', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(6, 6, 'Reporte obligatorio al ECU 911', 'Los miembros del cuerpo de agentes civiles de tránsito deberÁ reportar al ECU.911 todo procedimiento que vayan a tomar con veh¡culos que cometa contravenci├│n en los diferentes sectores de la ciudad de Ibarra.', 'REPORTES', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(7, 7, 'Capacidad permitida en motocicletas', 'De acuerdo a la resolución NRO. 010-DIR-ANT-2022 reglamento que norma la capacidad permitida de personas que se transportan en motocicletas dentro del territorio nacional, el presente tipo contravencional forma parte del glosario de contravenciones de quinta clase, y sanciona a los conductores de motocicletas que transporten un nÚmero de personas superior a la capacidad permitida (se ha limitado su capacidad a una persona).', 'MOTOCICLETAS', 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_disposiciones_orden`
--

CREATE TABLE `osgo_disposiciones_orden` (
  `ID_DISPOSICION_ORDEN` int(11) NOT NULL,
  `ID_ORDEN_SERVICIO` int(11) NOT NULL,
  `ID_DISPOSICION` int(11) NOT NULL,
  `INCLUIDA` tinyint(1) DEFAULT 1,
  `OBSERVACIONES` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_estado_orden`
--

CREATE TABLE `osgo_estado_orden` (
  `ID_ESTADO_ORDEN` int(11) NOT NULL,
  `ESTADO_ORDEN` varchar(50) DEFAULT NULL,
  `DESCRIPCION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `osgo_estado_orden`
--

INSERT INTO `osgo_estado_orden` (`ID_ESTADO_ORDEN`, `ESTADO_ORDEN`, `DESCRIPCION`) VALUES
(1, 'Pendiente', 'Orden recién creada, pendiente de aprobación o asignación'),
(2, 'Aprobada', 'Orden aprobada y lista para asignar recursos'),
(3, 'En Curso', 'Orden en proceso de ejecución'),
(4, 'Finalizada', 'Orden concluida exitosamente'),
(5, 'Cancelada', 'Orden cancelada y no se realizará'),
(6, 'Pendiente', 'Orden pendiente de atención'),
(7, 'Pendiente', 'Orden pendiente de atención'),
(8, 'Pendiente', 'Orden pendiente de atención');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_grupos_operativos`
--

CREATE TABLE `osgo_grupos_operativos` (
  `ID_GRUPO` int(11) NOT NULL,
  `CODIGO_GRUPO` varchar(20) NOT NULL,
  `NOMBRE_GRUPO` varchar(100) NOT NULL,
  `TIPO_GRUPO` enum('MOTORIZADO','PEDESTRE','MOTOS') DEFAULT 'MOTORIZADO',
  `ACTIVO` enum('SI','NO') DEFAULT 'SI'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_grupos_operativos`
--

INSERT INTO `osgo_grupos_operativos` (`ID_GRUPO`, `CODIGO_GRUPO`, `NOMBRE_GRUPO`, `TIPO_GRUPO`, `ACTIVO`) VALUES
(1, 'GRUPO_A', 'GRUPO A', 'MOTORIZADO', 'SI'),
(2, 'GRUPO_B', 'GRUPO B', 'MOTORIZADO', 'SI'),
(3, 'GRUPO_C', 'GRUPO C', 'MOTORIZADO', 'SI'),
(4, 'GRUPO_D', 'GRUPO D', 'MOTORIZADO', 'SI'),
(5, 'GRUPO_E', 'GRUPO E', 'MOTORIZADO', 'SI'),
(6, 'GRUPO_A_M', 'GRUPO A MOTORIZADO', 'MOTORIZADO', 'SI'),
(7, 'GRUPO_B_M', 'GRUPO B MOTORIZADO', 'MOTORIZADO', 'SI'),
(8, 'GRUPO_C_M', 'GRUPO C MOTORIZADO', 'MOTORIZADO', 'SI'),
(9, 'GRUPO_A_MOTOS', 'GRUPO A MOTOS', 'MOTOS', 'SI'),
(10, 'GRUPO_B_MOTOS', 'GRUPO B MOTOS', 'MOTOS', 'SI'),
(11, 'GRUPO_C_MOTOS', 'GRUPO C MOTOS', 'MOTOS', 'SI'),
(12, 'GA_PEDESTRE', 'GRUPO A PEDESTRE', 'PEDESTRE', 'SI'),
(13, 'GB_PEDESTRE', 'GRUPO B PEDESTRE', 'PEDESTRE', 'SI'),
(14, 'GC_PEDESTRE', 'GRUPO C PEDESTRE', 'PEDESTRE', 'SI'),
(15, 'GRUPO_A', 'GRUPO A', 'MOTORIZADO', 'SI'),
(16, 'GRUPO_B', 'GRUPO B', 'MOTORIZADO', 'SI'),
(17, 'GRUPO_C', 'GRUPO C', 'MOTORIZADO', 'SI'),
(18, 'GRUPO_D', 'GRUPO D', 'MOTORIZADO', 'SI'),
(19, 'GRUPO_E', 'GRUPO E', 'MOTORIZADO', 'SI'),
(20, 'GRUPO_A_M', 'GRUPO A MOTORIZADO', 'MOTORIZADO', 'SI'),
(21, 'GRUPO_B_M', 'GRUPO B MOTORIZADO', 'MOTORIZADO', 'SI'),
(22, 'GRUPO_C_M', 'GRUPO C MOTORIZADO', 'MOTORIZADO', 'SI'),
(23, 'GRUPO_A_MOTOS', 'GRUPO A MOTOS', 'MOTOS', 'SI'),
(24, 'GRUPO_B_MOTOS', 'GRUPO B MOTOS', 'MOTOS', 'SI'),
(25, 'GRUPO_C_MOTOS', 'GRUPO C MOTOS', 'MOTOS', 'SI'),
(26, 'GA_PEDESTRE', 'GRUPO A PEDESTRE', 'PEDESTRE', 'SI'),
(27, 'GB_PEDESTRE', 'GRUPO B PEDESTRE', 'PEDESTRE', 'SI'),
(28, 'GC_PEDESTRE', 'GRUPO C PEDESTRE', 'PEDESTRE', 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_historial_horas`
--

CREATE TABLE `osgo_historial_horas` (
  `ID_HISTORIAL` int(11) NOT NULL,
  `ID_CONTROL_HORAS` int(11) NOT NULL,
  `ID_ORDEN_SERVICIO` int(11) DEFAULT NULL,
  `HORAS_ANTERIORES` decimal(5,2) NOT NULL,
  `HORAS_NUEVAS` decimal(5,2) NOT NULL,
  `MOTIVO` varchar(255) DEFAULT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_horarios`
--

CREATE TABLE `osgo_horarios` (
  `ID_HORARIO` int(11) NOT NULL,
  `NOMBRE` varchar(100) NOT NULL,
  `HORA_INICIO` tinyint(3) UNSIGNED NOT NULL,
  `HORA_FIN` tinyint(3) UNSIGNED NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `duracion_horas` int(11) NOT NULL,
  `ACTIVO` varchar(2) NOT NULL DEFAULT 'SI'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_horarios`
--

INSERT INTO `osgo_horarios` (`ID_HORARIO`, `NOMBRE`, `HORA_INICIO`, `HORA_FIN`, `descripcion`, `duracion_horas`, `ACTIVO`) VALUES
(1, '06:00-14:00', 6, 14, '', 0, 'SI'),
(2, '06:00-12:00', 6, 12, '', 0, 'SI'),
(3, '14:00-22:00', 14, 22, '', 0, 'SI'),
(4, '08:00-12:00', 8, 12, '', 0, 'SI'),
(5, '22:00-06:00', 22, 6, '', 0, 'SI'),
(6, '12:00-20:00', 12, 20, '', 0, 'SI'),
(7, '13:00-21:00', 13, 21, '', 0, 'SI'),
(8, '14:00-20:00', 14, 20, '', 0, 'SI'),
(9, '22:00-04:00', 22, 4, '', 0, 'SI'),
(10, 'FRANCO', 0, 0, 'Día de franco', 0, 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_novedades`
--

CREATE TABLE `osgo_novedades` (
  `ID_NOVEDAD` int(11) NOT NULL,
  `TIPO_NOVEDAD` varchar(50) NOT NULL,
  `DESCRIPCION` text NOT NULL,
  `ACTIVO` enum('SI','NO') DEFAULT 'SI'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_novedades`
--

INSERT INTO `osgo_novedades` (`ID_NOVEDAD`, `TIPO_NOVEDAD`, `DESCRIPCION`, `ACTIVO`) VALUES
(1, 'CONTROL_TRANSPORTE', 'CONTROL DE TRANSPORTE INTER E INTRAPROVINCIAL EXECESO DE PASAJEROS, DOCUMENTOS HABILITANTES', 'SI'),
(2, 'RETIRO_VEHICULOS', 'RETIRO DE VEHÍCULOS ESTACIONADOS EN SITIOS PROHIBIDOS', 'SI'),
(3, 'CONTROL_INFORMALIDAD', 'CONTROL DE INFORMALIDAD EN EL SECTOR', 'SI'),
(4, 'VERIFICAR_NOVEDADES', 'VERIFICAR Y RESOLVER NOVEDADES', 'SI'),
(5, 'CUSTODIA_FERROCARRIL', 'CUSTODIA DEL FERROCARRIL EN TODO EL RECORRIDO', 'SI'),
(6, 'CONTROL_ART_390_7', 'CONTROL DEL ART. 390.7 AL EXTERIOR DEL TERMINAL', 'SI'),
(7, 'OPERATIVO_CONJUNTO', 'OPERATIVO CONJUNTO CONTROL DE ESPACIO P├ÜBLICO', 'SI'),
(8, 'RETIRO_DOBLE_COLUMNA', 'RETIRO DE VEHÍCULOS DOBLE COLUMNA', 'SI'),
(9, 'CONTROL_MOTOCICLETAS', 'CONTROL DE MOTOCICLETAS CON MODIFICACIONES NO COMPLIANTES', 'SI'),
(10, 'VERIFICACION_PLACAS', 'VERIFICACIÓN DE PLACAS METÁLICAS Y PROVISIONALES', 'SI'),
(11, 'CONTROL_TRANSPORTE', 'CONTROL DE TRANSPORTE INTER E INTRAPROVINCIAL EXECESO DE PASAJEROS, DOCUMENTOS HABILITANTES', 'SI'),
(12, 'RETIRO_VEHICULOS', 'RETIRO DE VEHÍCULOS ESTACIONADOS EN SITIOS PROHIBIDOS', 'SI'),
(13, 'CONTROL_INFORMALIDAD', 'CONTROL DE INFORMALIDAD EN EL SECTOR', 'SI'),
(14, 'VERIFICAR_NOVEDADES', 'VERIFICAR Y RESOLVER NOVEDADES', 'SI'),
(15, 'CUSTODIA_FERROCARRIL', 'CUSTODIA DEL FERROCARRIL EN TODO EL RECORRIDO', 'SI'),
(16, 'CONTROL_ART_390_7', 'CONTROL DEL ART. 390.7 AL EXTERIOR DEL TERMINAL', 'SI'),
(17, 'OPERATIVO_CONJUNTO', 'OPERATIVO CONJUNTO CONTROL DE ESPACIO PÚBLICO', 'SI'),
(18, 'RETIRO_DOBLE_COLUMNA', 'RETIRO DE VEHÍCULOS DOBLE COLUMNA', 'SI'),
(19, 'CONTROL_MOTOCICLETAS', 'CONTROL DE MOTOCICLETAS CON MODIFICACIONES NO COMPLIANTES', 'SI'),
(20, 'VERIFICACION_PLACAS', 'VERIFICACIÓN DE PLACAS METÁLICAS Y PROVISIONALES', 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_orden_servicio`
--

CREATE TABLE `osgo_orden_servicio` (
  `ID_ORDEN_SERVICIO` int(11) NOT NULL,
  `NRO_ORDEN` varchar(100) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `DISTRITO` varchar(50) DEFAULT NULL,
  `PROVINCIA` varchar(50) DEFAULT NULL,
  `CIUDAD` varchar(50) DEFAULT NULL,
  `CREADO_POR` varchar(255) DEFAULT NULL,
  `ID_ESTADO_ORDEN` int(11) DEFAULT NULL,
  `FECHA_ACTUAL` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `osgo_orden_servicio`
--

INSERT INTO `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`, `NRO_ORDEN`, `FECHA`, `DISTRITO`, `PROVINCIA`, `CIUDAD`, `CREADO_POR`, `ID_ESTADO_ORDEN`, `FECHA_ACTUAL`) VALUES
(2, '99', '2025-09-24', '', NULL, NULL, NULL, 1, '2025-09-17 18:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_orden_servicio_grua`
--

CREATE TABLE `osgo_orden_servicio_grua` (
  `ID_ORDEN_GRUA` int(10) UNSIGNED NOT NULL,
  `ID_ORDEN_SERVICIO` int(10) UNSIGNED DEFAULT NULL,
  `ID_SERVICIO_GRUA` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_recursos`
--

CREATE TABLE `osgo_recursos` (
  `ID_RECURSO` bigint(20) UNSIGNED NOT NULL,
  `NOMBRE_RECURSO` varchar(100) NOT NULL COMMENT 'Nombre del recurso (ej: Conos, Varillas, Señaléticas)',
  `TIPO_RECURSO` varchar(50) NOT NULL COMMENT 'Tipo de recurso (ej: PATRULLERO, MOTOCICLETA, CONO)',
  `DESCRIPCION` text DEFAULT NULL COMMENT 'Descripción detallada del recurso',
  `UNIDAD_MEDIDA` varchar(20) NOT NULL DEFAULT 'UNIDAD' COMMENT 'Unidad de medida (UNIDAD, METROS, LITROS, etc.)',
  `ACTIVO` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Indica si el recurso está activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_recursos`
--

INSERT INTO `osgo_recursos` (`ID_RECURSO`, `NOMBRE_RECURSO`, `TIPO_RECURSO`, `DESCRIPCION`, `UNIDAD_MEDIDA`, `ACTIVO`, `created_at`, `updated_at`) VALUES
(1, 'Patrullero', 'PATRULLERO', 'Vehículo patrullero para servicios de seguridad', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(2, 'Motocicleta', 'MOTOCICLETA', 'Motocicleta para servicios de seguridad', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(3, 'Pasola', 'PASOLA', 'Pasola para servicios de seguridad', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(4, 'Grúa', 'GRUA', 'Grúa para servicios de remolque', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(5, 'Tango', 'TANGO', 'Vehículo tango para servicios especiales', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(6, 'Conos de Seguridad', 'CONO', 'Conos de seguridad para señalización vial', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(7, 'Varillas Reflectivas', 'VARILLA', 'Varillas reflectivas para señalización', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(8, 'Señaléticas', 'SENALETICA', 'Señaléticas de tránsito', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(9, 'Cinta de Seguridad', 'CINTA', 'Cinta de seguridad para delimitar áreas', 'METROS', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(10, 'Barreras de Tránsito', 'BARRERA', 'Barreras de tránsito portátiles', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(11, 'Radio Comunicación', 'RADIO', 'Equipo de radio comunicación', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(12, 'Megáfono', 'MEGAFONO', 'Megáfono para comunicación', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(13, 'Chaleco Reflectivo', 'CHALECO', 'Chaleco reflectivo de seguridad', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(14, 'Linterna', 'LINTERNA', 'Linterna para servicios nocturnos', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(15, 'Extintor', 'EXTINTOR', 'Extintor de incendios', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58'),
(16, 'Recurso de Prueba', 'Humano', 'Recurso de prueba para desarrollo', 'Unidad', 1, '2025-09-15 21:36:36', '2025-09-15 21:36:36'),
(17, 'Recurso de Prueba', 'Humano', 'Recurso de prueba para desarrollo', 'Unidad', 1, '2025-09-16 15:33:44', '2025-09-16 15:33:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_roles`
--

CREATE TABLE `osgo_roles` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `NOMBRE` varchar(50) NOT NULL,
  `DESCRIPCION` varchar(200) DEFAULT NULL,
  `ACTIVO` tinyint(1) NOT NULL DEFAULT 1,
  `CREATED_AT` timestamp NULL DEFAULT NULL,
  `UPDATED_AT` timestamp NULL DEFAULT NULL,
  `DELETED_AT` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_roles`
--

INSERT INTO `osgo_roles` (`ID`, `NOMBRE`, `DESCRIPCION`, `ACTIVO`, `CREATED_AT`, `UPDATED_AT`, `DELETED_AT`) VALUES
(1, 'RESPONSABLE_OPERATIVO', 'Crea órdenes de servicio', 1, '2025-09-16 15:33:44', '2025-09-16 15:33:44', NULL),
(2, 'JEFE_DISTRITO', 'Aprueba órdenes de servicio', 1, '2025-09-16 15:33:44', '2025-09-16 15:33:44', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_sectores`
--

CREATE TABLE `osgo_sectores` (
  `ID_SECTOR` int(11) NOT NULL,
  `NOMBRE_SECTOR` varchar(200) NOT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `CIRCUITO_ID` int(11) DEFAULT NULL,
  `ACTIVO` enum('SI','NO') DEFAULT 'SI'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_sectores`
--

INSERT INTO `osgo_sectores` (`ID_SECTOR`, `NOMBRE_SECTOR`, `DESCRIPCION`, `CIRCUITO_ID`, `ACTIVO`) VALUES
(1, 'MERCADO MAYORISTA', 'CONTROL EN MERCADO MAYORISTA', 1, 'SI'),
(2, 'HOSPITAL SAN VICENTE', 'RETIRO DE VEHÍCULOS EN EXTERIORES DEL HOSPITAL', 1, 'SI'),
(3, 'GAD IBARRA', 'CONTROL EN GAD IBARRA', 2, 'SI'),
(4, 'PARQUE PEDRO MONCAYO', 'CONTROL EN PARQUE PEDRO MONCAYO', 2, 'SI'),
(5, 'TERMINAL DE TRANSPORTE', 'CONTROL EN TERMINAL DE TRANSPORTE', 3, 'SI'),
(6, 'AV. EL RETORNO', 'CONTROL EN AV. EL RETORNO', 3, 'SI'),
(7, 'CENTRO DE MATRICULACIÓN', 'CONTROL EN CENTRO DE MATRICULACIÓN', 4, 'SI'),
(8, 'PERIFERICO SUR', 'CONTROL EN PERIFERICO SUR', 4, 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_servicios_orden`
--

CREATE TABLE `osgo_servicios_orden` (
  `ID_SERVICIO_ORDEN` int(11) NOT NULL,
  `ID_ORDEN_SERVICIO` int(11) NOT NULL,
  `ID_TIPO_SERVICIO` int(11) NOT NULL,
  `HORARIO` varchar(50) DEFAULT NULL,
  `PLACA_VEHICULO` varchar(20) DEFAULT NULL,
  `GRUPO_ASIGNADO` varchar(30) DEFAULT NULL,
  `RESPONSABLE` varchar(100) DEFAULT NULL,
  `CODIGO_RESPONSABLE` varchar(20) DEFAULT NULL,
  `SECTOR_DESCRIPCION` text DEFAULT NULL,
  `NOVEDADES` text DEFAULT NULL,
  `OBSERVACIONES` text DEFAULT NULL,
  `ACTIVO` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_servicio_grua`
--

CREATE TABLE `osgo_servicio_grua` (
  `ID_SERVICIO_GRUA` int(10) UNSIGNED NOT NULL,
  `PROPIETARIO` varchar(100) DEFAULT NULL,
  `CONTRATO` varchar(20) DEFAULT NULL,
  `TELEFONO` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_tipos_servicio`
--

CREATE TABLE `osgo_tipos_servicio` (
  `ID_TIPO_SERVICIO` int(11) NOT NULL,
  `TIPO_SERVICIO` varchar(50) NOT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `CATEGORIA` enum('MOTORIZADO','PEDESTRE','GRUA','ESPECIAL','MERCADO') NOT NULL,
  `REQUIERE_VEHICULO` tinyint(1) DEFAULT 0,
  `REQUIERE_HORARIO` tinyint(1) DEFAULT 1,
  `REQUIERE_SECTOR` tinyint(1) DEFAULT 1,
  `ACTIVO` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `osgo_tipos_servicio`
--

INSERT INTO `osgo_tipos_servicio` (`ID_TIPO_SERVICIO`, `TIPO_SERVICIO`, `DESCRIPCION`, `CATEGORIA`, `REQUIERE_VEHICULO`, `REQUIERE_HORARIO`, `REQUIERE_SECTOR`, `ACTIVO`, `created_at`, `updated_at`) VALUES
(1, 'SERVICIO MOTORIZADO', 'Servicio de patrullaje en motocicleta con circuitos espec¡ficos', 'MOTORIZADO', 1, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(2, 'SERVICIO MOTORIZADO FRANCO', 'Personal motorizado en d¡a franco disponible para emergencias', 'MOTORIZADO', 1, 1, 0, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(3, 'SERVICIO PEDESTRE', 'Servicio de control de tránsito a pie en intersecciones', 'PEDESTRE', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 17:51:23'),
(4, 'SERVICIO PEDESTRE FRANCO', 'Personal pedestre en d¡a franco para apoyo', 'PEDESTRE', 0, 1, 0, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(5, 'SERVICIOS PEDESTRE', 'Servicios mÚltiples de control pedestre', 'PEDESTRE', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(6, 'SERVICIO DE GRÚA PARTICULAR', 'Servicio de grÚa contratada en caso de no disponer grÚas de la empresa', 'GRUA', 1, 1, 0, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(7, 'SERVICIO MERCADO MAYORISTA', 'Servicio especial para control en mercado mayorista', 'MERCADO', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 17:31:49'),
(8, 'SERVICIO DESDE LAS 16:15', 'Servicio especial con horario espec¡fico', 'ESPECIAL', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(9, 'SERVICIO CONTROL INTERPROVINCIALES', 'Control espec¡fico de buses interprovinciales', 'ESPECIAL', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(10, 'SERVICIO CONTROL SEMÁFORO', 'Control espec¡fico en semÁforos', 'ESPECIAL', 0, 1, 1, 1, '2025-09-17 17:31:49', '2025-09-17 19:16:22'),
(12, 'SERVICIOS PEDESTRE FRANCO', 'Servicio pedestre en horario de franco', 'PEDESTRE', 0, 1, 0, 1, '2025-09-17 18:05:52', '2025-09-17 18:05:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_tipo_vehiculo`
--

CREATE TABLE `osgo_tipo_vehiculo` (
  `ID_TIPO_VEHICULO` int(11) NOT NULL,
  `TIPO_VEHICULO` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_users`
--

CREATE TABLE `osgo_users` (
  `ID_USUARIO` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `EMAIL_VERIFIED_AT` timestamp NULL DEFAULT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `ROL_ID` bigint(20) UNSIGNED DEFAULT NULL,
  `REMEMBER_TOKEN` varchar(100) DEFAULT NULL,
  `CREATED_AT` timestamp NULL DEFAULT NULL,
  `UPDATED_AT` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_users`
--

INSERT INTO `osgo_users` (`ID_USUARIO`, `NAME`, `EMAIL`, `EMAIL_VERIFIED_AT`, `PASSWORD`, `ROL_ID`, `REMEMBER_TOKEN`, `CREATED_AT`, `UPDATED_AT`) VALUES
(1, 'Jeremy Flores', 'jerxav101@gmail.com', NULL, '$2y$12$Ef0JyTPNHpIYGyFwGFEjJeCv3/wdy4312hhJwoIAC2hOmeSQNoe2i', 1, 'gZbuukuZJBEjFshIfyjDPKoYieG8WD8V7QQzMt0eiPyfRmrWqCqtOYBR4GP7', '2025-05-08 15:03:44', '2025-05-08 15:03:44'),
(2, 'Test User', 'test@example.com', '2025-09-09 18:40:46', '$2y$12$zfa2RiT9o4LKaQCvPgnnIOghExBAb5F7vkKRA2HBRzUW8ae1MxhBG', 1, 'TmMiiJR28C', '2025-09-09 18:40:46', '2025-09-09 18:40:46'),
(3, 'Esteban Aulestia', 'aulestiaesteban8@gmail.com', '2025-09-09 18:42:58', '$2y$12$RBcESzo6Z8eQlXrX8neOuOpqbYX/bNpB4XHn3DP9jwvhSL2QWBGte', 1, NULL, '2025-09-09 18:42:58', '2025-09-09 18:42:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_vehiculo`
--

CREATE TABLE `osgo_vehiculo` (
  `ID_VEHICULO` int(11) NOT NULL,
  `PLACA` varchar(20) DEFAULT NULL,
  `ACTIVO` varchar(2) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `osgo_vehiculo`
--

INSERT INTO `osgo_vehiculo` (`ID_VEHICULO`, `PLACA`, `ACTIVO`) VALUES
(1, '01-2024-EPM', 'SI'),
(2, '09-2024-EPM', 'SI'),
(3, '04-2024-EPM', 'SI'),
(4, '10-2024-EPM', 'SI'),
(5, '07-2024-EPM', 'SI'),
(6, '11-2024-EPM', 'SI'),
(7, '03-2024-EPM', 'SI'),
(8, '12-2024-EPM', 'SI'),
(9, '08-2024-EPM', 'SI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `osgo_anexo`
--
ALTER TABLE `osgo_anexo`
  ADD PRIMARY KEY (`ID_ANEXO`);

--
-- Indices de la tabla `osgo_anexo_detalle`
--
ALTER TABLE `osgo_anexo_detalle`
  ADD PRIMARY KEY (`ID_ANEXO_DETALLE`);

--
-- Indices de la tabla `osgo_anexo_recurso`
--
ALTER TABLE `osgo_anexo_recurso`
  ADD PRIMARY KEY (`ID_ANEXO_RECURSO`);

--
-- Indices de la tabla `osgo_circuitos`
--
ALTER TABLE `osgo_circuitos`
  ADD PRIMARY KEY (`ID_CIRCUITO`);

--
-- Indices de la tabla `osgo_control_horas`
--
ALTER TABLE `osgo_control_horas`
  ADD PRIMARY KEY (`ID_CONTROL_HORAS`);

--
-- Indices de la tabla `osgo_control_horas_mensuales`
--
ALTER TABLE `osgo_control_horas_mensuales`
  ADD PRIMARY KEY (`ID_CONTROL_MENSUAL`);

--
-- Indices de la tabla `osgo_detalle_orden_servicio`
--
ALTER TABLE `osgo_detalle_orden_servicio`
  ADD PRIMARY KEY (`ID_DET_ORDEN_SERVICIO`);

--
-- Indices de la tabla `osgo_disposiciones_generales`
--
ALTER TABLE `osgo_disposiciones_generales`
  ADD PRIMARY KEY (`ID_DISPOSICION`);

--
-- Indices de la tabla `osgo_disposiciones_orden`
--
ALTER TABLE `osgo_disposiciones_orden`
  ADD PRIMARY KEY (`ID_DISPOSICION_ORDEN`),
  ADD KEY `ID_ORDEN_SERVICIO` (`ID_ORDEN_SERVICIO`),
  ADD KEY `ID_DISPOSICION` (`ID_DISPOSICION`);

--
-- Indices de la tabla `osgo_estado_orden`
--
ALTER TABLE `osgo_estado_orden`
  ADD PRIMARY KEY (`ID_ESTADO_ORDEN`);

--
-- Indices de la tabla `osgo_grupos_operativos`
--
ALTER TABLE `osgo_grupos_operativos`
  ADD PRIMARY KEY (`ID_GRUPO`);

--
-- Indices de la tabla `osgo_historial_horas`
--
ALTER TABLE `osgo_historial_horas`
  ADD PRIMARY KEY (`ID_HISTORIAL`);

--
-- Indices de la tabla `osgo_horarios`
--
ALTER TABLE `osgo_horarios`
  ADD PRIMARY KEY (`ID_HORARIO`);

--
-- Indices de la tabla `osgo_novedades`
--
ALTER TABLE `osgo_novedades`
  ADD PRIMARY KEY (`ID_NOVEDAD`);

--
-- Indices de la tabla `osgo_orden_servicio`
--
ALTER TABLE `osgo_orden_servicio`
  ADD PRIMARY KEY (`ID_ORDEN_SERVICIO`);

--
-- Indices de la tabla `osgo_orden_servicio_grua`
--
ALTER TABLE `osgo_orden_servicio_grua`
  ADD PRIMARY KEY (`ID_ORDEN_GRUA`);

--
-- Indices de la tabla `osgo_recursos`
--
ALTER TABLE `osgo_recursos`
  ADD PRIMARY KEY (`ID_RECURSO`);

--
-- Indices de la tabla `osgo_roles`
--
ALTER TABLE `osgo_roles`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `osgo_roles_nombre_unique` (`NOMBRE`);

--
-- Indices de la tabla `osgo_sectores`
--
ALTER TABLE `osgo_sectores`
  ADD PRIMARY KEY (`ID_SECTOR`),
  ADD KEY `FK_sector_circuito` (`CIRCUITO_ID`);

--
-- Indices de la tabla `osgo_servicios_orden`
--
ALTER TABLE `osgo_servicios_orden`
  ADD PRIMARY KEY (`ID_SERVICIO_ORDEN`),
  ADD KEY `ID_ORDEN_SERVICIO` (`ID_ORDEN_SERVICIO`),
  ADD KEY `ID_TIPO_SERVICIO` (`ID_TIPO_SERVICIO`);

--
-- Indices de la tabla `osgo_servicio_grua`
--
ALTER TABLE `osgo_servicio_grua`
  ADD PRIMARY KEY (`ID_SERVICIO_GRUA`);

--
-- Indices de la tabla `osgo_tipos_servicio`
--
ALTER TABLE `osgo_tipos_servicio`
  ADD PRIMARY KEY (`ID_TIPO_SERVICIO`);

--
-- Indices de la tabla `osgo_tipo_vehiculo`
--
ALTER TABLE `osgo_tipo_vehiculo`
  ADD PRIMARY KEY (`ID_TIPO_VEHICULO`);

--
-- Indices de la tabla `osgo_users`
--
ALTER TABLE `osgo_users`
  ADD PRIMARY KEY (`ID_USUARIO`),
  ADD UNIQUE KEY `osgo_users_email_unique` (`EMAIL`),
  ADD KEY `fk_users_rol` (`ROL_ID`);

--
-- Indices de la tabla `osgo_vehiculo`
--
ALTER TABLE `osgo_vehiculo`
  ADD PRIMARY KEY (`ID_VEHICULO`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `osgo_anexo`
--
ALTER TABLE `osgo_anexo`
  MODIFY `ID_ANEXO` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_anexo_detalle`
--
ALTER TABLE `osgo_anexo_detalle`
  MODIFY `ID_ANEXO_DETALLE` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_anexo_recurso`
--
ALTER TABLE `osgo_anexo_recurso`
  MODIFY `ID_ANEXO_RECURSO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_circuitos`
--
ALTER TABLE `osgo_circuitos`
  MODIFY `ID_CIRCUITO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `osgo_control_horas`
--
ALTER TABLE `osgo_control_horas`
  MODIFY `ID_CONTROL_HORAS` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_control_horas_mensuales`
--
ALTER TABLE `osgo_control_horas_mensuales`
  MODIFY `ID_CONTROL_MENSUAL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_detalle_orden_servicio`
--
ALTER TABLE `osgo_detalle_orden_servicio`
  MODIFY `ID_DET_ORDEN_SERVICIO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_disposiciones_generales`
--
ALTER TABLE `osgo_disposiciones_generales`
  MODIFY `ID_DISPOSICION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `osgo_disposiciones_orden`
--
ALTER TABLE `osgo_disposiciones_orden`
  MODIFY `ID_DISPOSICION_ORDEN` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_estado_orden`
--
ALTER TABLE `osgo_estado_orden`
  MODIFY `ID_ESTADO_ORDEN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `osgo_grupos_operativos`
--
ALTER TABLE `osgo_grupos_operativos`
  MODIFY `ID_GRUPO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `osgo_historial_horas`
--
ALTER TABLE `osgo_historial_horas`
  MODIFY `ID_HISTORIAL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_horarios`
--
ALTER TABLE `osgo_horarios`
  MODIFY `ID_HORARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `osgo_novedades`
--
ALTER TABLE `osgo_novedades`
  MODIFY `ID_NOVEDAD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `osgo_orden_servicio`
--
ALTER TABLE `osgo_orden_servicio`
  MODIFY `ID_ORDEN_SERVICIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `osgo_orden_servicio_grua`
--
ALTER TABLE `osgo_orden_servicio_grua`
  MODIFY `ID_ORDEN_GRUA` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_recursos`
--
ALTER TABLE `osgo_recursos`
  MODIFY `ID_RECURSO` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `osgo_roles`
--
ALTER TABLE `osgo_roles`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `osgo_sectores`
--
ALTER TABLE `osgo_sectores`
  MODIFY `ID_SECTOR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `osgo_servicios_orden`
--
ALTER TABLE `osgo_servicios_orden`
  MODIFY `ID_SERVICIO_ORDEN` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_servicio_grua`
--
ALTER TABLE `osgo_servicio_grua`
  MODIFY `ID_SERVICIO_GRUA` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_tipos_servicio`
--
ALTER TABLE `osgo_tipos_servicio`
  MODIFY `ID_TIPO_SERVICIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `osgo_tipo_vehiculo`
--
ALTER TABLE `osgo_tipo_vehiculo`
  MODIFY `ID_TIPO_VEHICULO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_users`
--
ALTER TABLE `osgo_users`
  MODIFY `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `osgo_vehiculo`
--
ALTER TABLE `osgo_vehiculo`
  MODIFY `ID_VEHICULO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `osgo_disposiciones_orden`
--
ALTER TABLE `osgo_disposiciones_orden`
  ADD CONSTRAINT `osgo_disposiciones_orden_ibfk_1` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`) ON DELETE CASCADE,
  ADD CONSTRAINT `osgo_disposiciones_orden_ibfk_2` FOREIGN KEY (`ID_DISPOSICION`) REFERENCES `osgo_disposiciones_generales` (`ID_DISPOSICION`);

--
-- Filtros para la tabla `osgo_sectores`
--
ALTER TABLE `osgo_sectores`
  ADD CONSTRAINT `FK_sector_circuito` FOREIGN KEY (`CIRCUITO_ID`) REFERENCES `osgo_circuitos` (`ID_CIRCUITO`);

--
-- Filtros para la tabla `osgo_servicios_orden`
--
ALTER TABLE `osgo_servicios_orden`
  ADD CONSTRAINT `osgo_servicios_orden_ibfk_1` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`) ON DELETE CASCADE,
  ADD CONSTRAINT `osgo_servicios_orden_ibfk_2` FOREIGN KEY (`ID_TIPO_SERVICIO`) REFERENCES `osgo_tipos_servicio` (`ID_TIPO_SERVICIO`);

--
-- Filtros para la tabla `osgo_users`
--
ALTER TABLE `osgo_users`
  ADD CONSTRAINT `fk_users_rol` FOREIGN KEY (`ROL_ID`) REFERENCES `osgo_roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
