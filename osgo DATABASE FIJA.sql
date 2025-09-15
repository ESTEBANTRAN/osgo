-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-09-2025 a las 22:39:28
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
(2, 'CENTRO', 'PIMAMPIRO'),
(3, 'CENTRO', 'URCUQUI'),
(4, 'NORTE', 'BOLIVAR'),
(5, 'NORTE', 'ESPEJO'),
(6, 'NORTE', 'HUACA'),
(7, 'NORTE', 'MIRA'),
(8, 'NORTE', 'MONTUFAR'),
(9, 'PACIFICO', 'SAN LORENZO'),
(10, 'PACIFICO', 'ELOY ALFARO'),
(11, 'PACIFICO', 'RIO VERDE'),
(12, 'SUR', 'OTAVALO'),
(13, 'SUR', 'ANTONIO ANTE'),
(14, 'SUR', 'PEDRO MONCAYO'),
(15, 'SUR', 'COTACACHI'),
(16, 'CENTRO', 'ADMINISTRATIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'FUNCION 1', 'AC'),
(2, 'FUNCION2', 'AC');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
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
(4, '2025_05_06_084712_change_fecha_actual_nullable_on_orden_servicio_table', 2),
(5, '2025_05_22_142034_add_id_sector_to_detalle_orden_servicio_table', 3),
(6, '2025_05_29_095052_add_id_funcion_to_detalle_orden_servicio_table', 3),
(7, '2025_05_29_122618_add_id_funcion_to_detalle_orden_servicio_table', 3),
(8, '2025_06_11_091837_drop_id_tipo_grupo_from_grupo_operativo', 4),
(9, '2025_06_17_101033_create_servicio_grua_table', 4),
(11, '2025_06_30_151914_add_fk_grupo_operativo_to_funciones', 4),
(12, '2025_06_17_101035_create_orden_servicio_grua_table', 5),
(15, '2025_09_11_100100_create_osgo_anexo_detalle_table', 7),
(16, '2025_09_11_100000_create_osgo_anexo_table', 8),
(17, '2025_09_11_100200_create_osgo_anexo_recurso_table', 9),
(18, '2025_09_11_100300_create_osgo_control_horas_table', 10),
(19, '2025_09_11_100400_create_osgo_historial_horas_table', 11),
(20, '2025_09_11_100600_create_osgo_horarios_table', 12),
(21, '2025_09_11_150000_rename_users_to_osgo_users', 13),
(22, '2025_09_11_151000_add_fks_to_osgo_anexo_children', 14),
(23, '2025_09_11_152000_normalize_osgo_database', 15),
(24, '2025_09_11_153000_make_vehicles_resources_orphan', 16),
(25, '2025_09_11_154000_fix_sessions_table_structure', 17),
(26, '2025_09_11_156000_recreate_anexo_recurso_table', 18),
(27, '2025_09_11_158000_clean_duplicate_columns', 19),
(28, '2025_09_11_159000_add_missing_horarios_fields', 20),
(29, '2025_09_11_161000_fix_database_improvements', 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_servicio_grua`
--

CREATE TABLE `orden_servicio_grua` (
  `ID_ORDEN_GRUA` int(10) UNSIGNED NOT NULL,
  `ID_ORDEN_SERVICIO` int(10) UNSIGNED DEFAULT NULL,
  `ID_SERVICIO_GRUA` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(5, 'Cancelada', 'Orden cancelada y no se realizará');

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
(9, '22:00-04:00', 22, 4, '', 0, 'SI');

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
(3, NULL, '2025-05-16', 'Centro', NULL, NULL, 'Sistema', 1, '2025-05-06 18:36:53'),
(4, NULL, '2025-06-08', 'Sur', NULL, NULL, 'Sistema', 1, '2025-05-06 13:48:41');

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
(15, 'Extintor', 'EXTINTOR', 'Extintor de incendios', 'UNIDAD', 1, '2025-09-12 20:22:58', '2025-09-12 20:22:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_sectores`
--

CREATE TABLE `osgo_sectores` (
  `ID_SECTOR` int(11) NOT NULL,
  `SECTOR` varchar(100) DEFAULT NULL,
  `DISTRITO` varchar(100) DEFAULT NULL,
  `CANTON` varchar(100) DEFAULT NULL,
  `ACTIVO` char(2) DEFAULT 'S'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_sectores`
--

INSERT INTO `osgo_sectores` (`ID_SECTOR`, `SECTOR`, `DISTRITO`, `CANTON`, `ACTIVO`) VALUES
(1, 'Ibarra Centro', 'Ibarra', 'Ibarra', 'S'),
(2, 'Ibarra Norte', 'Ibarra', 'Ibarra', 'S'),
(3, 'Ibarra Sur', 'Ibarra', 'Ibarra', 'S'),
(4, 'Ibarra Este', 'Ibarra', 'Ibarra', 'S'),
(5, 'Ibarra Oeste', 'Ibarra', 'Ibarra', 'S'),
(6, 'Otavalo Centro', 'Otavalo', 'Otavalo', 'S'),
(7, 'Otavalo Norte', 'Otavalo', 'Otavalo', 'S'),
(8, 'Otavalo Sur', 'Otavalo', 'Otavalo', 'S');

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
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `osgo_users`
--

INSERT INTO `osgo_users` (`ID_USUARIO`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Jeremy Flores', 'jerxav101@gmail.com', NULL, '$2y$12$Ef0JyTPNHpIYGyFwGFEjJeCv3/wdy4312hhJwoIAC2hOmeSQNoe2i', 'gZbuukuZJBEjFshIfyjDPKoYieG8WD8V7QQzMt0eiPyfRmrWqCqtOYBR4GP7', '2025-05-08 15:03:44', '2025-05-08 15:03:44'),
(2, 'Test User', 'test@example.com', '2025-09-09 18:40:46', '$2y$12$zfa2RiT9o4LKaQCvPgnnIOghExBAb5F7vkKRA2HBRzUW8ae1MxhBG', 'TmMiiJR28C', '2025-09-09 18:40:46', '2025-09-09 18:40:46'),
(3, 'Esteban Aulestia', 'aulestiaesteban8@gmail.com', '2025-09-09 18:42:58', '$2y$12$RBcESzo6Z8eQlXrX8neOuOpqbYX/bNpB4XHn3DP9jwvhSL2QWBGte', NULL, '2025-09-09 18:42:58', '2025-09-09 18:42:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `osgo_vehiculo`
--

CREATE TABLE `osgo_vehiculo` (
  `ID_VEHICULO` int(11) NOT NULL,
  `PLACA` varchar(20) DEFAULT NULL,
  `ACTIVO` varchar(2) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 1, 1, '1002993747', 'PAULO SANTIAGO', 'ENRIQUEZ CISNEROS', '9999', '0000022222', 'SI', 'penriquez@movidelnor.gob.ec', NULL),
(2, 16, 1, '1002575072', 'ALEXANDRA SOLEDAD', 'TIAMARCA CACUANGO ', NULL, NULL, 'NO', 'atiamarca@movidelnor.gob.ec', NULL),
(3, 16, 1, '0401546031', 'CARMEN ELIZABETH', 'FLORES CHAUCA', NULL, NULL, 'NO', 'ceflores@movidelnor.gob.ec', NULL),
(4, 1, 1, '1002880480', 'DIANA ELIZABETH', 'TORRES COTACACHI', NULL, NULL, 'NO', 'dtorres@movidelnor.gob.ec', NULL),
(7, 16, 1, '1001001001', 'EMILY GERALDYNE', 'pruebas', NULL, NULL, 'NO', 'pruebas@movidelnor.gob.ec', NULL),
(8, 16, 1, '1001001001', 'IBARRA', 'AGENTES', '111', '0000002222', 'NO', 'penriquez@movidelnor.gob.ec', NULL),
(9, 16, 1, '0401326608', 'CARLOS MICHAEL', 'JIMENEZ BORJA ', NULL, NULL, 'NO', 'cjimenez@movidelnor.gob.ec', NULL),
(10, 1, 2, '1003337936', 'ABIGAIL ALEXANDRA', 'AMAGUAÃA ICHAU', '002', '0989915759', 'SI', 'aamaguana@movidelnor.gob.ec', NULL),
(11, 1, 2, '1002981080', 'PAUL STEFH', 'ANDRADE GUERRERO', '003', '0999151125', 'SI', 'pandrade@movidelnor.gob.ec', NULL),
(12, 1, 2, '1003625843', 'LEONARDO DAVID', 'BADILLO GONZALEZ', '004', '0982599069', 'SI', 'lbadillo@movidelnor.gob.ec', NULL),
(13, 1, 2, '1003685656', 'JESSICA PAOLA', 'BASTIDAS VEGA', '005', '0959626135', 'SI', 'jbastidas@movidelnor.gob.ec', NULL),
(14, 1, 2, '1002821302', 'JULIO JAVIER', 'BOSMEDIANO HIGUERA', '007', '0996397846', 'SI', 'jbosmediano@movidelnor.gob.ec', NULL),
(15, 1, 2, '1002936480', 'STEFANY PATRICIA', 'CAICEDO BUCHELI', '008', '0969324176', 'SI', 'scaicedo@movidelnor.gob.ec', NULL),
(16, 2, 2, '1003683693', 'ANDERSON DAMIAN', 'CALDERON BUENAÃO', '009', '0963836781', 'SI', 'acalderon@movidelnor.gob.ec', NULL),
(17, 1, 2, '1003603790', 'JOSELYN LILIBETH', 'COLIMBA COLLAGUAZO', '012', '0992717123', 'SI', 'jcolimba@movidelnor.gob.ec', NULL),
(18, 1, 2, '1003836705', 'GEOVANY WLADIMIR', 'CORTEZ CHASIGUANO', '013', '0994417697', 'SI', 'gcortez@movidelnor.gob.ec', NULL),
(19, 1, 2, '1003837026', 'MIGUEL ANGEL', 'DIAZ ARTEAGA', '014', '0996131877', 'SI', 'mdiaz@movidelnor.gob.ec', NULL),
(20, 1, 2, '1003691720', 'ANGELO PATRICIO', 'DIAZ VEGA', '015', '0996649509', 'SI', 'adiaz@movidelnor.gob.ec', NULL),
(21, 1, 2, '1003273073', 'JIMMY FERNANDO', 'ENRIQUEZ FLORES', '016', '0963110085', 'SI', 'jenriquez@movidelnor.gob.ec', NULL),
(22, 1, 2, '1003306626', 'MAYRA LIZETH', 'FERNANDEZ GALLEGOS', '018', '0990924994', 'SI', 'mfernandez@movidelnor.gob.ec', NULL),
(23, 1, 2, '1003629878', 'DIANA CAROLINA', 'FLORES CONDULLE', '019', '0099632076', 'SI', 'dflores@movidelnor.gob.ec', NULL),
(24, 1, 2, '1003415054', 'LILIAN PATRICIA', 'FRAGA PASPUEL', '020', '0967396899', 'SI', 'lfraga@movidelnor.gob.ec', NULL),
(25, 1, 2, '1002739942', 'ANDRES DARIO', 'GRIJALVA YEPEZ', '021', '0993357142', 'SI', 'agrijalva@movidelnor.gob.ec', NULL),
(26, 1, 2, '1003174958', 'ROSARIO ELIZABETH', 'GUANANGA SANCHEZ', '022', '0992025920', 'SI', 'rguananga@movidelnor.gob.ec', NULL),
(27, 1, 2, '1003687116', 'DENISE LORENA', 'GUERRA CRIOLLO', '023', '0999453256', 'SI', 'dguerra@movidelnor.gob.ec', NULL),
(28, 1, 2, '1003588769', 'ALEJANDRO WLADIMIR', 'HUERTAS PAVON', '024', '0997537713', 'SI', 'ahuertas@movidelnor.gob.ec', NULL),
(29, 1, 2, '1004183990', 'CRISTIAN GREGORIO', 'LAHUATTE CASTRO', '025', '0978795888', 'SI', 'clahuatte@movidelnor.gob.ec', NULL),
(30, 1, 2, '1002927398', 'LEONARDO WLADIMIR', 'LANDAZURI ARELLANO', '026', '0968141388', 'SI', 'llandazuri@movidelnor.gob.ec', NULL),
(31, 1, 2, '0401696976', 'ERIKA GISELA', 'LOBATO MAYANQUER', '027', '0981474499', 'SI', 'elobato@movidelnor.gob.ec', NULL),
(32, 1, 2, '1003380712', 'EDISON ANDRES', 'LOZA RIVERA', '029', '0962945984', 'SI', 'eloza@movidelnor.gob.ec', NULL),
(33, 1, 2, '1003652839', 'JONATHAN SANTIAGO', 'MANZO JACOME', '030', '0990261397', 'SI', 'jmanzo@movidelnor.gob.ec', NULL),
(34, 1, 2, '1003594973', 'JOHN EDISON', 'MAYANQUER ERAZO', '031', '0996426949', 'SI', 'jmayanquer@movidelnor.gob.ec', NULL),
(35, 1, 2, '1003558812', 'FRANKLIN SANTIAGO', 'MAYORGA MORENO', '032', '0984375420', 'SI', 'fmayorga@movidelnor.gob.ec', NULL),
(36, 1, 2, '1003749940', 'BAIRON EDUARDO', 'MOREJON ALBUJA', '033', '0969561338', 'SI', 'bmorejon@movidelnor.gob.ec', NULL),
(37, 1, 2, '1003997549', 'ALEXIS HUMBERTO', 'MUÃOZ GARCIA', '034', '0997539114', 'SI', 'amunoz@movidelnor.gob.ec', NULL),
(38, 1, 2, '1003062104', 'CRISTIAN FRANCISCO', 'NEGRETE RAMIREZ', '035', '0990493228', 'SI', 'cnegrete@movidelnor.gob.ec', NULL),
(39, 1, 2, '1003564604', 'LUIS EDUARDO', 'ORDOÃEZ OBANDO', '036', '0981846642', 'SI', 'lordonez@movidelnor.gob.ec', NULL),
(40, 1, 2, '1003119698', 'RUBEN DARIO', 'ORTEGA CHASI', '037', '0997966850', 'SI', 'rortega@movidelnor.gob.ec', NULL),
(41, 1, 2, '1003605480', 'ANDREA MISHEL', 'ORTIZ GUERRA', '038', '0989073112', 'SI', 'amortiz@movidelnor.gob.ec', NULL),
(42, 1, 2, '1002976080', 'JEFERSON RICARDO', 'PASTRANA TERAN', '039', '0990608016', 'SI', 'jpastrana@movidelnor.gob.ec', NULL),
(43, 1, 2, '1003249750', 'CARLOS ANDRES', 'PINEDA POZO', '040', '0961165949', 'SI', 'capineda@movidelnor.gob.ec', NULL),
(44, 1, 2, '1003167903', 'ALEXANDER FERNANDO', 'POZO ALTAMIRANO', '041', '0997794743', 'SI', 'apozo@movidelnor.gob.ec', NULL),
(45, 1, 2, '1003692496', 'HAMILTON LEANDRO', 'PUERRES RUEDA', '042', '0982131605', 'SI', 'hpuerres@movidelnor.gob.ec', NULL),
(46, 1, 2, '1003764337', 'CESAR OSWALDO', 'QUIGUANGO ERAZO', '043', '0992563989', 'SI', 'cquiguango@movidelnor.gob.ec', NULL),
(47, 1, 2, '1723564728', 'ANDERSON SANTIAGO', 'REYES ENRIQUEZ', '044', '0980623233', 'SI', 'areyes@movidelnor.gob.ec', NULL),
(48, 1, 2, '1003373766', 'KATHERINE MARIBEL', 'RIOS MORILLO', '045', '0996467458', 'SI', 'krios@movidelnor.gob.ec', NULL),
(49, 1, 2, '1003328125', 'DAISY ALEJANDRA', 'RODRIGUEZ MORALES', '046', '0960522074', 'SI', 'darodriguez@movidelnor.gob.ec', NULL),
(50, 1, 2, '1003602354', 'JAVIER FERNANDO', 'SALAZAR NOBOA', '047', '0968475850', 'SI', 'jfsalazar@movidelnor.gob.ec', NULL),
(51, 1, 2, '1002864013', 'JOSE EDUARDO', 'SALAZAR YANDUN', '048', '0983532035', 'SI', 'jsalazar@movidelnor.gob.ec', NULL),
(52, 1, 2, '1003601208', 'WAGNER ANDRES', 'SANCHEZ RODRIGUEZ', '049', '0995206469', 'SI', 'wsanchez@movidelnor.gob.ec', NULL),
(53, 1, 2, '1003291794', 'ADRIANA SOLEDAD', 'TONTAG COLLAGUAZO', '050', '0994292128', 'SI', 'atontag@movidelnor.gob.ec', NULL),
(54, 1, 2, '1003180591', 'ALBERTH SANTIAGO', 'TORRES AZA', '051', '0996807378', 'SI', 'atorres@movidelnor.gob.ec', NULL),
(55, 1, 2, '1003773049', 'CRISTIAN MOISES', 'TUZA TUZA', '052', '0986560888', 'SI', 'ctuza@movidelnor.gob.ec', NULL),
(56, 1, 2, '1003817523', 'KAREN ANABEL', 'VACA ARCOS', '053', '0998030163', 'SI', 'kvaca@movidelnor.gob.ec', NULL),
(57, 1, 2, '1003667936', 'JORDAN DANIEL', 'VALENCIA GONZALON', '054', '0967703434', 'SI', 'jvalencia@movidelnor.gob.ec', NULL),
(58, 1, 2, '1003428750', 'MARIANA DE JESUS', 'VARGAS CHAGNA', '055', '0967705950', 'SI', 'mvargas@movidelnor.gob.ec', NULL),
(59, 1, 2, '1003377452', 'ANDRES OSWALDO', 'VILLARRUEL AHTTY', '058', '0996697775', 'SI', 'avillarruel@movidelnor.gob.ec', NULL),
(60, 12, 2, '1002576146', 'OSWALDO JOSE', 'ALMEIDA CABASCANGO', '059', '0969327790', 'SI', 'oalmeida@movidelnor.gob.ec', NULL),
(61, 3, 2, '0401710546', 'CRISTIAN GEOVANNY', 'ALMEIDA TAPIA', '060', '0939929543', 'SI', 'calmeida@movidelnor.gob.ec', NULL),
(62, 13, 2, '1003233564', 'WILMER FERNANDO', 'ANDRADE ALBUJA', '062', '0999135738', 'SI', 'wandrade@movidelnor.gob.ec', NULL),
(63, 12, 2, '1003333513', 'JOHNNY CARLOS', 'ANDRADE AREVALO', '063', '0992779563', 'SI', 'aandrade@movidelnor.gob.ec', NULL),
(64, 12, 2, '1003847264', 'IVAN PATRICIO', 'ANDRADE AVILA', '064', '0995752584', 'SI', 'iandrade@movidelnor.gob.ec', NULL),
(65, 14, 2, '1003764210', 'DARWIN FERNANDO', 'ANDRANGO CUASCOTA', '065', '0978882787', 'SI', 'dandrango@movidelnor.gob.ec', NULL),
(66, 8, 2, '0401732078', 'BYRON XAVIER', 'ATIZ BENAVIDES', '067', '0996393338', 'SI', 'batiz@movidelnor.gob.ec', NULL),
(67, 4, 2, '1004168371', 'SILVANA ESTEFANIA', 'AYALA CRIBAN', '068', '0997050519', 'SI', 'sayala@movidelnor.gob.ec', NULL),
(68, 14, 2, '1720553898', 'EMMA VICTORIA', 'BAÃO SALAZAR', '070', '0996781465', 'SI', 'ebano@movidelnor.gob.ec', NULL),
(69, 1, 2, '1003519004', 'ISRAEL ADRIAN', 'BASTIDAS ESPINOZA', '071', '0991789786', 'SI', 'ibastidas@movidelnor.gob.ec', NULL),
(70, 13, 2, '1002957668', 'MARIO RICARDO', 'BAYETERO CALDERON', '072', '0991351904', 'SI', 'rbayetero@movidelnor.gob.ec', NULL),
(71, 8, 2, '0401701727', 'BYRON FABRICIO', 'BEDON PULISTAR', '073', '0985812267', 'SI', 'bbedon@movidelnor.gob.ec', NULL),
(72, 1, 2, '0401579446', 'STALYN JAVIER', 'BELTRAN DEL HIERRO', '074', '0993490738', 'SI', 'sbeltran@movidelnor.gob.ec', NULL),
(73, 1, 2, '1722777909', 'ANA GABRIELA', 'BENAVIDES TIANGA', '075', '0980498831', 'SI', 'abenavides@movidelnor.gob.ec', NULL),
(74, 9, 2, '1004142111', 'WASHINGTON EDUARDO', 'BOBOY CAICEDO', '076', '0968743997', 'SI', 'wboboy@movidelnor.gob.ec', NULL),
(75, 8, 2, '0401757554', 'BYRON FABRICIO', 'BOLAÃOS GAONA', '077', '0986139071', 'SI', 'bbolanos@movidelnor.gob.ec', NULL),
(76, 12, 2, '1003627526', 'OMAR ALEXANDER', 'BOLAÃOS GUERRERO', '078', '0997601498', 'SI', 'obolanos@movidelnor.gob.ec', NULL),
(77, 8, 2, '0401302955', 'RAÃL ANDRES', 'BOLAÃOS MICHILENA', '079', '0997182597', 'SI', 'rbolanos@movidelnor.gob.ec', NULL),
(78, 12, 2, '1003185079', 'GERSON LEDIN', 'BONILLA MENDEZ', '080', '0986428593', 'SI', 'gbonilla@movidelnor.gob.ec', NULL),
(79, 12, 2, '1004646954', 'EMERSON MAURICIO', 'BONILLA TOCAGON', '081', '0967628148', 'SI', 'ebonilla@movidelnor.gob.ec', NULL),
(80, 1, 2, '1003168117', 'CARLOS ISRAEL', 'CAICEDO BRUSIL', '084', '0991546639', 'SI', 'ccaicedo@movidelnor.gob.ec', NULL),
(81, 9, 2, '0804078889', 'JOSE GUILLERMO', 'CAICEDO MARTINEZ', '086', '0980010732', 'SI', 'jgcaicedo@movidelnor.gob.ec', NULL),
(82, 12, 2, '1003609565', 'MILTON BLADIMIR', 'CALAPAQUI BONILLA', '087', '0982346061', 'SI', 'mcalapaqui@movidelnor.gob.ec', NULL),
(83, 7, 2, '0401781232', 'LUIS DAVID', 'CANACUAN PALMA', '088', '0969112053', 'SI', 'lcanacuan@movidelnor.gob.ec', NULL),
(84, 1, 2, '1002841003', 'CRISTIAN GEOVANNY', 'CARDENAS ROSERO', '089', '0994409935', 'SI', 'ccardenas@movidelnor.gob.ec', NULL),
(85, 12, 2, '1003564166', 'DAVID ANDRES', 'CASTILLO CAMPUEZ', '090', '0998857121', 'SI', 'dcastillo@movidelnor.gob.ec', NULL),
(86, 4, 2, '1003616016', 'ALEX DAVID', 'CASTILLO CASTRO', '091', '0992870452', 'SI', 'acastillo@movidelnor.gob.ec', NULL),
(87, 1, 2, '0928503291', 'CARLOS ANTONIO', 'CASTILLO JARA', '092', '0939276808', 'SI', 'ccastillo@movidelnor.gob.ec', NULL),
(88, 6, 2, '0401893193', 'VALERIA ESTEFANIA', 'CASTILLO PEREZ', '093', '0993757587', 'SI', 'vcastillo@movidelnor.gob.ec', NULL),
(89, 13, 2, '1003108006', 'DANILO FERNANDO', 'CEVALLOS DELGADO', '095', '0967366709', 'SI', 'dcevallos@movidelnor.gob.ec', NULL),
(90, 4, 2, '0401764295', 'BYRON ENRIQUE', 'CHALACAN ARAGON', '096', '0994890714', 'SI', 'bchalacan@movidelnor.gob.ec', NULL),
(91, 8, 2, '0401867221', 'SANTIAGO XAVIER', 'CHAMORRO POZO', '097', '0960570031', 'SI', 'schamorro@movidelnor.gob.ec', NULL),
(92, 5, 2, '1003668090', 'JOSE LUIS', 'CHANDI FLORES', '098', '0994284099', 'SI', 'jchandi@movidelnor.gob.ec', NULL),
(93, 14, 2, '1003837125', 'CELSO ENRIQUE', 'CHASI PAZMIÃO', '099', '0980823685', 'SI', 'cchasi@movidelnor.gob.ec', NULL),
(94, 1, 2, '1003292669', 'CRISTIAN SANTIAGO', 'CHAUCA VARGAS', '100', '0959915792', 'SI', 'cchauca@movidelnor.gob.ec', NULL),
(95, 9, 2, '1003952304', 'MARIA VIVIANNA', 'CHAVEZ QUINTERO', '101', '0980775526', 'SI', 'mvchavez@movidelnor.gob.ec', NULL),
(96, 1, 2, '1003158217', 'SILVIA CRISTINA', 'CHICAIZA ARCINIEGA', '103', '0959007440', 'SI', 'schicaiza@movidelnor.gob.ec', NULL),
(97, 12, 2, '1004011167', 'DARWIN ISRAEL', 'CORDOVA ENCALADA', '104', '0981116914', 'SI', 'dcordova@movidelnor.gob.ec', NULL),
(98, 1, 2, '1003862743', 'ANA BELEN', 'CUAMACAS HEREDIA', '107', '0997991836', 'SI', 'acuamacas@movidelnor.gob.ec', NULL),
(99, 1, 2, '1003523733', 'BRYAN ANDERSON', 'CUASATAR POZO', '108', '0997030562', 'SI', 'bcuasatar@movidelnor.gob.ec', NULL),
(100, 14, 2, '1724587348', 'LUIS IVAN', 'CUASCOTA CABASCANGO', '109', '0985472014', 'SI', 'lcuascota@movidelnor.gob.ec', NULL),
(101, 14, 2, '1722791694', 'JOSE VIDAL', 'CUASCOTA CABASCANGO', '110', '0981577325', 'SI', 'jcuascota@movidelnor.gob.ec', NULL),
(102, 14, 2, '1726105982', 'CLAUDIA MARITZA', 'CUASCOTA CABASCANGO', '111', '0961587295', 'SI', 'ccuascota@movidelnor.gob.ec', NULL),
(103, 9, 2, '0803929959', 'LEGSON MARCELO', 'CORTEZ HURTADO', '112', '0967704429', 'SI', 'lcortez@movidelnor.gob.ec', NULL),
(104, 13, 2, '1004088405', 'MAYRA ELIZABETH', 'DAVILA GARZON', '113', '0963230091', 'SI', 'mdavila@movidelnor.gob.ec', NULL),
(105, 13, 2, '1003274394', 'MARCOS ALEXANDER', 'DE JESUS ANDRADE', '114', '0993855247', 'SI', 'madejesus@movidelnor.gob.ec', NULL),
(106, 13, 2, '1004562516', 'EDWIN JAVIER', 'DE LA TORRE CACUANGO', '115', '0982296590', 'SI', 'edelatorre@movidelnor.gob.ec', NULL),
(107, 3, 2, '1003760731', 'KLEBER BAYARDO', 'DE LA TORRE', '116', '0993357263', 'SI', 'kdelatorre@movidelnor.gob.ec', NULL),
(108, 13, 2, '1003084108', 'BYRON LEONARDO', 'DIAZ ACOSTA', '117', '0989391517', 'SI', 'bdiaz@movidelnor.gob.ec', NULL),
(109, 4, 2, '1003371471', 'IRVING LOMBARDO', 'DIAZ CAZARES', '118', '0999164154', 'SI', 'idiaz@movidelnor.gob.ec', NULL),
(110, 1, 2, '1004232581', 'SANTIAGO ISRAEL', 'DURAN AYALA', '119', '0985866149', 'SI', 'sduran@movidelnor.gob.ec', NULL),
(111, 5, 2, '0401677182', 'CARLOS ALEXIS', 'ENRIQUEZ CHUGA', '120', '0981367288', 'SI', 'cenriquez@movidelnor.gob.ec', NULL),
(112, 1, 2, '1003226980', 'JAIRO ANDRES', 'ENRIQUEZ OBANDO', '121', '0997462946', 'SI', 'jaenriquez@movidelnor.gob.ec', NULL),
(113, 2, 2, '1003542105', 'ELVIA SILVANA', 'ENRIQUEZ QUIROZ', '122', '0983693536', 'SI', 'eenriquez@movidelnor.gob.ec', NULL),
(114, 3, 2, '1003672258', 'ALEX ALCIBAR', 'ESCANTA QUILCA', '123', '0967938299', 'SI', 'aescanta@movidelnor.gob.ec', NULL),
(115, 4, 2, '1003990189', 'STALIN PAUL', 'ESPINOZA LARA', '124', '0995308947', 'SI', 'sespinoza@movidelnor.gob.ec', NULL),
(116, 1, 2, '1003896014', 'FERNANDO XAVIER', 'FALCON CABEZAS', '125', '0983203880', 'SI', 'ffalcon@movidelnor.gob.ec', NULL),
(117, 4, 2, '1003627542', 'JOCELYN ANDREINA', 'FOLLECO DE JESUS', '127', '0988736852', 'SI', 'jfolleco@movidelnor.gob.ec', NULL),
(118, 1, 2, '1003468509', 'VERONICA ALEXANDRA', 'FRANCO REYES', '128', '0981446535', 'SI', 'vfranco@movidelnor.gob.ec', NULL),
(119, 3, 2, '1003507314', 'EDGAR ANDRES', 'GALLEGOS IMBAQUINGO', '129', '0981593401', 'SI', 'egallegos@movidelnor.gob.ec', NULL),
(120, 1, 2, '1003060165', 'JOHN JAIRO', 'GARCIA CARTAGENA', '130', '0982385160', 'SI', 'jgarcia@movidelnor.gob.ec', NULL),
(121, 2, 2, '1003769658', 'DIEGO GIOVANNI', 'GODOY GUNSHA', '131', '0992478308', 'SI', 'dgodoy@movidelnor.gob.ec', NULL),
(122, 12, 2, '1723968994', 'SILVIA GARDENIA', 'GOMEZ PROAÃO', '132', '0983511638', 'SI', 'sgomez@movidelnor.gob.ec', NULL),
(123, 12, 2, '1003570007', 'LUIS ANDRES', 'GONZALES DE LA TORRE', '133', '0984882635', 'SI', 'lgonzales@movidelnor.gob.ec', NULL),
(124, 8, 2, '0401744271', 'CRISTIAN DAVID', 'GUACHAN TANA', '134', '0959251655', 'SI', 'cguachan@movidelnor.gob.ec', NULL),
(125, 14, 2, '1003781257', 'JONATHAN JAVIER', 'GUAMA PATIÃO', '136', '0980507139', 'SI', 'jguama@movidelnor.gob.ec', NULL),
(126, 13, 2, '1003514526', 'ALEX DARIO', 'GUAMAN ALBUJA', '137', '0984744409', 'SI', 'aguaman@movidelnor.gob.ec', NULL),
(127, 1, 2, '1003314323', 'FABRICIO ISRAEL', 'GUDIÃO INSUASTI', '138', '0987403911', 'SI', 'fgudino@movidelnor.gob.ec', NULL),
(128, 12, 2, '1003088109', 'GUILLERMO JAVIER', 'HINOJOSA BURGA', '139', '0997494868', 'SI', 'ghinojosa@movidelnor.gob.ec', NULL),
(129, 8, 2, '0401388996', 'NATALIA ARACELLY', 'IBUJES ALPALA', '140', '0990513509', 'SI', 'nibujes@movidelnor.gob.ec', NULL),
(130, 1, 2, '1003624721', 'EDWIN DAVID', 'ILES FARINANGO', '141', '0989317531', 'SI', 'eiles@movidelnor.gob.ec', NULL),
(131, 14, 2, '1719490250', 'EDISON MIGUEL', 'IMBA PINEIDA', '142', '0985539444', 'SI', 'eimba@movidelnor.gob.ec', NULL),
(132, 1, 2, '1003362827', 'JONATHAN ANDRES', 'IPIALES FLORES', '144', '0979152815', 'SI', 'jipiales@movidelnor.gob.ec', NULL),
(133, 1, 2, '1003254156', 'EDISON SANTIAGO', 'IRUA BALAREZO', '145', '0991803545', 'SI', 'eirua@movidelnor.gob.ec', NULL),
(134, 9, 2, '0850217506', 'EDWARD ISMAEL', 'LEMOS CASTILLO', '146', '0989019643', 'SI', 'elemos@movidelnor.gob.ec', NULL),
(135, 8, 2, '0401886486', 'RUBEN DARIO', 'JACOME PIARPUEZAN', '147', '0967702236', 'SI', 'rjacome@movidelnor.gob.ec', NULL),
(136, 12, 2, '1003799358', 'AMANDA DEL ROCIO', 'LOPEZ FRANCO', '149', '0997451467', 'SI', 'alopez@movidelnor.gob.ec', NULL),
(137, 13, 2, '1004325682', 'JIMENA ALEXANDRA', 'LOZADA BELTRAN', '150', '0993371059', 'SI', 'jlozada@movidelnor.gob.ec', NULL),
(138, 13, 2, '1003635362', 'HENRY DAVID', 'LUCERO SOLIS', '151', '0989003791', 'SI', 'hlucero@movidelnor.gob.ec', NULL),
(139, 12, 2, '1003520622', 'PAUL DANIEL', 'LUGO ORTIZ', '152', '0996510654', 'SI', 'plugo@movidelnor.gob.ec', NULL),
(140, 13, 2, '1004484315', 'EDISSON XAVIER', 'LUNA QUILIGUANGO', '153', '0980289705', 'SI', 'eluna@movidelnor.gob.ec', NULL),
(141, 1, 2, '0401646625', 'FABIAN RODRIGO', 'MADERA GUERRERO', '154', '0959104647', 'SI', 'fmadera@movidelnor.gob.ec', NULL),
(142, 1, 2, '1003401880', 'ERICK STALIN', 'MANOSALVAS GUEVARA', '156', '0969605644', 'SI', 'emanosalvas@movidelnor.gob.ec', NULL),
(143, 1, 2, '0401711668', 'PATRICIO FERNANDO', 'MANTECA DE LA CRUZ', '157', '0939968535', 'SI', 'pmanteca@movidelnor.gob.ec', NULL),
(144, 1, 2, '1003267851', 'EDGAR FERNANDO', 'MINA MENDEZ', '159', '0990394123', 'SI', 'emina@movidelnor.gob.ec', NULL),
(145, 12, 2, '1004352108', 'MARTHA ISABEL', 'MOLINA OYAGATA', '160', '0963443663', 'SI', 'mimolina@movidelnor.gob.ec', NULL),
(146, 6, 2, '1004061915', 'MARIO ENRIQUE', 'MONCAYO SOTO', '161', '0967563530', 'SI', 'memoncayo@movidelnor.gob.ec', NULL),
(147, 6, 2, '0401426960', 'TANIA ELIZABETH', 'MONTALVO AYALA', '162', '0983211965', 'SI', 'tmontalvo@movidelnor.gob.ec', NULL),
(148, 6, 2, '0401635487', 'MAURICIO ALEXANDER', 'MONTENEGRO GUEVARA', '163', '0999592309', 'SI', 'mmontenegro@movidelnor.gob.ec', NULL),
(149, 2, 2, '1003620562', 'LUIS ESTEBAN', 'MORA VILLEGAS', '164', '0998747532', 'SI', 'lmora@movidelnor.gob.ec', NULL),
(150, 3, 2, '1003645296', 'MONICA VALQUIRIA', 'MORALES CRUZ', '165', '0997550917', 'SI', 'mmorales@movidelnor.gob.ec', NULL),
(151, 3, 2, '1004490999', 'PAULINA MACARENA', 'MORALES MINA', '166', '0980253372', 'SI', 'pmorales@movidelnor.gob.ec', NULL),
(152, 3, 2, '1004458269', 'JONATHAN FERNANDO', 'MORALES TERAN', '167', '0959545221', 'SI', 'jfmorales@movidelnor.gob.ec', NULL),
(153, 1, 2, '1003918859', 'LUIS EDUARDO', 'MORALES ULCUANGO', '168', '0988934369', 'SI', 'lmorales@movidelnor.gob.ec', NULL),
(154, 12, 2, '1003426895', 'HENRY DANILO', 'MORENO CHANCUSIG', '169', '0993973008', 'SI', 'hmoreno@movidelnor.gob.ec', NULL),
(155, 8, 2, '0401827050', 'EDWIN WILLIAM', 'MORENO MONTENEGRO', '170', '0996094034', 'SI', 'emoreno@movidelnor.gob.ec', NULL),
(156, 1, 2, '1003581913', 'DIEGO JAVIER', 'MORQUECHO CASTRO', '171', '0999314197', 'SI', 'dmorquecho@movidelnor.gob.ec', NULL),
(157, 7, 2, '0401782891', 'NATALY ELIZABETH', 'MUÃOZ PABON', '172', '0996549796', 'SI', 'nmunoz@movidelnor.gob.ec', NULL),
(158, 2, 2, '1003437371', 'JEFFERSON SANTIAGO', 'NAVARRETE MORILLO', '174', '0939691862', 'SI', 'jsnavarrete@movidelnor.gob.ec', NULL),
(159, 8, 2, '0401873443', 'KAREN ANDREA', 'NAVARRETE PULISTAR', '175', '0997104320', 'SI', 'knavarrete@movidelnor.gob.ec', NULL),
(160, 5, 2, '0401686944', 'CRISTIAN OLMEDO', 'NAVARRETE TAIMAL', '176', '0989362377', 'SI', 'cnavarrete@movidelnor.gob.ec', NULL),
(161, 1, 2, '1003502919', 'TANIA DANIELA', 'NAVARRO SUAREZ', '177', '0982392686', 'SI', 'tnavarro@movidelnor.gob.ec', NULL),
(162, 1, 2, '1003214804', 'LIZETH MARIANELA', 'ORDOÃEZ RIVADENEIRA', '179', '0989387915', 'SI', 'lmordonez@movidelnor.gob.ec', NULL),
(163, 1, 2, '1003165865', 'MIGUEL EDUARDO', 'OREJUELA PEREZ', '180', '0998897108', 'SI', 'morejuela@movidelnor.gob.ec', NULL),
(164, 5, 2, '0401689658', 'LUIS GERMAN', 'PABON CASTRO', '182', '0993920270', 'SI', 'lpabon@movidelnor.gob.ec', NULL),
(165, 6, 2, '0401683826', 'DANNY ANDERSON', 'PAILLACHO HERNANDEZ', '183', '0958913907', 'SI', 'dpaillacho@movidelnor.gob.ec', NULL),
(166, 7, 2, '1003644562', 'DANNY PAUL', 'PANTOJA CORAL', '184', '0997763825', 'SI', 'dpantoja@movidelnor.gob.ec', NULL),
(167, 12, 2, '1004037147', 'SILVIA PATRICIA', 'PAVON HERRERA', '185', '0997763379', 'SI', 'spavon@movidelnor.gob.ec', NULL),
(168, 1, 2, '1002846713', 'FAUSTO ISRAEL', 'PEÃAFIEL JATIVA', '186', '0998607147', 'SI', 'fpenafiel@movidelnor.gob.ec', NULL),
(169, 3, 2, '1003224001', 'GUILLERMO FABIAN', 'PEÃAFIEL QUELAL', '187', '0983944374', 'SI', 'gpenafiel@movidelnor.gob.ec', NULL),
(170, 5, 2, '0401689187', 'JHONNY ALEXANDER', 'PEREZ MIPAZ', '188', '0959272574', 'SI', 'japerez@movidelnor.gob.ec', NULL),
(171, 1, 2, '0401808886', 'CESAR ALBERTO', 'PILACUAN PIAUN', '189', '0989233444', 'SI', 'cpilacuan@movidelnor.gob.ec', NULL),
(172, 1, 2, '1003466461', 'MISHEL ELIZABETH', 'PILLO GUANOLUISA', '190', '0996973808', 'SI', 'mpillo@movidelnor.gob.ec', NULL),
(173, 7, 2, '1003826771', 'HALVER ARGENIS', 'POLO PADILLA', '191', '0992332044', 'SI', 'hpolo@movidelnor.gob.ec', NULL),
(174, 5, 2, '0401686811', 'MARLON JIMMY', 'PULLES QUELAL', '193', '0997559731', 'SI', 'mpulles@movidelnor.gob.ec', NULL),
(175, 1, 2, '1003216510', 'EVELYN YOLANDA', 'QUEREMBAS AREVALO', '194', '0979282808', 'SI', 'equerembas@movidelnor.gob.ec', NULL),
(176, 13, 2, '1004480271', 'CRISTIAN DAVID', 'QUILCA GUALOMOTO', '195', '0968536400', 'SI', 'cquilca@movidelnor.gob.ec', NULL),
(177, 12, 2, '1004072755', 'EDISON MANUEL', 'QUIMBIULCO ANTAMBA', '196', '0967410259', 'SI', 'equimbiulco@movidelnor.gob.ec', NULL),
(178, 3, 2, '1004270342', 'JAIRO DANIEL', 'QUIRANZA QUIGUANGO', '197', '0968172335', 'SI', 'jquiranza@movidelnor.gob.ec', NULL),
(179, 7, 2, '0401720941', 'BYRON ALEXANDER', 'QUITAMA PASTAS', '198', '0982015798', 'SI', 'bquitama@movidelnor.gob.ec', NULL),
(180, 12, 2, '1004354161', 'ANDRES SEBASTIAN', 'RAMIREZ CHASIPANTA', '199', '0982694521', 'SI', 'aramirez@movidelnor.gob.ec', NULL),
(181, 7, 2, '0401609011', 'JORGE ANDRES', 'RAMIREZ TAPIA', '200', '0982858587', 'SI', 'jramirez@movidelnor.gob.ec', NULL),
(182, 1, 2, '1003653068', 'ANDERSSON GABRIEL', 'RAMOS CHECA', '201', '0985452442', 'SI', 'aramos@movidelnor.gob.ec', NULL),
(183, 1, 2, '1003550686', 'RONNIE FABRICIO', 'RECALDE ARMAS', '202', '0981914314', 'SI', 'rrecalde@movidelnor.gob.ec', NULL),
(184, 13, 2, '1002998332', 'FRANKLIN GUILLERMO', 'REVELO ERAZO', '203', '0990179922', 'SI', 'frevelo@movidelnor.gob.ec', NULL),
(185, 1, 2, '0401609888', 'TANIA ALEJANDRA', 'REVELO HERRERA', '204', '0981108553', 'SI', 'trevelo@movidelnor.gob.ec', NULL),
(186, 1, 2, '1725957771', 'DANIEL ALEJANDRO', 'ROBLES ORTEGA', '205', '0988888315', 'SI', 'drobles@movidelnor.gob.ec', NULL),
(187, 12, 2, '1003648035', 'PABLO ANDRES', 'RODRIGUEZ CHUSQUILLO', '206', '0984842630', 'SI', 'prodriguez@movidelnor.gob.ec', NULL),
(188, 8, 2, '0401559042', 'CARLOS EDUARDO', 'ROJAS MORILLO', '207', '0989601326', 'SI', 'crojas@movidelnor.gob.ec', NULL),
(189, 12, 2, '1003316021', 'ESTEBAN ERNESTO', 'ROMERO ARAQUE', '208', '0979910748', 'SI', 'eromero@movidelnor.gob.ec', NULL),
(190, 7, 2, '0401712195', 'FREDDY DAMIAN', 'ROSERO LAGOS', '210', '0961789430', 'SI', 'frosero@movidelnor.gob.ec', NULL),
(191, 1, 2, '0401609425', 'JORGE ANIBAL', 'ROSERO QUIROZ', '211', '0969942723', 'SI', 'jrosero@movidelnor.gob.ec', NULL),
(192, 2, 2, '1003631585', 'DIANA LUCIA', 'SALAZAR CHASI', '212', '0959592096', 'SI', 'dsalazar@movidelnor.gob.ec', NULL),
(193, 1, 2, '1003329099', 'INES GABRIELA', 'SALAZAR ISIZAN', '214', '0988384305', 'SI', 'isalazar@movidelnor.gob.ec', NULL),
(194, 12, 2, '1003578935', 'LUIS ALFONSO', 'SAMANIEGO SEVILLA', '215', '0980239282', 'SI', 'lsamaniego@movidelnor.gob.ec', NULL),
(195, 14, 2, '1724432570', 'FRANKLIN ERNESTO', 'SANCHEZ GREFA', '216', '0995232422', 'SI', 'fsanchez@movidelnor.gob.ec', NULL),
(196, 8, 2, '0401801121', 'EDISON GEOVANNY', 'SANTOS SANTOS', '217', '0986132735', 'SI', 'esantos@movidelnor.gob.ec', NULL),
(197, 6, 2, '0401874656', 'BETTY MARISELA', 'SARMIENTO MUÃOZ', '218', '0989426185', 'SI', 'bsarmiento@movidelnor.gob.ec', NULL),
(198, 2, 2, '1003672092', 'DIEGO ARMANDO', 'SERRANO TABANGO', '219', '0985529618', 'SI', 'dserrano@movidelnor.gob.ec', NULL),
(199, 13, 2, '1003605043', 'OSCAR ANDRES', 'SEVILLANO CALDERON', '220', '0959088411', 'SI', 'osevillano@movidelnor.gob.ec', NULL),
(200, 8, 2, '0401808746', 'BYRON ANIBAL', 'SOLANO BASTIDAS', '222', '0968298897', 'SI', 'bsolano@movidelnor.gob.ec', NULL),
(201, 1, 2, '1003634126', 'JESSICA ESTEFANIA', 'SUAREZ AGUAS', '223', '0991653395', 'SI', 'jsuarez@movidelnor.gob.ec', NULL),
(202, 14, 2, '1724520752', 'JHONY JAVIER', 'SUAREZ MERA', '224', '0960609789', 'SI', 'jjsuarez@movidelnor.gob.ec', NULL),
(203, 12, 2, '1003200837', 'DARWIN ROMAN', 'SUQUILLO ENCALADA', '225', '0987382858', 'SI', 'dsuquillo@movidelnor.gob.ec', NULL),
(204, 14, 2, '1725317448', 'SEGUNDO ', 'TARAPUEZ CHAMORRO', '226', '0988154661', 'SI', 'starapuez@movidelnor.gob.ec', NULL),
(205, 5, 2, '0401613195', 'LUIS ALBERTO', 'TECA OVIEDO', '227', '0961103579', 'SI', 'lteca@movidelnor.gob.ec', NULL),
(206, 12, 2, '1723552855', 'CESAR DAVID', 'TERAN ALVAREZ', '228', '0994156590', 'SI', 'cteran@movidelnor.gob.ec', NULL),
(207, 12, 2, '1003511589', 'ALEX HUMBERTO', 'TERAN ENCALADA', '229', '0991353059', 'SI', 'ateran@movidelnor.gob.ec', NULL),
(208, 13, 2, '1003840145', 'ALVARO ISRAEL', 'TERAN FIERRO', '230', '0963750303', 'SI', 'aiteran@movidelnor.gob.ec', NULL),
(209, 8, 2, '0401736228', 'KATTY LIZETH', 'TIPAZ OBANDO', '232', '0981821550', 'SI', 'ktipaz@movidelnor.gob.ec', NULL),
(210, 1, 2, '1002730560', 'HENRY PATRICIO', 'TITO GRIJALVA', '233', '0997196250', 'SI', 'htito@movidelnor.gob.ec', NULL),
(211, 13, 2, '1003420732', 'REINALDO FRANCISCO', 'TITUAÃA CALDERON', '234', '0985437258', 'SI', 'rtituana@movidelnor.gob.ec', NULL),
(212, 12, 2, '1003333588', 'SANTIAGO EMANUEL', 'TOAPANTA MORALES', '235', '0988628313', 'SI', 'stoapanta@movidelnor.gob.ec', NULL),
(213, 14, 2, '1724672983', 'NELLY BEATRIZ', 'TOAPANTA PUJOTA', '236', '0959074873', 'SI', 'ntoapanta@movidelnor.gob.ec', NULL),
(214, 1, 2, '1003195425', 'RICHARD LEONARDO', 'TOBAR CHANDI', '237', '0986167205', 'SI', 'rtobar@movidelnor.gob.ec', NULL),
(215, 1, 2, '1003694344', 'FELIPE JOHNNY', 'TORRES CIFUENTES', '238', '0989295450', 'SI', 'ftorres@movidelnor.gob.ec', NULL),
(216, 13, 2, '1002998043', 'LUIS DARIO', 'TORRES GUAMAN', '239', '0991546482', 'SI', 'ltorres@movidelnor.gob.ec', NULL),
(217, 5, 2, '0401696588', 'VERONICA MARISOL', 'UGSHA CAISAGUANO', '240', '0969421782', 'SI', 'vugsha@movidelnor.gob.ec', NULL),
(218, 6, 2, '0401800974', 'LIZBETH KATHERINE', 'URRESTA ENRIQUEZ', '241', '0992343170', 'SI', 'lurresta@movidelnor.gob.ec', NULL),
(219, 9, 2, '1600821506', 'LIZBEL ', 'VALENCIA PASUI', '242', '0991505650', 'SI', 'lvalencia@movidelnor.gob.ec', NULL),
(220, 12, 2, '1003462353', 'JEFFERSON PAUL', 'VALENZUELA TORRES', '243', '0993727426', 'SI', 'jvalenzuela@movidelnor.gob.ec', NULL),
(221, 1, 2, '1004423008', 'JHONNY JAVIER', 'VELASCO SANCHEZ', '244', '0959830236', 'SI', 'jvelasco@movidelnor.gob.ec', NULL),
(222, 12, 2, '1003706726', 'JHON CAMILO', 'VELASCO VELASTEGUI', '245', '0995738719', 'SI', 'jcvelasco@movidelnor.gob.ec', NULL),
(223, 12, 2, '1004496566', 'ESTEBAN MIGUEL', 'VERA CARBAJAL', '247', '0958882299', 'SI', 'evera@movidelnor.gob.ec', NULL),
(224, 8, 2, '0401679022', 'EDISON SANTIAGO', 'VIANA CAICEDO', '248', '0995481075', 'SI', 'eviana@movidelnor.gob.ec', NULL),
(225, 12, 2, '1003728829', 'JUAN CARLOS', 'YACELGA RIVERA', '249', '0982290852', 'SI', 'jyacelga@movidelnor.gob.ec', NULL),
(226, 1, 2, '0401579040', 'JHONNY ALEXANDER', 'YUCAS QUIROZ', '250', '0999166802', 'SI', 'jyucas@movidelnor.gob.ec', NULL),
(227, 12, 2, '1003114343', 'VANESSA DEL ROCIO', 'ZAMBRANO DIAZ', '251', '0999373961', 'SI', 'vzambrano@movidelnor.gob.ec', NULL),
(228, 10, 2, '0850248659', 'JHON JACKSON', 'ACOSTA GARCIAS', '252', '0992239493', 'SI', 'jjacosta@movidelnor.gob.ec', NULL),
(229, 15, 2, '1003627286', 'EDWIN DAMIAN', 'ALMEIDA HARO', '253', '0982033917', 'SI', 'ealmeida@movidelnor.gob.ec', NULL),
(230, 15, 2, '1003566195', 'EDISON ANDRES', 'ALVAREZ GOMEZ', '254', '0983757507', 'SI', 'ealvarez@movidelnor.gob.ec', NULL),
(231, 15, 2, '1003467436', 'MARIA ALEXANDRA', 'ANDRAMUNIO GUITARRA', '255', '0987594502', 'SI', 'mandramunio@movidelnor.gob.ec', NULL),
(232, 12, 2, '1004359129', 'ANDERSON DARIO', 'ARAQUE QUISHPE', '256', '0997946050', 'SI', 'aaraque@movidelnor.gob.ec', NULL),
(233, 1, 2, '1003590229', 'JOHNNY ISMAEL', 'AYALA MANOSALVAS', '257', '0968678380', 'SI', 'jayala@movidelnor.gob.ec', NULL),
(234, 1, 2, '0850284506', 'LUIS EDUARDO', 'BATIOJA RIVERA', '258', '0980712719', 'SI', 'lbatioja@movidelnor.gob.ec', NULL),
(235, 12, 2, '1003433149', 'KAREN ALEJANDRA', 'BOADA ARELLANO', '259', '0959463724', 'SI', 'kboada@movidelnor.gob.ec', NULL),
(236, 14, 2, '1719491159', 'JORGE ALEXANDER', 'BUITRON GUANDINANGO', '260', '0990268725', 'SI', 'jbuitron@movidelnor.gob.ec', NULL),
(237, 15, 2, '1003611413', 'MARLON ALEXANDER', 'BUSTOS VINUEZA', '261', '0991673129', 'SI', 'mbustos@movidelnor.gob.ec', NULL),
(238, 15, 2, '1003400403', 'LENNIN DAVID', 'CABASCANGO GOMES', '262', '0967528012', 'SI', 'lcabascango@movidelnor.gob.ec', NULL),
(239, 9, 2, '1004714265', 'EDGAR JAVIER', 'CAICEDO IZQUIERDO', '265', '0994574985', 'SI', 'ecaicedo@movidelnor.gob.ec', NULL),
(240, 2, 2, '1003627617', 'KATY ELIZABETH', 'CARCELEN CARABALI', '266', '0960177057', 'SI', 'kcarcelen@movidelnor.gob.ec', NULL),
(241, 8, 2, '0401721675', 'LEANDRA KATHERINE', 'CARDENAS DORADO', '267', '0986919223', 'SI', 'lcardenas@movidelnor.gob.ec', NULL),
(242, 1, 2, '1002855433', 'MARCO FABRICIO', 'CARLOSAMA VINUEZA', '268', '0992213157', 'SI', 'mcarlosama@movidelnor.gob.ec', NULL),
(243, 12, 2, '1003606298', 'MARLON DAVID', 'CARVAJAL DEFAZ', '269', '0969002560', 'SI', 'mcarvajal@movidelnor.gob.ec', NULL),
(244, 1, 2, '1003506332', 'JUAN CARLOS', 'CASTRO PASQUEL', '270', '0990690080', 'SI', 'jcastro@movidelnor.gob.ec', NULL),
(245, 1, 2, '1003467915', 'OMAR LUCIO', 'CASTRO PERUGACHI', '271', '0985601144', 'SI', 'ocastro@movidelnor.gob.ec', NULL),
(246, 8, 2, '0401708151', 'EDISON GEOVANNY', 'CHAMORRO CUASQUER', '272', '0997692788', 'SI', 'echamorro@movidelnor.gob.ec', NULL),
(247, 9, 2, '0803014109', 'MANUEL ALBERTO', 'CHAVEZ ANGULO', '273', '0967133327', 'SI', 'mchavez@movidelnor.gob.ec', NULL),
(248, 15, 2, '1003449681', 'EDUARDO LUIS', 'CHECA MORALES', '274', '0989480102', 'SI', 'echeca@movidelnor.gob.ec', NULL),
(249, 12, 2, '1003964309', 'LUIS SANTIAGO', 'CHICAIZA BONILLA', '275', '0960179611', 'SI', 'lchicaiza@movidelnor.gob.ec', NULL),
(250, 5, 2, '0401894878', 'DAYSI ROXANA', 'CHUGA LOBATO', '276', '0997547285', 'SI', 'dchuga@movidelnor.gob.ec', NULL),
(251, 14, 2, '1003439583', 'BYRON OSWALDO', 'COLIMBA ANRANGO', '277', '0992329699', 'SI', 'bcolimba@movidelnor.gob.ec', NULL),
(252, 1, 2, '1004045967', 'GRECIA ANDREA', 'CONGO CONGO', '278', '0968178736', 'SI', 'gcongo@movidelnor.gob.ec', NULL),
(253, 15, 2, '1003201876', 'HENRY DAVID', 'CRUZ MORALES', '279', '0961708702', 'SI', 'hcruz@movidelnor.gob.ec', NULL),
(254, 9, 2, '0803895291', 'DIEGO SEBASTIAN', 'CUERO RACINES', '280', '0980464102', 'SI', 'dcuero@movidelnor.gob.ec', NULL),
(255, 2, 2, '1003256169', 'JHENIFER JOHANNA', 'DELGADO CONGO', '281', '0996724551', 'SI', 'jdelgado@movidelnor.gob.ec', NULL),
(256, 1, 2, '1003488457', 'ALEXANDER PATRICIO', 'DELGADO DELGADO', '282', '0979172336', 'SI', 'adelgado@movidelnor.gob.ec', NULL),
(257, 12, 2, '1004100127', 'CARLOS ANDRES', 'ESPINOSA ALBA', '284', '0959734076', 'SI', 'cespinosa@movidelnor.gob.ec', NULL),
(258, 1, 2, '1003167366', 'ROBERTO CARLOS', 'ESTRADA VASQUEZ', '285', '0989108915', 'SI', 'restrada@movidelnor.gob.ec', NULL),
(259, 11, 2, '0803253657', 'JULIO DEMETRIO', 'ESTUPIÃAN ORTIZ', '286', '0994545127', 'SI', 'jestupinan@movidelnor.gob.ec', NULL),
(260, 11, 2, '0804166759', 'RICHARD XAVIER', 'ESTUPIÃAN PALACIOS', '287', '0985210133', 'SI', 'restupinan@movidelnor.gob.ec', NULL),
(261, 15, 2, '1003536503', 'FRANKLIN HERNANDO', 'FLORES DIAZ', '289', '0993536744', 'SI', 'fflores@movidelnor.gob.ec', NULL),
(262, 13, 2, '1004481287', 'RICHAR OLMEDO', 'FUERTES ARTIEDA', '290', '0960999318', 'SI', 'rfuertes@movidelnor.gob.ec', NULL),
(263, 15, 2, '1002459517', 'FABIAN ISRAEL', 'GARCIA MORAN', '291', '0982571959', 'SI', 'fgarcia@movidelnor.gob.ec', NULL),
(264, 1, 2, '1003607601', 'CARLOS ANDRES', 'GOMEZ IMBAQUINGO', '292', '0960713555', 'SI', 'cgomez@movidelnor.gob.ec', NULL),
(265, 2, 2, '1003631825', 'LUIS FERNANDO', 'GRIJALVA TREJO', '293', '0990708147', 'SI', 'lgrijalva@movidelnor.gob.ec', NULL),
(266, 1, 2, '1003336060', 'KATHERINE LIZETH', 'GUDIÃO BARAHONA', '294', '0990361851', 'SI', 'kgudino@movidelnor.gob.ec', NULL),
(267, 7, 2, '0401519764', 'TROSKY GENARY', 'GUDIÃO QUISTIAL', '295', '0993593403', 'SI', 'tgudino@movidelnor.gob.ec', NULL),
(268, 1, 2, '0401746169', 'BRYAN JOSE', 'JACOME ARAUJO', '296', '0958788899', 'SI', 'bjacome@movidelnor.gob.ec', NULL),
(269, 11, 2, '0803108208', 'WALTER DANILO', 'LAÃON MEZA', '297', '0986854580', 'SI', 'wlanon@movidelnor.gob.ec', NULL),
(270, 7, 2, '0401399134', 'ELENA MARIA', 'LARA BENALCAZAR', '298', '0963958186', 'SI', 'elara@movidelnor.gob.ec', NULL),
(271, 3, 2, '1003047543', 'LUIS FRANCISCO', 'LARA QUILSIMBA', '299', '0989398756', 'SI', 'llara@movidelnor.gob.ec', NULL),
(272, 13, 2, '1002841847', 'LENIN ALEXANDER', 'LATACUMBA ANDRADE', '300', '0993388257', 'SI', 'llatacumba@movidelnor.gob.ec', NULL),
(273, 11, 2, '0803715390', 'CARLOS AUGUSTO', 'MARCHAN CORTEZ', '301', '0997717472', 'SI', 'cmarchan@movidelnor.gob.ec', NULL),
(274, 13, 2, '1003768502', 'MARJORIE FERNANDA', 'MARTINEZ PALACIOS', '302', '0963272516', 'SI', 'mmartinez@movidelnor.gob.ec', NULL),
(275, 1, 2, '1003752969', 'CARLOS ANDRES', 'MEJIA ENRIQUEZ', '303', '0995194188', 'SI', 'cmejia@movidelnor.gob.ec', NULL),
(276, 9, 2, '1004583066', 'SAMUEL ALBERTO', 'MINA HURTADO', '305', '0960168754', 'SI', 'smina@movidelnor.gob.ec', NULL),
(277, 1, 2, '1003860309', 'KLEVER ROLANDO', 'MINDA BENALCAZAR', '306', '0996671610', 'SI', 'kminda@movidelnor.gob.ec', NULL),
(278, 1, 2, '1003652920', 'ANDERSON ROBERTO', 'MINDA CHALA', '307', '0998196502', 'SI', 'aminda@movidelnor.gob.ec', NULL),
(279, 12, 2, '1003570510', 'ALEXANDER JAVIER', 'MIÃO BONILLA', '308', '0959260030', 'SI', 'amino@movidelnor.gob.ec', NULL),
(280, 13, 2, '1003827878', 'EDISON MAURICIO', 'MONTALVO CHUSIN', '309', '0997176076', 'SI', 'emontalvo@movidelnor.gob.ec', NULL),
(281, 15, 2, '1721974853', 'JAIME PAUL', 'MORALES IPIALES', '310', '0994820113', 'SI', 'jmorales@movidelnor.gob.ec', NULL),
(282, 11, 2, '0803265727', 'AIXA JANINA', 'ORTIZ DE LA CRUZ', '312', '0988042944', 'SI', 'aortiz@movidelnor.gob.ec', NULL),
(283, 1, 2, '2100495395', 'NANCY MARISELA', 'PACHECO GUAMAN', '313', '0986277010', 'SI', 'npacheco@movidelnor.gob.ec', NULL),
(284, 12, 2, '1004239164', 'SANTIAGO GABRIEL', 'PAREDES CAIZA', '315', '0985357780', 'SI', 'sparedes@movidelnor.gob.ec', NULL),
(285, 15, 2, '1003878327', 'ELSA GABRIELA', 'PERUGACHI VALVERDE', '316', '0959710119', 'SI', 'eperugachi@movidelnor.gob.ec', NULL),
(286, 14, 2, '1719490839', 'LILIAN MARLENE', 'PILA FERNANDEZ', '317', '0999555072', 'SI', 'lpila@movidelnor.gob.ec', NULL),
(287, 6, 2, '0401426853', 'BYRON XAVIER', 'POZO MELO', '318', '0999172416', 'SI', 'bpozo@movidelnor.gob.ec', NULL),
(288, 11, 2, '0803160472', 'HAROL ANTONIO', 'QUIÃONEZ ANGULO', '320', '0988503157', 'SI', 'hquinonez@movidelnor.gob.ec', NULL),
(289, 1, 2, '0401713060', 'MARTHA YOMAIRA', 'QUINTAS BENAVIDES', '321', '0993958774', 'SI', 'mquintas@movidelnor.gob.ec', NULL),
(290, 9, 2, '0802631218', 'ROGER DAVID', 'QUINTERO PRECIADO', '322', '0969346787', 'SI', 'rquintero@movidelnor.gob.ec', NULL),
(291, 15, 2, '1003600713', 'MARCO VINICIO', 'RAMIREZ PANAMA', '323', '0990022420', 'SI', 'mramirez@movidelnor.gob.ec', NULL),
(292, 3, 2, '1003818273', 'JORGE LEONARDO', 'RAMOS ANDRADE', '324', '0994475862', 'SI', 'jramos@movidelnor.gob.ec', NULL),
(293, 8, 2, '0401921846', 'JHON MIGUEL', 'REYES NAVARRETE', '325', '0987860970', 'SI', 'jreyes@movidelnor.gob.ec', NULL),
(294, 10, 2, '0803374362', 'EDDY SANTIAGO', 'RODRIGUEZ BAEZ', '326', '0959649509', 'SI', 'esrodriguez@movidelnor.gob.ec', NULL),
(295, 4, 2, '0401799598', 'ERIK DAVID', 'RODRIGUEZ POZO', '327', '0997944287', 'SI', 'edrodriguez@movidelnor.gob.ec', NULL),
(296, 1, 2, '1003338504', 'LUIS CARLOS', 'ROMERO REVELO', '328', '0991823950', 'SI', 'lcromero@movidelnor.gob.ec', NULL),
(297, 12, 2, '1004552327', 'KLEVER RICARDO', 'ROMERO YACELGA', '329', '0967489546', 'SI', 'kromero@movidelnor.gob.ec', NULL),
(298, 13, 2, '1002974408', 'DAVID ALEXANDER', 'SALGADO ZAPATA', '331', '0990477885', 'SI', 'dsalgado@movidelnor.gob.ec', NULL),
(299, 10, 2, '0802769430', 'EDWIN JHONNY', 'SEGURA FARIAS', '332', '0988032713', 'SI', 'esegura@movidelnor.gob.ec', NULL),
(300, 9, 2, '1004134027', 'LUIS ANDERSON', 'SOLORZANO MEDINA', '333', '0996754709', 'SI', 'lsolorzano@movidelnor.gob.ec', NULL),
(301, 13, 2, '0922768239', 'ABEL MAURICIO', 'SUAREZ TOMALA', '334', '0939925459', 'SI', 'asuarez@movidelnor.gob.ec', NULL),
(302, 4, 2, '1003631304', 'CARLOS JAVIER', 'TANICUCHI ROJAS', '335', '0994854102', 'SI', 'ctanicuchi@movidelnor.gob.ec', NULL),
(303, 11, 2, '0803179035', 'MARIA ELIZABETH', 'TELLO DE LA CRUZ', '336', '0997727598', 'SI', 'mtello@movidelnor.gob.ec', NULL),
(304, 15, 2, '1003609516', 'LUIS RICARDO', 'TERAN VACA', '337', '0993489172', 'SI', 'lteran@movidelnor.gob.ec', NULL),
(305, 1, 2, '1721059978', 'BYRON JOSE', 'TORRES SINALUISA', '338', '0991544400', 'SI', 'btorres@movidelnor.gob.ec', NULL),
(306, 5, 2, '0401666912', 'WALTER MARCELO', 'VACA YALAMA', '339', '0997562107', 'SI', 'wvaca@movidelnor.gob.ec', NULL),
(307, 15, 2, '1003567003', 'JHON JAIRO', 'VALENCIA GUERRERO', '340', '0991482079', 'SI', 'jjvalencia@movidelnor.gob.ec', NULL),
(308, 10, 2, '0802769380', 'CRISTHIAN EULISER', 'VALENCIA HURTADO', '341', '0960242384', 'SI', 'cvalencia@movidelnor.gob.ec', NULL),
(309, 12, 2, '1004028781', 'MARIA ESTEFANIA', 'VERA CARVAJAL', '342', '0985080565', 'SI', 'mvera@movidelnor.gob.ec', NULL),
(310, 5, 2, '0401702956', 'DANIELA ALEJANDRA', 'VERA VILLAVICENCIO', '343', '0997565391', 'SI', 'dvera@movidelnor.gob.ec ', NULL),
(311, 15, 2, '1003671474', 'DARWIN JAVIER', 'VILLALBA ENRIQUEZ', '344', '0983804865', 'SI', 'dvillalba@movidelnor.gob.ec', NULL),
(312, 8, 2, '0401840715', 'DARWIN VINICIO', 'VILLOTA REASCOS', '345', '0991320940', 'SI', 'dvillota@movidelnor.gob.ec', NULL),
(313, 15, 2, '1003170485', 'LUIS ALEXANDER', 'VINUEZA SIMBAÃA', '346', '0979059284', 'SI', 'lvinueza@movidelnor.gob.ec', NULL),
(314, 15, 2, '1003604152', 'JEFFERSON EDUARDO', 'YACELGA YACELGA', '347', '0980284824', 'SI', 'jeyacelga@movidelnor.gob.ec', NULL),
(315, 1, 2, '1804009668', 'NORMA MARICELA', 'GAVILANES ANALUISA', '348', '0964157270', 'SI', 'ngavilanes@movidelnor.gob.ec', NULL),
(316, 1, 2, '1802691996', 'SUSANA DOLORES', 'CONSTANTE ABRIL', '349', '0987363924', 'SI', 'sconstante@movidelnor.gob.ec', NULL),
(317, 1, 2, '1003416946', 'MARCIA GABRIELA', 'GUERRA MARCILLO', '350', '0989286598', 'SI', 'mguerra@movidelnor.gob.ec', NULL),
(318, 15, 2, '1315639904', 'DELIAN GEOVANNY', 'ALCIVAR ZAMBRANO', '353', '0989881053', 'SI', 'dalcivar@movidelnor.gob.ec', NULL),
(319, 1, 2, '1003614060', 'JOSE LUIS', 'ALMEIDA GUERRA', '354', '0997850593', 'SI', 'jalmeida@movidelnor.gob.ec', NULL),
(320, 1, 2, '1003404041', 'JUAN CARLOS', 'ALVAREZ GONZALEZ', '355', '0986320902', 'SI', 'jalvarez@movidelnor.gob.ec', NULL),
(321, 12, 2, '1003946660', 'BRAYAN JAVIER', 'ANDRADE VACA', '357', '0958917228', 'SI', 'bandrade@movidelnor.gob.ec', NULL),
(322, 15, 2, '1004114284', 'ALEXANDER DANIEL', 'ANDRAMUNIO GALINDO', '358', '0961707681', 'SI', 'aandramunio@movidelnor.gob.ec', NULL),
(323, 2, 2, '1003716477', 'MARIA ISABEL', 'ANRANGO GUNCHA', '359', '0967984476', 'SI', 'manrango@movidelnor.gob.ec', NULL),
(324, 1, 2, '1003853882', 'DANIEL SANTIAGO', 'ANRRANGO BONILLA', '360', '0980253610', 'SI', 'danrrango@movidelnor.gob.ec', NULL),
(325, 9, 2, '0803916535', 'ALEXANDER ', 'ARTEAGA CAICEDO', '362', '0994221503', 'SI', 'aarteaga@movidelnor.gob.ec', NULL),
(326, 12, 2, '1003888995', 'DARIO FERNANDO', 'ASTUDILLO SANCHEZ', '363', '0961802141', 'SI', 'dastudillo@movidelnor.gob.ec', NULL),
(327, 1, 2, '1004702633', 'JONATHAN ANDRES', 'AVILA MUÃOZ', '364', '0958846748', 'SI', 'javila@movidelnor.gob.ec', NULL),
(328, 1, 2, '1003408299', 'JOSELIN FABIOLA', 'BADILLO GONZALEZ', '366', '0982901140', 'SI', 'jbadillo@movidelnor.gob.ec', NULL),
(329, 1, 2, '1003855473', 'BAYRON GABRIEL', 'BARRAGAN VALLES', '367', '0999618220', 'SI', 'bbarragan@movidelnor.gob.ec', NULL),
(330, 15, 2, '1724881808', 'VICTOR PASCUAL', 'BERMUDEZ MERA', '370', '0999453432', 'SI', 'vbermudez@movidelnor.gob.ec', NULL),
(331, 1, 2, '0401688106', 'JHON JAIRO', 'CADENA JIMENEZ', '374', '0982502571', 'SI', 'jcadena@movidelnor.gob.ec', NULL),
(332, 9, 2, '0803522085', 'CRISTIAN MIGUEL', 'CAICEDO COROZO', '375', '0986268862', 'SI', 'cmcaicedo@movidelnor.gob.ec', NULL),
(333, 10, 2, '1004484497', 'EDUARDO DANIEL', 'CAICEDO ROSERO', '376', '0993513127', 'SI', 'edcaicedo@movidelnor.gob.ec', NULL),
(334, 13, 2, '1003517461', 'WILSON SANTIAGO', 'CALDERON MONTALVO', '378', '0980077868', 'SI', 'wscalderon@movidelnor.gob.ec', NULL),
(335, 13, 2, '1724547755', 'ANDREA JOHANNA', 'CALDERON VERGARA', '379', '0984718337', 'SI', 'ajcalderon@movidelnor.gob.ec', NULL),
(336, 1, 2, '1003591573', 'JENIFFER ABIGAIL', 'CAMPOS CHALA', '380', '0981400725', 'SI', 'jcampos@movidelnor.gob.ec', NULL),
(337, 1, 2, '1003057286', 'DANIELA MICHELLE', 'CARRERA SEVILLA', '382', '0997111337', 'SI', 'dcarrera@movidelnor.gob.ec', NULL),
(338, 12, 2, '1004204895', 'CINTHIA GABRIELA', 'CARRILLO PASTILLO', '383', '0983226508', 'SI', 'ccarrillo@movidelnor.gob.ec', NULL),
(339, 11, 2, '2300670987', '', 'CASTILLO AREVALO', '384', '0989775300', 'SI', 'jcastillo@movidelnor.gob.ec', NULL),
(340, 12, 2, '1003434063', 'DANILO XAVIER', 'CATUCUAMBA DE LA TORRE', '385', '0992213648', 'SI', 'dcatucuamba@movidelnor.gob.ec', NULL),
(341, 12, 2, '1004687198', 'CRISTIAN EFRAIN', 'CHACON VALENCIA', '387', '0961277850', 'SI', 'cchacon@movidelnor.gob.ec', NULL),
(342, 1, 2, '1004817803', 'MARIA SALOME', 'CHALA ACOSTA', '388', '0988629263', 'SI', 'mchala@movidelnor.gob.ec', NULL),
(343, 2, 2, '1004801765', 'ARMANDO GABRIEL', 'CHIQUITO MALTE', '391', '0999502816', 'SI', 'achiquito@movidelnor.gob.ec', NULL),
(344, 1, 2, '1003780788', 'CRISTIAN GEOVANNI', 'CHISAGUANO TERCERO', '392', '0979677322', 'SI', 'cchisaguano@movidelnor.gob.ec', NULL),
(345, 9, 2, '0803912534', 'FRANCISCO JESID', 'CIFUENTES GALLO', '393', '0969376529', 'SI', 'fcifuentes@movidelnor.gob.ec', NULL),
(346, 1, 2, '1004478564', 'EMILY GERALDYNE', 'COLIMBA COLLAGUAZO', '394', '0986047214', 'SI', 'ecolimba@movidelnor.gob.ec', NULL),
(347, 1, 2, '1003836119', 'SEGUNDO LEONIDAS', 'COLIMBA QUISHPE', '395', '0968176954', 'SI', 'scolimba@movidelnor.gob.ec', NULL),
(348, 1, 2, '1003624424', 'LEYNER ALDAIR', 'CONGO CARCELEN', '397', '0978969066', 'SI', 'lcongo@movidelnor.gob.ec', NULL),
(349, 1, 2, '1003941208', 'CARLOS ANDRES', 'CONGO MINA', '399', '0991552469', 'SI', 'ccongo@movidelnor.gob.ec', NULL),
(350, 10, 2, '1004139745', 'DIEGO ALEJANDRO', 'COROZO QUINTERO', '401', '0959630204', 'SI', 'dcorozo@movidelnor.gob.ec', NULL),
(351, 1, 2, '1003209556', 'JEFFERSON RAUL', 'CORTES GUARAMAG', '402', '0995214498', 'SI', 'jcortes@movidelnor.gob.ec', NULL),
(352, 1, 2, '1003389069', 'TAMARA LISBETH', 'CONGO CONGO', '403', '0997485960', 'SI', 'tcongo@movidelnor.gob.ec', NULL),
(353, 1, 2, '1004448419', 'MISHELL ESTEFANIA', 'MONTENEGRO MORALES', '404', '0995841195', 'SI', 'memontenegro@movidelnor.gob.ec', NULL),
(354, 1, 2, '1003892856', 'ALVARO ROLANDO', 'DE JESUS BARAHONA', '406', '0999013927', 'SI', 'adejesus@movidelnor.gob.ec', NULL),
(355, 13, 2, '1803737970', 'JORGE LUIS', 'DE JESUS QUINTANA', '407', '0987968533', 'SI', 'jdejesus@movidelnor.gob.ec', NULL),
(356, 11, 2, '0803995083', 'ELDER LENIN', 'DELGADO MONTAÃO', '409', '0989332234', 'SI', 'eldelgado@movidelnor.gob.ec', NULL),
(357, 1, 2, '1003890314', 'ELIANA GABRIELA', 'DELGADO PEREZ', '410', '0959492206', 'SI', 'edelgado@movidelnor.gob.ec', NULL),
(358, 1, 2, '1003680962', 'RICHARD JAVIER', 'ENRIQUEZ CARVAJAL', '411', '0992424844', 'SI', 'renriquez@movidelnor.gob.ec', NULL),
(359, 1, 2, '0803318849', 'CANDI LORENA', 'ESPAÃA KLINGER', '413', '0991026382', 'SI', 'cespana@movidelnor.gob.ec', NULL),
(360, 1, 2, '1004337042', 'KEVIN ANDERSON', 'ESPINOSA POZO', '414', '0979486964', 'SI', 'kespinosa@movidelnor.gob.ec', NULL),
(361, 15, 2, '0804325066', 'GABRIEL ENRIQUE', 'ESPINOZA ALCIVAR', '415', '0959019537', 'SI', 'gespinoza@movidelnor.gob.ec', NULL),
(362, 15, 2, '1003552153', 'JONATHAN ESTUARDO', 'ESPINOZA ECHEVERRIA', '416', '0996332376', 'SI', 'jespinoza@movidelnor.gob.ec', NULL),
(363, 1, 2, '1003855317', 'IORDAN IVAN', 'ESPINOZA GARCIA', '417', '0993633587', 'SI', 'iespinoza@movidelnor.gob.ec', NULL),
(364, 10, 2, '0803264175', 'LUIS MIGUEL', 'ESPINOZA RAMIREZ', '418', '0991572754', 'SI', 'lespinoza@movidelnor.gob.ec', NULL),
(365, 11, 2, '0804163830', 'JEAN EDUARDO', 'ESTUPIÃAN PALACIOS', '419', '0986006528', 'SI', 'jeestupinan@movidelnor.gob.ec', NULL),
(366, 3, 2, '1003321013', 'PAMELA ALEXANDRA', 'FELIX HORMAZA', '420', '0062606922', 'SI', 'pfelix@movidelnor.gob.ec', NULL),
(367, 1, 2, '1003860333', 'JOHN ALEJANDRO', 'FLORES ORTEGA', '424', '0987342837', 'SI', 'jflores@movidelnor.gob.ec', NULL),
(368, 1, 2, '1003869839', 'JEFFERSON PAUL', 'FUEL MEJIA', '425', '0998906901', 'SI', 'jfuel@movidelnor.gob.ec', NULL),
(369, 1, 2, '1003892286', 'MISHEL VERONICA', 'GARCIA DELGADO', '427', '0961014481', 'SI', 'mgarcia@movidelnor.gob.ec', NULL),
(370, 2, 2, '1004502165', 'RICHARD ESTEBAN', 'GARCIA LANDAZURI', '428', '0939669026', 'SI', 'rgarcia@movidelnor.gob.ec', NULL),
(371, 1, 2, '1003390232', 'MARIA VICTORIA', 'GONZALEZ FLORES', '430', '0992701336', 'SI', 'mgonzalez@movidelnor.gob.ec', NULL),
(372, 1, 2, '1718671025', 'RONALD ANDRES', 'GONZALON GONZALON', '431', '0969594285', 'SI', 'rgonzalon@movidelnor.gob.ec', NULL),
(373, 1, 2, '1003981477', 'SEGUNDO ISRAEL', 'GRIJALVA LANCHIMBA', '432', '0967209363', 'SI', 'sgrijalva@movidelnor.gob.ec', NULL),
(374, 10, 2, '0804178663', 'DARIO ENRIQUE', 'GRUEZO CASIERRA', '433', '0988579120', 'SI', 'dgruezo@movidelnor.gob.ec', NULL),
(375, 1, 2, '1003400841', 'EMERSON SAUL', 'GUALACATA RODRIGUEZ', '434', '0997876376', 'SI', 'egualacata@movidelnor.gob.ec', NULL),
(376, 15, 2, '1003650965', 'ALEXANDER FAUSTO', 'GUALSAQUI ARIAS', '435', '0997601734', 'SI', 'agualsaqui@movidelnor.gob.ec', NULL),
(377, 15, 2, '1003528351', 'DENNIS EFREN', 'GUERRA CONDE', '437', '0958970128', 'SI', 'deguerra@movidelnor.gob.ec', NULL),
(378, 15, 2, '1004468664', 'SEGUNDO DARWIN', 'GUERRERO SALAZAR', '438', '0993391824', 'SI', 'sguerrero@movidelnor.gob.ec', NULL),
(379, 1, 2, '1004671184', 'KATHERINE MARIBEL', 'HEREMBAS MORILLO', '439', '0982788597', 'SI', 'kherembas@movidelnor.gob.ec', NULL),
(380, 1, 2, '1003974894', 'CRISTIAN FABRICIO', 'HERNANDEZ ENRIQUEZ', '440', '0990280626', 'SI', 'chernandez@movidelnor.gob.ec', NULL),
(381, 12, 2, '1004513816', 'HECTOR DAVID', 'HIDROBO CIGUENCIA', '441', '0992945781', 'SI', 'hhidrobo@movidelnor.gob.ec', NULL),
(382, 13, 2, '1004086235', 'BYRON EDUARDO', 'IBADANGO ANICETE', '442', '0996833020', 'SI', 'bibadango@movidelnor.gob.ec', NULL),
(383, 1, 2, '0402039812', 'KEVIN SEBASTIAN', 'JACOME ARAUJO', '443', '0985600217', 'SI', 'ksjacome@movidelnor.gob.ec', NULL),
(384, 2, 2, '1003812391', 'OSCAR GIOVANNI', 'JUMA CAMPUES', '445', '0961261924', 'SI', 'ojuma@movidelnor.gob.ec', NULL),
(385, 1, 2, '1003865118', 'BLASCO FABRICIO', 'LARA AGUAS', '447', '0939037563', 'SI', 'blara@movidelnor.gob.ec', NULL),
(386, 3, 2, '1004055644', 'CRISTIAN ANDRES', 'LARA RECALDE', '450', '0994991747', 'SI', 'clara@movidelnor.gob.ec', NULL),
(387, 11, 2, '0804106268', 'KEVIN NIXON', 'LEON URBANO', '452', '0997268053', 'SI', 'kleon@movidelnor.gob.ec', NULL),
(388, 9, 2, '0850042763', 'JEISON ALFONSO', 'LERMA QUIÃONEZ', '453', '0989932337', 'SI', 'jlerma@movidelnor.gob.ec', NULL),
(389, 1, 2, '1004707095', 'BRYAN XAVIER', 'MAFLA ROJAS', '454', '0098754803', 'SI', 'bmafla@movidelnor.gob.ec', NULL),
(390, 1, 2, '1003182001', 'ERICK JAVIER', 'MALPUD COLLAGUAZO', '455', '0994887301', 'SI', 'emalpud@movidelnor.gob.ec', NULL),
(391, 1, 2, '1003612262', 'EDITH CRISTINA', 'MANTECA NATUTA', '456', '0999554063', 'SI', 'emanteca@movidelnor.gob.ec', NULL),
(392, 10, 2, '0804431419', 'JOSE CARLOS', 'MARQUEZ VIVERO', '457', '0981379509', 'SI', 'jmarquez@movidelnor.gob.ec', NULL),
(393, 10, 2, '0803235977', 'MISHELL SOANY', 'MARRETT ZAMORA', '458', '0959225617', 'SI', 'mmarrett@movidelnor.gob.ec', NULL),
(394, 9, 2, '0850340233', 'DAMARIS GUILIS', 'MARTINEZ VEGA', '459', '0989431938', 'SI', 'dmartinez@movidelnor.gob.ec', NULL),
(395, 12, 2, '1004490445', 'CATERINE LISBET', 'MAYGUA MORALES', '460', '0964135565', 'SI', 'cmaygua@movidelnor.gob.ec', NULL),
(396, 10, 2, '0803678473', 'CARLOS ALFREDO', 'MERA DIAZ', '462', '0985363123', 'SI', 'cmera@movidelnor.gob.ec', NULL),
(397, 13, 2, '1003423397', 'JONNY PATRICIO', 'MESIAS ZULETA', '463', '0997714129', 'SI', 'jmesias@movidelnor.gob.ec', NULL),
(398, 10, 2, '0802768515', 'ANTONIO ALEJANDRO', 'MEZA BURGOS', '464', '0992152576', 'SI', 'ameza@movidelnor.gob.ec', NULL),
(399, 1, 2, '1004391213', 'ESTEFANIA VERONICA', 'MINA CHALA', '465', '0991590504', 'SI', 'evmina@movidelnor.gob.ec', NULL),
(400, 1, 2, '1003807029', 'GRACE CAROLINA', 'MINA CHISCUET', '466', '0960290952', 'SI', 'gmina@movidelnor.gob.ec', NULL),
(401, 1, 2, '1003933874', 'JOHN RICHARD', 'MINA PIÃEIROS', '467', '0997419038', 'SI', 'jmina@movidelnor.gob.ec', NULL),
(402, 1, 2, '1003216189', 'SILVANA GABRIELA', 'MINDA LOPEZ', '468', '0979277646', 'SI', 'sminda@movidelnor.gob.ec', NULL),
(403, 1, 2, '1003741624', 'LENIN FABIAN', 'MOLINA CAZARES', '470', '0961440851', 'SI', 'lmolina@movidelnor.gob.ec', NULL);
INSERT INTO `personas` (`ID_PERSONA`, `ID_DISTRITO_AGENTE`, `ID_FUNCION`, `CEDULA`, `NOMBRES`, `APELLIDOS`, `CODIGO_AGENTE`, `TELEFONO_AGENTE`, `AGENTE`, `EMAIL`, `ID_GRUPO_OPERATIVO`) VALUES
(404, 1, 2, '1003750856', 'CRISTIAN DANIEL', 'MONROY VASQUEZ', '471', '0987336618', 'SI', 'cmonroy@movidelnor.gob.ec', NULL),
(405, 2, 2, '1003558747', 'JOSELINE DANIELA', 'MONTENEGRO JOJOA', '472', '0939285737', 'SI', 'jmontenegro@movidelnor.gob.ec', NULL),
(406, 1, 2, '1003797394', 'CRISTIAN PAUL', 'MONTESDEOCA CHAGLLA', '474', '0984090197', 'SI', 'cmontesdeoca@movidelnor.gob.ec', NULL),
(407, 1, 2, '1003402144', 'DARWIN XAVIER', 'MORENO SOTO', '477', '0979282022', 'SI', 'dmoreno@movidelnor.gob.ec', NULL),
(408, 12, 2, '1722889399', 'LILIAN RAQUEL', 'MORENO TITUAÃA', '478', '0986016358', 'SI', 'lmoreno@movidelnor.gob.ec', NULL),
(409, 1, 2, '1003937818', 'ANDREA MARIELA', 'MORILLO HURTADO', '479', '0991456742', 'SI', 'amorillo@movidelnor.gob.ec', NULL),
(410, 1, 2, '1003614219', 'KATHERINE VERONICA', 'NAVARRO SUAREZ', '482', '0958990272', 'SI', 'knavarro@movidelnor.gob.ec', NULL),
(411, 10, 2, '1004549588', 'WAGNER JERRY', 'NAZARENO ORTIZ', '483', '0991492644', 'SI', 'wnazareno@movidelnor.gob.ec', NULL),
(412, 9, 2, '0804155935', 'MARTHA MARINA', 'OLEAS MOSQUERA', '484', '0979566685', 'SI', 'moleas@movidelnor.gob.ec', NULL),
(413, 11, 2, '0802386193', 'ERICKSON ALEXANDER', 'OLMEDO CORTEZ', '485', '0997301259', 'SI', 'eolmedo@movidelnor.gob.ec', NULL),
(414, 1, 2, '1003807102', 'JENNYFER ALEJANDRA', 'PABON CONGO', '487', '0959846804', 'SI', 'jpabon@movidelnor.gob.ec', NULL),
(415, 1, 2, '1003847595', 'JONATHAN ALEXANDER', 'PABON PONCE', '488', '0989145974', 'SI', 'japabon@movidelnor.gob.ec', NULL),
(416, 12, 2, '1003508510', 'JONATHAN ANDRES', 'PADILLA MINA', '489', '0963056342', 'SI', 'jpadilla@movidelnor.gob.ec', NULL),
(417, 1, 2, '1003679683', 'MARIA DOLORES', 'PADILLA QUIÃALUISA', '490', '0979856813', 'SI', 'mpadilla@movidelnor.gob.ec', NULL),
(418, 6, 2, '0402001713', 'ROBINSON OSWALDO', 'PAILLACHO PAILLACHO', '492', '0939657065', 'SI', 'rpaillacho@movidelnor.gob.ec', NULL),
(419, 13, 2, '1004830368', 'JESSICA VANESSA', 'PASTRANA IMBAQUINGO', '497', '0980516621', 'SI', 'jvpastrana@movidelnor.gob.ec', NULL),
(420, 12, 2, '1003777412', 'MARCO VINICIO', 'PICUASI TITUAÃA', '500', '0981705716', 'SI', 'mpicuasi@movidelnor.gob.ec', NULL),
(421, 1, 2, '1003783592', 'WILLIAM ORLANDO', 'PINTO AYALA', '501', '0984074469', 'SI', 'wpinto@movidelnor.gob.ec', NULL),
(422, 1, 2, '1003520564', 'BYRON ANDRES', 'PLACENCIA AYALA', '502', '0986205669', 'SI', 'bplacencia@movidelnor.gob.ec', NULL),
(423, 10, 2, '0803513829', 'CARLOS EDUARDO', 'PORTOCARRERO BAUSTISTA', '504', '0989205823', 'SI', 'cportocarrero@movidelnor.gob.ec', NULL),
(424, 1, 2, '1002837050', 'GLORIA EDERMIRA', 'PUPIALES SANDOVAL', '509', '0991392396', 'SI', 'gpupiales@movidelnor.gob.ec', NULL),
(425, 1, 2, '1003853551', 'JORGE EDUARDO', 'QUELAL ALMEIDA', '510', '0999754745', 'SI', 'jquelal@movidelnor.gob.ec', NULL),
(426, 1, 2, '1724785405', 'MARCO XAVIER', 'QUEREMBAS ALVAREZ', '512', '0983078528', 'SI', 'mquerembas@movidelnor.gob.ec', NULL),
(427, 10, 2, '0803800085', 'TARQUINO JAVIER', 'QUIÃONEZ ANGULO', '513', '0988633577', 'SI', 'tquinonez@movidelnor.gob.ec', NULL),
(428, 10, 2, '0803791680', 'CARLOS RAMIRO', 'QUIÃONEZ BATALLA', '514', '0968366733', 'SI', 'cquinonez@movidelnor.gob.ec', NULL),
(429, 9, 2, '0850914482', 'FRICKSON ALEXIS', 'QUIÃONEZ QUIÃONEZ', '515', '0993114891', 'SI', 'fquinonez@movidelnor.gob.ec', NULL),
(430, 6, 2, '0401897707', 'ERIKA PAOLA', 'RAMIREZ REVELO', '516', '0990197376', 'SI', 'eramirez@movidelnor.gob.ec', NULL),
(431, 3, 2, '1003437868', 'EDISON PATRICIO', 'RIVADENEIRA CRUZ', '520', '0991788160', 'SI', 'erivadeneira@movidelnor.gob.ec', NULL),
(432, 6, 2, '0401806385', 'ANDERSON FABRICIO', 'RIVERA PASPUEL', '521', '0979966345', 'SI', 'arivera@movidelnor.gob.ec', NULL),
(433, 1, 2, '1600591026', 'JOHNNY ALEXANDER', 'RODRIGUEZ PATIÃO', '522', '0993999375', 'SI', 'jrodriguez@movidelnor.gob.ec', NULL),
(434, 10, 2, '0803791284', 'JEFERSON ANDRES', 'RODRIGUEZ QUIÃONEZ', '523', '0959040675', 'SI', 'jarodriguez@movidelnor.gob.ec', NULL),
(435, 1, 2, '1003822978', 'PAUL DAVID', 'ROSAS CADENA', '524', '0993385508', 'SI', 'prosas@movidelnor.gob.ec', NULL),
(436, 10, 2, '0803965490', 'JOSE ANDRES', 'SANCHEZ ESPAÃA', '527', '0991227041', 'SI', 'jasanchez@movidelnor.gob.ec', NULL),
(437, 13, 2, '1004015788', 'CARLOS ANDRES', 'SAILEMA BOLAÃOS', '528', '0986655412', 'SI', 'csailema@movidelnor.gob.ec', NULL),
(438, 11, 2, '0850072687', 'PRISCILA ALEXANDRA', 'SALAZAR OREJUELA', '530', '0968294508', 'SI', 'pasalazar@movidelnor.gob.ec', NULL),
(439, 12, 2, '1003665021', 'CRISTIAN FREDDY', 'SANCHEZ VACA', '531', '0995937583', 'SI', 'csanchez@movidelnor.gob.ec', NULL),
(440, 1, 2, '1004173462', 'WHIMPER ISRAEL', 'SANDOVAL BASTIDAS', '532', '0960177366', 'SI', 'wsandoval@movidelnor.gob.ec', NULL),
(441, 11, 2, '0804582138', 'BRYAN FERNANDO', 'SANMARTIN BUENO', '533', '0992282773', 'SI', 'bsanmartin@movidelnor.gob.ec', NULL),
(442, 15, 2, '1004156848', 'CARLOS SEBASTIAN', 'TAMBACO GUANDINANGO', '535', '0994043997', 'SI', 'ctambaco@movidelnor.gob.ec', NULL),
(443, 2, 2, '1003800362', 'WINSTON ALEXANDER', 'TAPIA FARINANGO', '536', '0990628720', 'SI', 'wtapia@movidelnor.gob.ec', NULL),
(444, 1, 2, '0705948222', 'GINA LISSETH', 'TERAN VEGA', '538', '0985608046', 'SI', 'gteran@movidelnor.gob.ec', NULL),
(445, 1, 2, '1003110101', 'PATRICIO BLADIMIR', 'TIGSE MORENO', '539', '0982129342', 'SI', 'ptigse@movidelnor.gob.ec', NULL),
(446, 1, 2, '1003639778', 'MILTON SANTIAGO', 'TOMAICO VASQUEZ', '540', '0969078724', 'SI', 'mtomaico@movidelnor.gob.ec', NULL),
(447, 15, 2, '1004001523', 'RONNY MIGUEL', 'TROYA SARZOSA', '541', '0986706360', 'SI', 'rtroya@movidelnor.gob.ec', NULL),
(448, 1, 2, '1004535777', 'EDISON SANTIAGO', 'TULCAN NEJER', '542', '0967397024', 'SI', 'etulcan@movidelnor.gob.ec', NULL),
(449, 12, 2, '1003456710', 'DIANA ESTEFANIA', 'TULCANAZA MORENO', '543', '0960773446', 'SI', 'dtulcanaza@movidelnor.gob.ec', NULL),
(450, 15, 2, '1003602230', 'CRISTIAN MAURICIO', 'TUPIZA QUILCA', '544', '0980665774', 'SI', 'ctupiza@movidelnor.gob.ec', NULL),
(451, 15, 2, '1003602214', 'LUIS JOSE', 'TUPIZA QUILCA', '545', '0959110425', 'SI', 'ltupiza@movidelnor.gob.ec', NULL),
(452, 1, 2, '1004190193', 'FATIMA ALEXANDRA', 'TUZA TUZA', '547', '0982512397', 'SI', 'ftuza@movidelnor.gob.ec', NULL),
(453, 1, 2, '1003401252', 'LUIS MIGUEL', 'UBIDIA TENECELA', '548', '0994866090', 'SI', 'lubidia@movidelnor.gob.ec', NULL),
(454, 6, 2, '0401861331', 'MARLON DAVID', 'URRESTA BENAVIDES', '549', '0981629006', 'SI', 'murresta@movidelnor.gob.ec', NULL),
(455, 10, 2, '0804398899', 'OLGER ', 'VALENCIA AYOVI', '550', '0989317457', 'SI', 'ovalencia@movidelnor.gob.ec', NULL),
(456, 1, 2, '1003416557', 'BRYAN STALIN', 'VALENCIA VINUEZA', '551', '0962686226', 'SI', 'bvalencia@movidelnor.gob.ec', NULL),
(457, 11, 2, '1727213637', 'EVELIN NATHALY', 'VELIZ LOAIZA', '554', '0989639862', 'SI', 'eveliz@movidelnor.gob.ec', NULL),
(458, 1, 2, '1400759351', 'DENISSE THAMARA', 'VICUÃA ROJAS', '555', '0984130386', 'SI', 'dvicuna@movidelnor.gob.ec', NULL),
(459, 1, 2, '1003890579', 'DEISY GABRIELA', 'VILLALVA BORJA', '556', '0996030613', 'SI', 'dvillalva@movidelnor.gob.ec', NULL),
(460, 6, 2, '0401636295', 'SANTIAGO ALEXANDER', 'VILLARREAL NAZATE', '557', '0981614776', 'SI', 'avillarreal@movidelnor.gob.ec', NULL),
(461, 13, 2, '1719088682', 'DAYANA SALOME', 'VITERI GARCIA', '558', '0959853851', 'SI', 'dviteri@movidelnor.gob.ec', NULL),
(462, 9, 2, '0804643542', 'VIRGILIO VICENTE', 'VIVERO CHARCOPA', '560', '0980911990', 'SI', 'vvivero@movidelnor.gob.ec', NULL),
(463, 13, 2, '1003591888', 'JOSE GERMANICO', 'RUIZ ARIAS', '565', '0993276831', 'SI', 'jgruiz@movidelnor.gob.ec', NULL);

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
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5uQn2GNZsfuDqv8N8JYB2uHyqY6Ugvo3dJfIq8oo', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTFRKbW9kUnVueGpYZnZEaTlNQlBjazZ5amwwbVhmZDIxQ01GQjlPbyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0OToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL29zZ28vb3JkZW4tc2VydmljaW9zL2NyZWF0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvb3Nnby9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757702679),
('7s42VuzzqMHEJ8j4Y5naUGMRNkoRayJdWOLyfWSG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaDFVN3Nyb0MxNjdXa2hFaGphVXpPdU9MS3BIdTF1WElxczV0MXpPNSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL29zZ28vb3JkZW4tc2VydmljaW9zIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9vc2dvL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1757709552),
('9u12MBUeabuD4ELXOA8YHEDrq340Z54KevOq6ms2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMzZZMVJybGptSzliVXVUVDMxb1V3eWRybjJlNVlCdEFuZUVkV252dCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL29zZ28iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL29zZ28vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1757709414),
('9xSLboBCuuSgzBoag3uUDpIlok7HIYsmVIrBHROV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicEtsSHVmMUo2TnFob29ucnBMaTlka2NsSHRKT3JQTWVKbUEybXdDSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757709360),
('GCMd13h1xBQTRiWuvwP6q892325eEFQx3LuCP39F', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmpSRXBZZzJNQkRtZWk5T3JGc0tLSnFJbFBKdGlMamhmTGk2b2FCYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757709428),
('JTfCbFUlFHwOqCBzROHXH68pa8VxpTGNWB2fS5ne', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRUFxZ1FuNXRPZ0ZuQkFzVGI2TU1ja256eEt0cVZMZnZlanlYT2g5NSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0OToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL29zZ28vb3JkZW4tc2VydmljaW9zL2NyZWF0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvb3Nnby9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757702614),
('OeLwLV3eNwhcLJ16p8QBwhpTkyBLtNZQD96WaKCD', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUHVZaWo1eXNJRWpwVmJaekJnQ0VFdldsNmY1RnVYaVVGSmdOWjZMNCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvb3Nnby9vcmRlbi1zZXJ2aWNpb3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkUkJjRVN6bzZaOGVRbFhyWDhuZU91T3BxYllYL2JOcEI0WEhuM0RQOWp3dmhTTDJRV0JHdGUiO30=', 1757709505),
('peTgnHicIUY0FeegNwbRZZQg5oEAQl9ePHMV6IH3', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiNmtUSTR4eG5wdHJkeVpYU09jM2RidFFDUExmbTlhZ3ByaHhYdnAwWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9vc2dvL29yZGVuLXNlcnZpY2lvcy9jcmVhdGU/c3RlcD1vcmRlbi1kZS1zZXJ2aWNpbyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjM7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRSQmNFU3pvNlo4ZVFsWHJYOG5lT3VPcHFiWVgvYk5wQjRYSG4zRFA5and2aFNMMlFXQkd0ZSI7fQ==', 1757627812),
('PsxNgMkb75ZcmqkRN5IofGNXKVD8aJufwGquFXxR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUxwWUZUa05FNUlIYlJyWk0xeE9hTmI2YlYyam5zdXo2NXdaamlRcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757709397),
('tzrrhxJarhT8QMEyAaqmkp9FKPLLChroidwvFyZD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-EC) WindowsPowerShell/5.1.19041.3031', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib3d6OThDaXJUS3E1RmswU24yN0VURHlFVXhHR3hVOVNIMGkzb0ZQaCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0OToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL29zZ28vb3JkZW4tc2VydmljaW9zL2NyZWF0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMyOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvb3Nnby9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1757702681);

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
(1, 'SIGEU', 'AC'),
(2, 'SAGE', 'AC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_grupo`
--

CREATE TABLE `tipo_grupo` (
  `ID_TIPO_GRUPO` int(11) NOT NULL,
  `TIPO_GRUPO` varchar(50) DEFAULT NULL,
  `DESCRIPCION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_indisponibilidad`
--

CREATE TABLE `tipo_indisponibilidad` (
  `ID_TIPO_INDISPONIBILIDAD` int(11) NOT NULL,
  `TIPO_INDISPONIBILIDAD` varchar(60) DEFAULT NULL,
  `ESTADO` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID_USUARIO`, `ID_PERSONA`, `USUARIO`, `PASS`, `ESTADO`, `HASH`, `FECHA`) VALUES
(1, 1, 'penriquez', 'ce3375120f1eaeda4e3da063e3cb4c39e11cd08fe9740f34e4e9399f7bf4839b39fab2af0050ff7539d99eceb8a10604aab4bebb022e11bbc5c61e8e7eb61029', 'AC', NULL, '2025-04-24 16:04:28'),
(2, 2, 'atiamarca', '515161d052cfb2f23b7cff62b57289ef790c430124d0650569b7add8c2ad5003b18abad37ae5d2271b858c5e2c5b68fa71662970cd7a83dfae413eea83c0661c', 'AC', NULL, '2025-03-18 08:35:00'),
(3, 3, 'ceflores', '53ada3f5f9e3bc4f68b2dae5f561ac677b4436beb37aba02dd000f8c04fcd53dde4f3f472bf24d09c0e315c8155d6e921f5aebf5e6302d5d29cd7be122060735', 'AC', NULL, '2025-03-04 14:06:00'),
(4, 4, 'dtorres', 'ab4c91aaf5dc365f30990369d580267497cc56ccc00017066eee77e112b768c9b6701dbf86f128ebfa15a8fc5ca16fec6e368633acc3ef5589bea97b1578a664', 'AC', NULL, '2025-06-03 13:54:00'),
(7, 7, 'ecolimba_pruebas', 'bd9c0b4a5bd5df532f7e27f582aa7f1a110cf1d0143eca7d4359dec6c01cb7243ffaabc23f50c72fdd4af07f850ecd406e46a860755c710c8a50eed6927c5423', 'PA', NULL, '2025-01-15 09:10:00'),
(8, 8, 'iagentes', '42b4b929ec8e25c1955cb64533ffd31941c5e5d8694e4e1bbbd711f0250219f5a590c30d48e3cea867e61ec00ae89eab4d50813c9d3028f0ba77a50d37fd7b3a', 'PA', NULL, '2024-09-12 08:38:00'),
(9, 9, 'cjimenez', '26752fdbc62490321960d12d1f023858ea7c840fed20dcc556c2687cf6d6d80c3eb989d1edfa9b91e78a487d42375fb55aa00fff2770c79d736ad1d5dc42b22d', 'AC', NULL, '2024-12-18 11:41:00'),
(10, 10, 'aamaguana', '1f3e1e99a64e10a612c5a4ffbed9dfe9637c5e4c4c4599b8c22bcbd5332770cd4912f0324c6d9c880723006366527dab6da0af50d0cfbb2a24e5e4755e5fb848', 'AC', NULL, '2025-06-03 12:37:00'),
(11, 11, 'pandrade', '99fbadfce3a08867c2ac433148f437bfca4859199d01adf2e455ce807885ff4778e44deb42ef593e60a321b20b6032ce735c7877bc6b1359056e32686102cc25', 'AC', NULL, '2025-10-03 09:00:00'),
(12, 12, 'lbadillo', 'fa09e417712e435953dffed5bc9801cba6d146d65f9c7bfe777237871c0293b047c18e5c49593fd7e9165181de138cfe30543bfc8e9411fde9a388f71dd20958', 'AC', NULL, '2025-11-03 06:17:00'),
(13, 13, 'jbastidas', '817921a99848209f5679b3c640cb15ffacaedf7861cae47634c4f2002be487566dc5933aebd1284a2105ef3ff60f6ded670392b515398c65563ffc6a53233d48', 'AC', NULL, '2025-06-03 14:09:00'),
(14, 14, 'jbosmediano', '8a7802de75ff5ff3a602e24e9f5858c5d8794ec41531846600fcb07e96ed5529866d1a9471f5b0d186ed98a5f220557d5a509077f0099945c0495be8c108e6f5', 'AC', NULL, '2025-07-03 09:20:00'),
(15, 15, 'scaicedo', 'ba0936278c4baa81bcc099a166e2cf974c84b408e8b1b2414dde5693513a2ccf8222b1c79559bbacd300c89cf27afdff13d6e4cf61bcce4738633102b24ac078', 'AC', NULL, '2025-07-03 12:47:00'),
(16, 16, 'acalderon', '44ecc572dd44cbe6c35dd83f61eb4d7eab6d4b578da267c9093b15094c37d9d321ba98c980df9fa05fb8b046d9e799944ce34a87c415f54dc4f193de2a04d1b8', 'AC', NULL, '2025-03-14 19:15:00'),
(17, 17, 'jcolimba', '4cebdffa3fabda4fd6fc32cc7e09383222e6f04cbd55b748bd84b88d7fcd4ac0c3ad481db2b6af810fb362735ccf213b9532faa7f8a5c337024266ced33150e3', 'AC', NULL, '2025-11-03 10:38:00'),
(18, 18, 'gcortez', '1484f70e5e8780f3801fa33ac695ffab6ffd0b24d937669dee70e69a6eb545df18b6c9c0d3daeba80bf0f26bf7a470f221ef707ccc94fc4b152754a77bf06bfc', 'AC', NULL, '2025-03-14 17:49:00'),
(19, 19, 'mdiaz', '13a92975e04ed1a2fc7f2a6f135ef71ddbf9afc5aadc783ee59eb43053add9f19b36b2b415bcc6d145db47b9570ec88d2a590335d4151dd41581d976de970233', 'AC', NULL, '2025-03-14 18:11:00'),
(20, 20, 'adiaz', 'a3262ff3003d19e404771abf5a8cf4affdb5256b58f33c2d5ae5ddfc0e91f1e7db4f862b76e8f3adb3dbb780229abe1133597db2c386940a086122546e9b8a77', 'AC', NULL, '2025-07-03 14:07:00'),
(21, 21, 'jenriquez', 'a9507c197c6d2c9ecb3bf145f61761c4fbd0c072bf9f99d154de6380f82ebf8b8a3e0aeffa9dd9608c9e541854177a80e0b9eb9e45e4791e195394b3466048de', 'AC', NULL, '2025-11-03 12:20:00'),
(22, 22, 'mfernandez', 'f04c626808bab51fbed93283abd6fb96d4198bbaf124038bb04ba00b7d8bf6ed258017b0ef32fb584115be48cd3bf449ecb5612dcd4f6414cc873d571303108f', 'AC', NULL, '2025-11-03 07:51:00'),
(23, 23, 'dflores', '8dec3cf0b17c1c6c87ff8573898f4c162dc291a8513d067a6f2720b1f9f3efdc58afa2fb837c5f27267bcc5b827caaaa2e5a52f9f4a34d93ea6eb0e949683cba', 'AC', NULL, '2025-11-03 06:16:00'),
(24, 24, 'lfraga', '7bdafc90a3a30757922a047a5a7de74f72e8ba90b5a31197dd71d16fdeb16dcbea72148a4ba21073ddfe5f28f07460d114fe72a5e987bbb215ffa103e231a0ad', 'AC', NULL, '2025-09-03 09:55:00'),
(25, 25, 'agrijalva', '81a58ae7793e736dbe35e5135469c806fef3789fe65c7c9933090bc7acd433e142d8761220dff1c50a696860f785a611ac803769b8529ab7bd9509e470345bf6', 'AC', NULL, '2025-10-03 12:14:00'),
(26, 26, 'rguananga', '6d02e268112d32092cb040761abd44f9bbe6fa453e22e19082e16d5fd8a1e1f290c8a7af2c5318ec471e37dccc756e4278251bbc59f1b070d35b66d4bbafc488', 'AC', NULL, '2025-10-03 22:26:00'),
(27, 27, 'dguerra', 'ca7ffb25879825154293a668f761439363bb6b28f46adf21c398f371c732fde9c793d5473ec8c552102611c5e1c4176488d8d4738c99b281940faf8be3167864', 'AC', NULL, '2025-03-14 16:58:00'),
(28, 28, 'ahuertas', 'a484269075f0674975a37a6e3fcbf06a657be04f5743daa23284187334e067abbbb8c80edf3a4a8c03d44a99de0ad44d42aba8fc659f9325abd87455a2ed5065', 'AC', NULL, '2025-11-03 09:12:00'),
(29, 29, 'clahuatte', '69b24c3d8f5d1c5bad084c963c412ae0da7b8da738b019332af7ae914e321414ba3f29d652feee7582bf424fba97d7693b5706c97b7f751ad929535f8fd640bf', 'AC', NULL, '2025-03-14 18:54:00'),
(30, 30, 'llandazuri', '8144663adc06b25c6925300fc7f40a3e483b460759af46f6d1fc1cf64e3a4c59820b0fe90ee9e60bdada4d35d48c0ea02b5fcba1c53ebcfb07bd05f3e688d15b', 'AC', NULL, '2025-11-03 12:33:00'),
(31, 31, 'elobato', '64022a39e699e8646c12734e9b64858b18662ba3b1ca733310e983b0b1fca4081f49a3869818bccbfa3a6f3e973d45cadb90632c1541a1f9457d8995d4a92727', 'AC', NULL, '2025-08-04 11:56:00'),
(32, 32, 'eloza', '7ec3a9fae5ece1a50e7eeefaefb7e928321e83ae320db658ca4f4a2d701dd90a3d9edd7bd13197243524612727128bf308907d34b4f08d660f5380e458f568ec', 'AC', NULL, '2025-07-03 14:02:00'),
(33, 33, 'jmanzo', 'd5686ada23f87229e1bb4c0c436c69d288b8a08999efc10d4d4812f3f37f9c8476803c3865ed1631767200c12332d9c4f75a6a1e08fdb82013f73f8ce59da1d4', 'AC', NULL, '2025-11-03 07:36:00'),
(34, 34, 'jmayanquer', '91d15df119e99acdd01931833748980925ddfada95c14ca4ea442975eb8a513e7fbbd38a195927856397bec92e2e748c0cbd8eba062a3e45b20feb6a65f4839a', 'AC', NULL, '2025-10-03 09:03:00'),
(35, 35, 'fmayorga', '3ec3fe3dc46f4ca0846e4654722cda711cbace0ec95fd33e798599c2208d4579fd642ee41c1f0f3de32e2f701fec8cd76f707affc63333ca4b0229d6861440fe', 'AC', NULL, '2025-03-14 22:07:00'),
(36, 36, 'bmorejon', '4991ac25a64792384e06086f3ec209374ee9eb824bdc5c23c8cce5e2d20d1c401156785802b156a611e30b205383515bad7255a635408c100d3a59ce6c5f34fa', 'AC', NULL, '2025-11-03 09:32:00'),
(37, 37, 'amunoz', '969bb4be191a0123265c8cb8b9865df52a5cbc5ece7ebf75a79cb4e81a98db7e4b614be4149053c8994dbfe4d0aea9f8b8aeb04b77c8830d8683efb561892b22', 'AC', NULL, '2025-11-03 06:23:00'),
(38, 38, 'cnegrete', '7e904f8375ca93c49242191b899f47b33353c39ed76d6eeab5e46fd9c7149e45006aa21484bda5235fbb93f88d2db566cb8f3216282e64ae977b84f530ca3d1d', 'AC', NULL, '2025-11-03 09:37:00'),
(39, 39, 'lordonez', 'd3ac68e9efdc1140d2828d186cc08c688b00e2b4f3c87623cbd2701b30053fd6f77a252800218304ac8d49a520e102fc379642c2766b5a8dedfb09eb65ad1308', 'AC', NULL, '2025-10-03 15:07:00'),
(40, 40, 'rortega', '0f3a474a7f491223f4ba53ac51c88e0487a65e637cee7f3fbd1f2236b014c7843a41e3f97e7ce9eca99ba2e1cb33aa40ea06292fb651983163c5c19c23ea38f5', 'AC', NULL, '2025-11-03 06:14:00'),
(41, 41, 'amortiz', 'a0b5cc804920ed0e1b04a6909a3ef8b59ad10f4bda2cce3ac2f1ac0427297ab5075e2ab659c89a42635ae3132fb28e9638a12f9c4edecfdf359fb482a1c2036b', 'AC', NULL, '2025-03-14 19:22:00'),
(42, 42, 'jpastrana', 'f7c96db41ee552dc9f9421bf778e242cccd830b1fe0ec3d0f08cd4579866c6b3a868b94b53541abdb3a7dd948437067c3e96e84b8970d7a57a9ad648e6702edb', 'AC', NULL, '2025-04-04 13:01:00'),
(43, 43, 'capineda', '4cef1f00d863edd40c1d68be544c3a708d8c4206eef9ebf6abcfe7b83a3de99640719a3b1c3ead80453a3dff0430d7747f5bec9315530d59ffe1b7582c940ce6', 'AC', NULL, '2025-11-03 15:25:00'),
(44, 44, 'apozo', '2e67abf4fbff5858c359800d782747f9ae8d3d7b08c5dfdb9ba3a38736afbc033f9e8b0ea5f355e7094383f936932ac108ea725c8b7e86623c89be9ad0e52d5c', 'AC', NULL, '2025-05-03 14:21:00'),
(45, 45, 'hpuerres', 'f0e6e47b98cd584e8b584c0b263338bb55e27dd0b5b87180e444002f93cc2486fef63e6484edb5c9db3213361dfde119ff1a90c85ed7aa8ed9338bc4b0c262c7', 'PE', NULL, '2025-10-03 08:59:00'),
(46, 46, 'cquiguango', '339a3748f924658eb42337a973f793584a3b2d29a2647c102f344e06bec5cae4012b4c43b932746844606c094633cbb5c4e223c2153f810de9f49dcebf1390f5', 'AC', NULL, '2025-11-03 09:29:00'),
(47, 47, 'areyes', '2feeab6a437c46787bcf5788292650c7db86b8c64a0c095ab9c7c757722023d28480a428939217b9791c8b3d7179be258e2b0db2ac94d6f8b4ae6426ec2ce1aa', 'AC', NULL, '2025-06-04 08:21:00'),
(48, 48, 'krios', '812ce0b1b88ab29bf9fff2ee03b7d61cc3dd0931bed5e93341619381b56e4b522fc853f29cf9b64313c54a98f6c2873c6a48f1ac566a609f541e1a224d8eca33', 'AC', NULL, '2025-03-14 19:27:00'),
(49, 49, 'darodriguez', '9b307a83ca81b387e6c32c6523262c868ba7631b20322eec839754f4bbcfdc182313a22c895887f6c393ce3c8b1ab2a9fb2808e1ec01f37dafcd156376167137', 'AC', NULL, '2025-11-03 11:05:00'),
(50, 50, 'jfsalazar', '09d2f91540537e4bcedb01682a96d8e022b0e63dea83e8f64b24ab14dc34f94b06f1a711e9c625001049fa26c127e51c6eb4338767f89149699afaebbfd29787', 'AC', NULL, '2025-11-03 11:58:00'),
(51, 51, 'jsalazar', '992b5af9d3d565b015623d630a4c365a57c9a6af9be9e25f59d9901a1f130710ad9ae016244e3b32d577f3f95961f5e96e454309b658a181d7d96a357a722647', 'AC', NULL, '2025-03-13 08:03:00'),
(52, 52, 'wsanchez', '3e85608d9d329c65ff553b058b8aba967d5b10f074d0471a2f65e1650ea5f2eaf10c89fd9284777448d8a11afd6e48b315cd140655c0a6343cd51c450b65497b', 'AC', NULL, '2025-10-03 18:55:00'),
(53, 53, 'atontag', '9c0ac10e90c015fa9c8634c2af09f49b242a84362ccf40a8202299cef7a81881ce10d81dad2b8b58361ff694222360d6fbe7ca99ed7ac830c54cf703a1004369', 'AC', NULL, '2025-03-14 22:13:00'),
(54, 54, 'atorres', '23b4679387d40d78e4abe66f1b61214dfd1844663a1187dac222f04ea33cd4e5265bebca571aa59c37ed91cb1adf6fdaa875da4fb6639c2b48621f41aebdcf0f', 'AC', NULL, '2025-03-14 16:58:00'),
(55, 55, 'ctuza', 'e58081ff3620bb19c8808e32e1a17d7b7670178c0374f18423dbc522a4889098332c4305926071b14304bcc24b1a19e1c2ad95011df8ee575609e808229f53b8', 'AC', NULL, '2025-03-17 15:35:00'),
(56, 56, 'kvaca', 'c4aa0fd4f5ce378087b3692b0a20758f13cc0bcc57dcc2b4871d74f2c04db13897e533231f9b6ea8283a2aa14ea4988a6386486fceb42718e9c7c01ae4f93485', 'AC', NULL, '2025-03-14 17:35:00'),
(57, 57, 'jvalencia', 'e1b0e281d5f2affff9eb9613e31afa76e0a6d914b3a6d47fed7994deed51f5856c90f05188463ec47850d3208ca24ff5fd37e1bac3915ec778abc29f44439048', 'AC', NULL, '2025-11-03 15:11:00'),
(58, 58, 'mvargas', 'f99a9e9244339f2b8f558ed2cdc26e5bac04e6e0b14e2b3c1f8f64272c9f9c33a3d595dc0967452afaa6a0602428441a9bc56e0aac430ee9a8f9225179175eba', 'AC', NULL, '2025-08-03 09:45:00'),
(59, 59, 'avillarruel', '9993bdb6460b4de0de36724ffcaa050a87219a5c02a399069198b59f213aa8e03f69a06e8cc751a94fb62b0051d8a852a6b96dda126de0f5ef056d750f277a81', 'AC', NULL, '2025-06-03 12:30:00'),
(60, 60, 'oalmeida', '37c79bcbe8b4bd4f240ef4b348cd0a6a2964c40683332b967cebeb33c5551f19f11fccfe7f78a45aca5a9c1819ea498bcfe882190478f6569ab0d792a8290c71', 'AC', NULL, '2025-03-17 10:52:00'),
(61, 61, 'calmeida', 'e95a08d3ef3be615cdb23340a17423d1dabc5c4f74be6f4aee64fb5bc317b923cdaed4690f8385ca721bb7e3761820010428cb9be11812076e86670450bbfd55', 'AC', NULL, '2025-10-03 19:01:00'),
(62, 62, 'wandrade', 'cb605f74f22709b77e9a76eef98cee74fa61ab03022b244332699d13d71b6114d3a4a77988db17eb017308e27e25d766125b43a9507112085e7927269d2d6af2', 'AC', NULL, '2025-06-03 11:20:00'),
(63, 63, 'aandrade', 'e495a82f4ffdfaf74c611890e19f09eae5e046526f911905ca3464c71c6c1a31ecfd6c4c4482f69f435788a76eb8dd7ac4d8a1c6a299c85e015e40bddb145c36', 'AC', NULL, '2025-10-03 13:18:00'),
(64, 64, 'iandrade', 'fbee36d2f93b213d9889abf8961cf7a32d1baa873a632b3eda0106313fc19eb034adfa56e33c8b5339caa84a54c2082576a0f28107f3cef0d26f521d2f3517c2', 'AC', NULL, '2025-06-03 09:58:00'),
(65, 65, 'dandrango', '597f27ab1f35ff6f9cc5ad6123092a890018c92ae0f136982ba0d6cef72da5ebbb6a3dbdead8e2a4d2ef86e8d649fa4a53eb269fbbad78f2b0e78658d285781b', 'AC', NULL, '2025-06-03 12:38:00'),
(66, 66, 'batiz', 'efc15a38c8e2accad8c5826c37100deace08ac2712bcbc96b4400f908c4c66afef04108c1b710c10c222e53d2689b13c14daade9e3d1b6e717165773149c7534', 'AC', NULL, '2025-04-23 20:01:00'),
(67, 67, 'sayala', '467b73db39547065e2d427aa6ebbaf765c795e13fd5be110ed3da6b7d2bfaf4e47fbd92e7c48ea2e1cfb2bb0ef7499bfef039d471200da72217529f000ce5af4', 'AC', NULL, '2025-03-14 18:05:00'),
(68, 68, 'ebano', '8c96db853bb95a8ad8327942cc46ee3ddda50a58bf339c604407334f7dde62a146dda505b344b94bdc252b15a11f1b09c697894f6ba07eb400f1f0036d629d86', 'AC', NULL, '2025-08-04 09:26:00'),
(69, 69, 'ibastidas', '30164de1dc7bc16cecf979ad3707ba27b4dd5d48155027d646eb9b692e07425c3bbf90268d05e97e28a20015a1afe4f9d13c4dd1fe372c8e7504025e287b929b', 'AC', NULL, '2025-11-03 09:19:00'),
(70, 70, 'rbayetero', '91f2563f7ecafb93335b8148b8ec28286b5d9dbfac6a3a53d0f02a3ce40b0a71589117f583dea7dbec7695613ecad287b6f401ff050009706a354fecf9995f07', 'AC', NULL, '2025-09-03 21:57:00'),
(71, 71, 'bbedon', 'f6a1eb0b00f2d52a1880b53d7779761c1887e38850abc2c0c736caa21e3304f5c5487d7bd0cfbae9db0b1ffb53c7bac52aad1a500fbc7037e5eeeb6898d92d07', 'AC', NULL, '2025-07-03 16:02:00'),
(72, 72, 'sbeltran', '802cc5f5ce83df563a906393d1f5e5bdb006ee07520931de08b6db0f764e4fc1e57e763540482c5aac76921ff342de5440286732a464a5679e7ccb6c4738c3ec', 'AC', NULL, '2025-03-14 17:32:00'),
(73, 73, 'abenavides', '9f6661f7496251a507b80965ff9126cad3631fe22a4754b69ae93ff8acdcc1703ab79a31902ae072f1a731d0be077109cdfb491dbd9c6e7092fe777290d0eaae', 'AC', NULL, '2025-11-03 11:59:00'),
(74, 74, 'wboboy', 'bafb012b510e5ae235493e71f67242533b24d0e63c6a49cd55a6216293ac121069b86ee2aa3bfc71e3c38436ddde62b9819143ceb0c28a9c8693f61a28fe6535', 'AC', NULL, '2025-03-17 11:23:00'),
(75, 75, 'bbolanos', '1e0cd256a830e09421ce84e413ccbd4cf3ea52b355fe0ff5fc641317298d7d28582b6704a02c2d4014c33b8e988eb825f2d0e7b1dbf3f9233b342271f15de16c', 'AC', NULL, '2025-11-03 13:51:00'),
(76, 76, 'obolanos', 'a41026f807aabda3d17d6c612769f4b57269d9cdf27bbde9f671cd31a8bedd89c8f668b1d772a20c4cd445b842a01f423b79aeddb075e230cfbead8356d80701', 'AC', NULL, '2025-06-03 14:25:00'),
(77, 77, 'rbolanos', '57c8edf388266422f5d61835b69342a9e268cc3dc8d822c9357868cdd13ec7a9f782bc34b204e72f9ac65b2b7cd0f486f8461ca7ce862ed8c14fdb85b7c5dabf', 'AC', NULL, '2025-10-03 15:25:00'),
(78, 78, 'gbonilla', 'b7fbe0e08d92045bf0ac0bbc9db4e0718fc24f1c143127fe7385bd79b1b51387f6498519893cfee47411d5dbcfcb8dfec7a01bf59de6b9ec9c0ae1d73eb5f27b', 'AC', NULL, '2025-05-03 16:15:00'),
(79, 79, 'ebonilla', '93583b5ac0097f10fcfdb1813459bd525668344c2d7c8f6b93cb17a49324eab3922f04ad029aa0afae8a00f444dec77f13da24ce5eb3db841720f9c1a3e0f8ec', 'AC', NULL, '2025-10-03 19:04:00'),
(80, 80, 'ccaicedo', 'c9ba47d431c39a4cadc7dd7e36a522d837d7e724d02760922e69d6ae420661486ee255043c9000ade96737335fb7cb1aa2ff497f4ca6ac8bec243e8a81ed0bae', 'AC', NULL, '2025-03-17 16:56:00'),
(81, 81, 'jgcaicedo', '449adbcea62cc191ede7293f1121c3a057b7400083b0eef74339662fcca9445a4bfae8004568a101f6b9d4737df47280aec1dbf95caf37590a41b5dd06b33005', 'AC', NULL, '2025-03-17 10:30:00'),
(82, 82, 'mcalapaqui', '93af2497d6e5658a0627ca59603095c1e1dd301b38ee141d552f6de7c2fe870f27c17ac3c5faa86e588f11c731356ff6fa351c4c5389a7ed4ccf1c78ba4a2357', 'AC', NULL, '2025-05-03 17:25:00'),
(83, 83, 'lcanacuan', 'e1eb6e81b889ae0916e635f5f377d0b19352eba16360a3b83ec3748e9338ba98855fdd167f5e04f312d8cf3087c3d0ace1804de5a12c896d9ee962b8577f7af8', 'AC', NULL, '2025-10-03 11:15:00'),
(84, 84, 'ccardenas', '15629854b070fa0c03b2b8e12b26bba7d9aed074fd4b8cfdae61b3ae48436ca8c3b7e70a2c259ffbb176ca032dddc691c211ca665eb0b3c75d3ef7e7fed787ba', 'AC', NULL, '2025-06-03 16:41:00'),
(85, 85, 'dcastillo', '9169451764c17de563d8af2cbf72e9a4a14caff55b192bea812395adf4d2ff24f1fea3e857aa34a04221f1ed5d0b19d10444d291a31412edc28c8aad80db67e4', 'AC', NULL, '2025-06-03 09:32:00'),
(86, 86, 'acastillo', '5c7619645b041c6ac0aef76b79d582563d85d62a85fe0357d9655ebbeacbf174d1a493f2b267974a8cf9c8aa54ab3f2629670f564991095b43c26d3147ae901f', 'AC', NULL, '2025-10-03 14:16:00'),
(87, 87, 'ccastillo', '73331ff612f9ec2c6024d8047e0742468686ad51816694368e2734b64955385fe37de6534440401819e68992f3c50f9dafa2783f1a6f566af75fa1b138b064cc', 'AC', NULL, '2025-11-03 15:02:00'),
(88, 88, 'vcastillo', 'd74adbc8527ba6c2aeead8f6b8e118917235756fa358d9ad20d6e9e1a5556987d6cc341d5d6a763f756ef3ef1a5c70e21eab5ceba653bb688ef65ebc929f16fb', 'AC', NULL, '2025-10-03 13:49:00'),
(89, 89, 'dcevallos', '01310ed934456e9a13a6f528e48a3bfc57a200b099b5b2c48863451909f3a33d96aa96e9df2f39e00ad954dc953df18c16322d0ad8186e3d9cd614d2688ebff4', 'AC', NULL, '2025-06-03 21:11:00'),
(90, 90, 'bchalacan', 'f213c08ff08463e082ad93d545ccfbb0b7472622fb0a3c58f05d6429673d29049545304873e5d156a574aeeece6ad4a8e1cdacc6f92847218a9719aae1d5d5b3', 'AC', NULL, '2025-10-03 12:49:00'),
(91, 91, 'schamorro', 'bc52eebbfbe4ad406b91b6b79369f234bf6f94a605fa88f193b5819c68a47dafa4bb73d7314acec57bdfa15ac0380d772a490a90026a9bec3f6dcff8ff43f85c', 'AC', NULL, '2025-04-22 08:28:00'),
(92, 92, 'jchandi', '88f3cf0f248d894da05afac645c28a66c87b0a777e1a5f729733ec925be9d22719efb257bd6b3a858ce01cc129c7298b7e4413d2ea3a1d2d14d1c29075eddd90', 'AC', NULL, '2025-11-03 15:14:00'),
(93, 93, 'cchasi', '811c85653c244d985a5f13a234962da9e01726358a60da9a4f6ce8c47785caf6259141310b41e4649ac9823b25fc54ce37e0f62bef7a07be686951d2e591d932', 'AC', NULL, '2025-10-04 20:46:00'),
(94, 94, 'cchauca', '64e660a154c10a1c7253a00fc0bf1afa24dc3d61e5ca2472a6d90cdadb74cfe969bd56f495b9af2175dfc966001436d8d581af859f3f4e51c89183f73b748ea0', 'AC', NULL, '2025-03-14 17:05:00'),
(95, 95, 'mvchavez', '73778038456d738d32455ea7f0e15fb3a843ef2c48922ac2cc2b333f4f7ab100a7019e3647126c1d98f33b818bc7c30b8958f9569c83d28e0b6221b42fedd796', 'AC', NULL, '2025-03-14 17:58:00'),
(96, 96, 'schicaiza', '5b6e04b9ae7f95a3dabcc8d9c8e8b0e98b0c0f58eb2da424996ea4ea5e0b2cb49306a32fcbf7e202b06575a73534f358033e1ee80d454f472537c8161446944f', 'AC', NULL, '2025-11-03 01:05:00'),
(97, 97, 'dcordova', '2de0805c97e9bd2c55eed27bbe59577c16aee3b63b644bfe44e74bcc208f625be26c2b203359a4e713fc81556742a2282fb1fd18cc3987786022e06d37a48716', 'AC', NULL, '2025-10-03 09:58:00'),
(98, 98, 'acuamacas', '2cc1a3fd9380be992733bcabace60234b67f6eccc3949b3713d3b9b676511e382ab8ccf41d627a1b1cd4e2bbfecd56ffed39dbab13a7173c29b3fb337078b3ad', 'AC', NULL, '2025-03-14 12:43:00'),
(99, 99, 'bcuasatar', 'c7386de37f3ddf10e069459fb4048ed6316e8391d6dcf20303198e58edf8ffa0e0954aaa2a554ff54df6ba358b0acbc9dac35e6352fa94aee498940bedb13fef', 'AC', NULL, '2025-11-03 11:50:00'),
(100, 100, 'lcuascota', '681dbcd2ac4ff198174d3ef45f27d6a364e241bb67bc83fdf90a653ef2d67d371d1c580f296e225638211ed2cd669f9e7688a9fb552e1a76a7cc907e7e1f864a', 'AC', NULL, '2025-06-03 09:49:00'),
(101, 101, 'jcuascota', 'f807cfc6957471c6a9d9233c4259f6eb9d302cef23b7f21304e8b27f42388dfa795b34d8fe1ae9387f63908c209c3dad3d9ea8ac4b94c6ae1cef0931ff6688f4', 'AC', NULL, '2025-10-03 14:11:00'),
(102, 102, 'ccuascota', 'ae1fe3e945257b187d5a8c03e6526ddef2f46401579417aaec2957b306e4800c9e41cbd9616a806dccf77b9ca715370b7bc68889f1294b8ea9f2cf6a05e66afd', 'AC', NULL, '2025-10-03 22:18:00'),
(103, 103, 'lcortez', '9feea5bc436711c499bdc210c44277947a2d809f33557150a954633a7ac6bd1aca1b5a338b1bf829e28fd0a98129b67ba9b73813641cad693d6c67a552b9b203', 'AC', NULL, '2025-03-18 09:48:00'),
(104, 104, 'mdavila', '14eec1464d54b8699eda3ec0a7e2cc87199f36e328d1a75f3d4861a740815a16e10e048556dcf2a04678dd3b468b8b8e6b8f3ebed1731dfa39bed55c94f14e5a', 'AC', NULL, '2025-06-03 11:54:00'),
(105, 105, 'madejesus', '1f6388fcc5b3038fecc3c137e473c0c26a7710775e170a310b0004182a748e0e510902d547253ce57fdf189c9ecfc7fffd958271c8598bef8e4e97f61bdb9734', 'AC', NULL, '2025-06-03 11:34:00'),
(106, 106, 'edelatorre', '3f8d8843a204d78c94c06b865a9fd96e1dab38830abc494c396b1a3d07737a780d73100952c2c53efb68ca34e62d5a57c3065a4b04213e3f9f5cea9b1de87160', 'AC', NULL, '2025-10-03 13:20:00'),
(107, 107, 'kdelatorre', '628d774942d5720a82b11ab3ddc398aa5b65828f67822c63276cbf725555f20af74e2cbcce2f85316f981991a7d6de7ddbce9d67b48defe971ac7d08cdc41159', 'AC', NULL, '2025-05-03 16:12:00'),
(108, 108, 'bdiaz', '39e9c297c6f5bfd2e09692c64498ad4086e8b16e296a5f213c18d938a64aba8d7793bd6df7050cd77e554fb89aadf6c6ef2b6fbb91548714560440a901375960', 'AC', NULL, '2025-06-03 11:51:00'),
(109, 109, 'idiaz', 'e5a03efc9ffe5c385af3638926546ecbc1039a4a9693239367519ebbeb986707eb63041cc3cb8ffc2b37a33b2ed73cb9ba15e16237e06998dab8658ae40270f1', 'AC', NULL, '2025-10-03 15:00:00'),
(110, 110, 'sduran', 'e8d212d024b7f0bdd88ea3cf3ec8a4d74e059adb60ab81134448a2c617c4863911c6c0ee7869e30d54a7e4bb175da32113a944ab2be69df64ff9a364bd8b6012', 'AC', NULL, '2025-10-03 22:05:00'),
(111, 111, 'cenriquez', '46c821c79b5242b6d7e710c6ad2bc4cb3ff41b581d3cfe98ac69bd952b1a01ce09de5b561d61c5292070183b1c1afd27b94e4386a0da324af3002dfaf07aae78', 'AC', NULL, '2025-03-15 06:39:00'),
(112, 112, 'jaenriquez', '54d1264f29993fd2ba63e0526b6d1650019f09dc18ea813c6b776c23430f0e4294690d2091ce44a82a3e7693889d14b3dca59871fdbb6a078b65c944f1e49314', 'AC', NULL, '2025-06-03 12:28:00'),
(113, 113, 'eenriquez', '08e2f2dee2714af58bfdb249773529a5893e0a2091968e3860b2abbfdfd73ac78361bdc88c86b37d985fe00ff56c6a186859e7e02e91dc694919e164cb33aaf6', 'AC', NULL, '2025-03-15 06:04:00'),
(114, 114, 'aescanta', '87fff3d5f356e4020e606d9dc7a11aac603ee0eb0532bd0ef41dbaa36aa452e425e0d956cf35910086ea0d7cd64ed853af8e9f57e07e7a3fa207f19bcc4dd3c5', 'AC', NULL, '2025-03-15 10:51:00'),
(115, 115, 'sespinoza', 'd78702ab393c2b7911845c30226e70cdcee22ed2c178c3ef83500018022ee30c67fa721cf195628c8b56da2ba7008daeb7c3b875d2d5b2f4d0aecc39ec21c10c', 'AC', NULL, '2025-10-03 14:19:00'),
(116, 116, 'ffalcon', '1f838435fb20e4341127536faf72df7a5c50fa0e634b592183fc99e14e8bd4bb94a194b26fc2888df84e2b3505c2bc8616aa5dcbadda51315a780e0d307c45ab', 'AC', NULL, '2025-03-17 09:05:00'),
(117, 117, 'jfolleco', '9f3f9480de81126f62b917782d9079370d6a09d88fb29e74a43a473a1dcd2590919713e156f4665939da054c9dfd589a2f31aa0d7c75f85a5ed8d40c11aa7b3a', 'AC', NULL, '2025-11-03 15:01:00'),
(118, 118, 'vfranco', '223c47e9b97269b4d0c29b868f99c338c6501639dbd7b4a783e7ec6e725a997489838d40f13a4db70eabf9ec5857cd84fbedabe791b7f7f2d404240886acc14a', 'AC', NULL, '2025-11-03 12:49:00'),
(119, 119, 'egallegos', '54838482b874a4f702040e7d5aaa404980876622991dbc81639890083a7f6ab51105756baed009374d7dd34bfd30550946b0c9d73a370a44c63f4f85a156cae0', 'AC', NULL, '2025-03-16 22:31:00'),
(120, 120, 'jgarcia', '00ae27fcd0b9775391bd90fb6ba66e1245af1ab04a0d615833d6733788a32f152d83351ce7b94ce34aac9589c1a6794946d8991dcbbc3b8ae515d168abb76c76', 'AC', NULL, '2025-04-18 18:35:00'),
(121, 121, 'dgodoy', '9ae7931bc0d01b9e7e184c17cc51c93c23aff36503a8b8935d97235eddcf70ec27c448a992b0b6d531507127e5eacd494bf955b8c87fecef1164df8c75afd63b', 'AC', NULL, '2025-10-03 14:13:00'),
(122, 122, 'sgomez', '0a2ee228617da65cb7e2252d2d69d49442fafcea8650c40440cdbf7d095688a6820f01cb2d57e8df79af934ec3ae18d616497b413d07d0f5466fc7a1ad79aa99', 'AC', NULL, '2025-07-04 10:29:00'),
(123, 123, 'lgonzales', 'a101cdf742d80b78fb158f45c25901d9a1456d259a191be5320f7a1b07e62a511053a80a4b592259102648c1c5bd20d1b8cbb8a9663f57ff1f7200bf4e68cbbc', 'AC', NULL, '2025-05-03 21:52:00'),
(124, 124, 'cguachan', '164521111d507fec39f0c62702e37f837de03f3978069ced3766246cb5b7e196c00a8953fb5324d19525a519c80ccc209bc41f888f6a95a595eb2e22dde6b50b', 'AC', NULL, '2025-04-22 08:17:00'),
(125, 125, 'jguama', '746be405c04793ce5c243436cf80bbff45f06a6d90a22ae9298842d85142703f41e31fe6f45d7e514bedb93acd12f29a14fa0fa17ed9c31e434c823dd82434a8', 'AC', NULL, '2025-10-03 11:29:00'),
(126, 126, 'aguaman', '9ae4a1a0573bbf47e714f1778bc21694f129988ac6e77ffd1021f73d74fd7081ce1436a99dfb966ce733ef7fd999945a691ec2567bf4e9c556aa4ce9f9b3358b', 'AC', NULL, '2025-06-03 11:59:00'),
(127, 127, 'fgudino', '7e0abba2baf2edb45fb190a4336a89d3238c6ccb021934e9a7eccfc8cd710df7a8e17dc3169ec24b727e125b1a7152f76d67e570e9f120b81fae2d1abc763b3c', 'AC', NULL, '2025-11-03 12:21:00'),
(128, 128, 'ghinojosa', '76f89eb65b6f103f4aba77af3dcd1fd9cc7e25bd35e0345a7863fb7de990fb998ceb83e20637b17c7a22ca5435df1ecdd6c3e442d24711d5f500085b47536cba', 'AC', NULL, '2025-04-04 12:53:00'),
(129, 129, 'nibujes', 'cd9704d49bcc7b1efa64660b451709d59f19e7126f294cd8b64e0e05d363f5c385f65d137c6cdb9d65412ed1fff9a89e575fb4df018f0d6fef5b39b543469ebc', 'AC', NULL, '2025-10-03 21:38:00'),
(130, 130, 'eiles', '4bd86429b7d839e5daf0239905071794a96a828b6f86debf7ac81f3a078aa95a57c7044e74a3b301c49a604dca8bcc366e4bc7e3a325b327fef9fb1793d9a1d7', 'AC', NULL, '2025-11-03 09:44:00'),
(131, 131, 'eimba', '91037727fe069613673e5916d02730ebd017d9dcf12cc37f2b1658c9d3e0847f5114a43b26005e08e0619fc235e37ee402b78dacec0478b6111dc65ec17cc614', 'AC', NULL, '2025-10-03 14:38:00'),
(132, 132, 'jipiales', 'ff2be487ff7ea8cd43d9b946f89aa62c9f7f919f3ab5140512f507570df796689b504a44a074be7d75d792f0ed2edcdbc459ba81417020031c4e3c1fe4985bd4', 'AC', NULL, '2025-04-15 16:38:00'),
(133, 133, 'eirua', 'e1aa7492bb426a328b99564c0d846fde2ebefe21bbb4c7a5b71f9f69a7923054a4b5b55f9eff46741b64de824179460a510cc88ecb7f0bb955c5dc90a67da062', 'AC', NULL, '2025-03-14 19:28:00'),
(134, 134, 'elemos', '5a14e0c07ad4770e2cd1cf7f5deb01921e4fd06b719c753c4cd1e6cca27f78eb9fb135dddc4f900101a4cb2244f2d10b090d4255585384f8a4593dea901b5b2b', 'AC', NULL, '2025-03-17 11:48:00'),
(135, 135, 'rjacome', '53bc535e81e2a0c5d59e4698f62c08fcf9d8a74dae4a0bc5368345b76dd68b9b6b91e45d35d170febeb552ce1b2cc8a94600661b9567d65dd8dc76390d221855', 'AC', NULL, '2025-10-03 16:15:00'),
(136, 136, 'alopez', 'f7842c10110bfff12ae9eb33cdf40a7033cc61f82ea85d47eb5931800963073ee6f9c232ff510f896f34e7e6eacdb66ffbadc2c78d5ee4bcd1166ae4a47b461a', 'AC', NULL, '2025-06-03 09:32:00'),
(137, 137, 'jlozada', '98621921bb8deaf1ef5c4ae05672cb9ae39fe32e7829065e37cc22ffa04778864122950d43710e3ea38df424c2a00a64fb1d25b7c539611eb077cc5939177ec9', 'AC', NULL, '2025-06-03 11:54:00'),
(138, 138, 'hlucero', 'eaaa5c966002f393451341acefe224c00fbe7b7a740c07603aea7c1fad7a62e6254bc7971cb0a8365e7e8401bad4cde8525edbf19b60eabf6b5c9575f2be5edf', 'AC', NULL, '2025-06-03 12:32:00'),
(139, 139, 'plugo', '94f54bfc03c5a31e9c1149c93a73d3b590b8f24fc043107fc4e8fbbb51d57693f9b84dbc315a9be0971ff5060524792ee906897b3410761a3d40ba351169625d', 'AC', NULL, '2025-10-03 20:14:00'),
(140, 140, 'eluna', '0fbd53d88ede610d5821a5886d2503a9485ab9c909ab23159e0f00bfc0e2b56c155a895568d4fb7eb894278dc88f462b9b20db30b03606e35e5c91d9ce83458b', 'AC', NULL, '2025-06-03 12:46:00'),
(141, 141, 'fmadera', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'AC', NULL, '2025-03-17 16:49:00'),
(142, 142, 'emanosalvas', 'abb5b15a323063224ed2f5ff945b9e9aa016f7b97a556f77508b33d2000867af452efc3408b0ebfc7b24680a6ca4e713e20c179bb57bf4035c85d20ba79590cc', 'AC', NULL, '2025-03-17 19:15:00'),
(143, 143, 'pmanteca', '0e581ad871dc1fab0ecedf1de49b2e325594ec6d2ac21b2799b078d1d19f6978470b60cc99cafbb2ca506aeece1799ca4154266a4af0e05045daf11d5e701251', 'AC', NULL, '2025-03-19 18:17:00'),
(144, 144, 'emina', 'c055cc126a638b02b0407e7b6aa26009d9a504240aca8fe04980d3269cdee4c9412e9f032be5f764ff4d1a590987202538e9d258550bdd713e9094af77acdeff', 'AC', NULL, '2025-11-03 09:36:00'),
(145, 145, 'mimolina', 'cfea4a269991f2342c47968598f4e810bd3ea27052481dde52774861ad4391e504f62b2acd19cc46ca3a7076f3a3736995395ebf7f356973c1f4e41a2555a0b2', 'AC', NULL, '2025-03-17 10:50:00'),
(146, 146, 'memoncayo', '98fd9f40bdc8d8e798c04fe05acbee719eda63af3f3fc2e10823a84ec9a61654631f4d76313095f67d28493adb88ff646ff765cc99a5fb0774cfbb3610f3d2e9', 'AC', NULL, '2025-03-17 18:36:00'),
(147, 147, 'tmontalvo', 'a3afbe5f0005fc730d585e39c44eada2bdd4d94beb0c5437139b3b141cd04635b2f95eb386428316c6757f34422ea51b6283ae162237b78527bf15e0b544afbc', 'AC', NULL, '2025-10-03 17:01:00'),
(148, 148, 'mmontenegro', '1604be4ebfdeac1baaf4dd2efd2e0cc0d1b988e0821731f69e4d21e3533563cbbbd959668985b2961d06b9b0519954075720777236c1bf08bd1aec8f8f7618c9', 'AC', NULL, '2025-03-19 16:50:00'),
(149, 149, 'lmora', '4b4cbd25377a4810f5822cbce06328eea90be6375e5e99da45002276b171a0133316db1afee1b55c2d06a09fdcab1b49dfcc0378647c1f9db493f254a498618c', 'AC', NULL, '2025-03-14 22:16:00'),
(150, 150, 'mmorales', 'f1680e6d807f303a440a4e89f3e0d227273f5b10ba119194791349cdff5e467d5cbd2270b3ae5ca0472aa7c229cf52642856d45804801d31388fc6cf32c906fe', 'AC', NULL, '2025-03-17 09:01:00'),
(151, 151, 'pmorales', '8f4cf90aa582ad8ddb543fd1ff249e9f1f7d9f63a1734ee1700e491926814f0bb408b886d239d4714e386ae5d921c7a110ea580b8211418c82e5403f310d8579', 'AC', NULL, '2025-09-03 20:51:00'),
(152, 152, 'jfmorales', '490c7294dafe776f6cfb617d45d789e4b57da5c5144fdc9fb8594983f884231c472665262dd28d84a0a44d126c56e90fab3bfb8f02563dcd304eefc0423b45ed', 'AC', NULL, '2025-03-14 12:18:00'),
(153, 153, 'lmorales', 'cb81dd75213c2ce93695241d5f3b096b8d8fdd9a7b3ebae5adc67f71652af7a55c54c70ee22a0a0f4ec284f6484d09a3fa178f770c2fae15d8de8d5df33b69b1', 'AC', NULL, '2025-05-03 22:48:00'),
(154, 154, 'hmoreno', '9377f0d1e0741c0c95121be0d9013eb178ecfe6b9828718fb6fbad1b8321f57f8b0d4579bfa0e2e20346d3ab48965278a1ad247384ff5ffb824453365ec451c6', 'AC', NULL, '2025-05-03 21:55:00'),
(155, 155, 'emoreno', '46699e93bf69dd882a9bf4e914f73f21f83e90d8cd2ddf722e9529a0ee39bdfb62261625e2376eba3ee014becbd2050dcbb513eda18feee5e182a50e25299353', 'AC', NULL, '2025-07-03 16:10:00'),
(156, 156, 'dmorquecho', 'a845dd30e51e3361d03da833708ec18c26bc806c2b66f8622c2674e0290e6ec6a4d112746139fbb26356f75d1ea5978029b37e6b06692e3f336d4d6d67ca8ae7', 'AC', NULL, '2025-03-18 09:29:00'),
(157, 157, 'nmunoz', '2f432aea036562d61729f93355ea07e09e119689dac016b0198c442f3327d73cf4812117a35afe61baf4246b38db8e9f0a9dcc9f96d47675acf2f96e103ef0ae', 'AC', NULL, '2025-03-15 06:26:00'),
(158, 158, 'jsnavarrete', '132841967242311df1ee08d3160ed002c0378719519a68cf5ee8983ccf7f11f10344adcc040cffc61d80ee9c3b092356e464fce3539c45af19e6cdf92e65cbe8', 'AC', NULL, '2025-03-17 09:58:00'),
(159, 159, 'knavarrete', '67a7fa3862c06e035b0168574be44286e7db4e7670c6c422595db85420b1d62c3c33ebced16f2d5655f4367f3bd5551784ccf5c614f9635fbb70264526732099', 'PA', NULL, '2025-04-24 16:49:13'),
(160, 160, 'cnavarrete', 'dd5de80bf23aa3b420c507a34f28d704c7406e8091b0f0e545b743ac6b53100481cc0683a3ab9ee55092649112893e3beb16337133c66f8d420608358bd6fe5c', 'AC', NULL, '2025-03-17 10:44:00'),
(161, 161, 'tnavarro', 'd25c34fe6c66d3cebe2e5d80aec772a7108b3aab74f5997edf29086abde174ac937bf98fd028694a9e668f533afee83f046caaf93fc28a752af223c9b83ca2b5', 'AC', NULL, '2025-07-03 14:07:00'),
(162, 162, 'lmordonez', 'aa837b7e00a498b3699b144d9123179f152da16d57ecf33392c70d8efc9129399d6d80247d6fa25c19f2157bb4b78a7a5fda943a795f6ada85dc3fcc43bfbb90', 'AC', NULL, '2025-11-03 09:04:00'),
(163, 163, 'morejuela', '98c0d5f4301b3af6d0ab358ff1d67d82476f7e1db4d6a43948542d660d859c1b3d5ca526180f749ff03f0c50542650d3e5ad21284f9d6fa5a1e9ff8cee55af0e', 'AC', NULL, '2025-05-03 14:34:00'),
(164, 164, 'lpabon', 'c23ee1660a34320a80b1f3fcaa44b4c2e89dba303f565a6eb144f1b22f61fdc31e9d41ad35bd28d37402fa01e6e90e85f52ff45d3e928822ebbde58872ffc2d2', 'AC', NULL, '2025-10-03 17:14:00'),
(165, 165, 'dpaillacho', '420a4c7bdb8378f3df11c56c8545a87b5746160c800c99a74e1d9241b9600ee68c8c03530888075de149fb6ba62f9ca5c4b21e3bab6c866d527e1792d3e3aec6', 'AC', NULL, '2025-10-03 17:21:00'),
(166, 166, 'dpantoja', '4cda4e532fae6612b31a7794a12bcc1017f692228ffcb3f10c0231a51e9ebd590b3080884bc0833aab792d2159a56a41ac3d23a697f8ca4824c8904e5a1e4bee', 'AC', NULL, '2025-10-03 23:21:00'),
(167, 167, 'spavon', 'fe1b80751f4a00e88d241f6d1d797da1491ed834d0c5579402d03b639b25260db233fbc2a7f084c1b3f375b911f230fda5c91e276060ea435fb04117967ec205', 'AC', NULL, '2025-07-03 13:18:00'),
(168, 168, 'fpenafiel', 'c5211d938b8223090a6ccce91ee9e74ab34166f7927afd653b8c113e5a456e1e11486620091a8be9894f947e42a842bd15915e2b6f1fd0ca6d24904198fd2f93', 'AC', NULL, '2025-03-18 13:20:00'),
(169, 169, 'gpenafiel', 'ae405b4e8b9a29c5528cc489ae9baf4246fe31a9cfa97bee843b7ce3972ea42b1e49a7507de480c05607ebd9e1b18d52625a40e6b0b7de954ecd75236fa3922b', 'AC', NULL, '2025-03-17 09:17:00'),
(170, 170, 'japerez', '8efeaf7f3f1a3bb4f1924a146c42da5d0541c0be4861b6042861fc01fac7195ce8c47be691fa3239670a6a04629121d4a048208594a15242ef95d8a7b57cb9d1', 'AC', NULL, '2025-11-03 10:33:00'),
(171, 171, 'cpilacuan', '5f9856033fb2d7a0224861d5b576baecebeb8b408d8a047463489ea29e103a074f714f1d4c359bf3cf0150ac26f09c9d267c739f7951b0dc70c86cd35db3d8bb', 'AC', NULL, '2025-03-14 22:47:00'),
(172, 172, 'mpillo', '13509e8627dd6af5cef01b16e3da1f1d1a8cd80a1966a0c0531e962b520f89e48b28f32d4980c0956beb983bb9da2c2e14ce4045eb1f21343615b9b609b85e78', 'AC', NULL, '2025-04-13 13:48:00'),
(173, 173, 'hpolo', '7a58ff980a5a3f198bbbdbfcdbf73b8a543fead641dcdafe1aeeddd246272e443f2e151f2bd26552cc742d19730c8ba7feea490eb6970499af78bd61b44a534e', 'AC', NULL, '2025-07-03 08:06:00'),
(174, 174, 'mpulles', 'c81b34c15346ae43007cf9244a8340623fd7af4a427792ed850f39d051092bce9ae90a05ba70912a61c70ea5ac8a15610efa6d7b869241fb9f79a6c9eabcc803', 'AC', NULL, '2025-10-03 11:54:00'),
(175, 175, 'equerembas', 'ab8e74912d26b09bf71822b3130575683cf3a242fbd1d7992df66823b37623b5b6f36551216b98195050e6466e222a6355f34b3d641b62fe500864ca9b3edbef', 'AC', NULL, '2025-11-03 11:06:00'),
(176, 176, 'cquilca', '644632a18c2b36bb47c57dff5e8d582a68e0501e66c56b4473c96fe15d45ffbd75921d5d49da194ad5bfe91bb4a64980810936053b8111f05d0dd62049f9faf5', 'AC', NULL, '2025-06-03 14:00:00'),
(177, 177, 'equimbiulco', '4cee454ffdf11c66f7f6e35063192ee9e42d0999502412145780f68b5da866535b1c79bc2ab5aec4c9ec354ec4d19d0fc5480ddd054efb41738393bea4f5328c', 'AC', NULL, '2025-10-03 11:49:00'),
(178, 178, 'jquiranza', '3f21f26e0593b007e6bc2316dca27686d07ed5c3d262a5fc0fbe7c439f45f88fc218abb4fac443fa7d8fffa2c96c7521f7abcd54e1c78b157ed9b50511b09c01', 'AC', NULL, '2025-10-03 18:42:00'),
(179, 179, 'bquitama', 'f4da26305a3fe1bcc2208a9048860165390bd8c5c532892a20fd7e768eaba1d7c5e5b50bb78fabda178316f18e647c1dda2c29936ef70c4981d0e9882953ca0b', 'AC', NULL, '2025-03-14 22:09:00'),
(180, 180, 'aramirez', '230afacaf2cd2d4af570d526ebd5007f8705f402cc674a15f21433b060e3b998130a3f1dc03252ee9ca925f14825a409e18ba7703579592182a0c30629f971d5', 'AC', NULL, '2025-04-15 09:37:00'),
(181, 181, 'jramirez', 'f6bd9eefea0f28e975e76faec269bd3622d501db9dbfa29627ce3500395c164b2bd310e9bc8cb5551ef302c45399c7e15aba9426dd823cc6a6ceb736ac86a71f', 'AC', NULL, '2025-10-03 14:02:00'),
(182, 182, 'aramos', 'd00372ad7dee4b5a710621355fe1331a8d78d9becadb1bd8c846cbf096205d4068ac0964edfb1cd97b8d114ffb3372f93d9b52e11153d83bf9db5a6c942ca917', 'AC', NULL, '2025-03-17 18:19:00'),
(183, 183, 'rrecalde', '1c793a66c42f0bb2277cff095c0f5c6abaf0e8cc96833a1217f7b7ee35ab8265c18fc62da010ca71c09f93792a45e221c8452f383813c6009ccd725843edc125', 'AC', NULL, '2025-11-03 09:32:00'),
(184, 184, 'frevelo', '930f0ee4cfbc11d06fd7ea79dc4f0668ebfef2fd993ff900582244c11da9a8916abc413f8602d7bbef4ce2bd03fc10c53af1b5288bf0e371774b69c363676373', 'AC', NULL, '2025-10-03 16:43:00'),
(185, 185, 'trevelo', 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe', 'AC', NULL, '2025-03-17 15:14:00'),
(186, 186, 'drobles', 'bb24f2918a86a010355062e07e904e8fe410d1f895662c0d9128fdc0dbd7890baa191f1d95d6b7f8b4e80328f9ce3426299749d9ffc5b887dfec421b9ac0d5b0', 'AC', NULL, '2025-07-04 11:13:00'),
(187, 187, 'prodriguez', '510477ae9be213faf470f1fe012746127a255615b8b6aedd386adcab604e1279dbd2b77d1de6c3c092826ac2f1c8e85598fd4413ede5c064c8d48d2159e9d074', 'AC', NULL, '2025-10-03 14:13:00'),
(188, 188, 'crojas', 'cf5c53e31c310d118ebe20f143915f20a662c9ea4d5fe09772954c126af830c4c4cdd82c1407ae773baacef855152743d97d3b0b889b1083096ec45a276c5193', 'AC', NULL, '2025-03-18 13:22:00'),
(189, 189, 'eromero', '0f83bec008baa4efae0135ba713ebffd7931a62beac331ed565d04157b9f2db2f230b50c6cbd9aa988d1db3acdaac45514c02cce3e26c5057dffd3e39b58f1c3', 'AC', NULL, '2025-10-03 18:50:00'),
(190, 190, 'frosero', 'ddc9dcb89207e88f650b6a606a80533e10820cbba72a1eb3e258d11baf01527ea08cbf7fa522abd44b44b8e52501535f323dafcc71b07a6b129508e6708b0975', 'AC', NULL, '2025-03-14 22:27:00'),
(191, 191, 'jrosero', '27957021f53625f8ad4f73e72c37557924c5ecdfea93801dfebc4f7be231c05acff43f99f798a32232b500c75f3843a06c5ba3c1d6a3946369c179b770dd8dc1', 'AC', NULL, '2025-11-03 07:25:00'),
(192, 192, 'dsalazar', 'ca460a78956c3ec080ec8cb485c6ae3a905bd8e28054b6163f1e40dbbef433af85101f5b3163e5973fd643ef09adfc56f15f89b409cfcb0ba4a844aaf275a4c7', 'AC', NULL, '2025-07-03 15:27:00'),
(193, 193, 'isalazar', '60edc10ac265e80ae85fc528bc889b95200d1caea33c076ff2b35e8d216bedec6ed506bd517729942d67ffa56872059903a6ed1e44ef84e57e30335102366cf7', 'AC', NULL, '2025-04-21 15:33:00'),
(194, 194, 'lsamaniego', 'a8c50b8fba63c281f0b484f9d9fdb10c8361bfbc738b98b57bb2bf937fcce4c33edebba84e1b284ae803ed716777320cc7acdc5c102c7722545b726d3b0be1e0', 'AC', NULL, '2025-05-03 14:44:00'),
(195, 195, 'fsanchez', '39fa620fd0d3adca032af293ce66932d1c12444194adb95dbfce5bbfc7bb02fc9f752b898465e67bedc9c66e7456086ab52adb5d9ac3fa32c1383c91030afa54', 'AC', NULL, '2025-04-15 11:05:00'),
(196, 196, 'esantos', 'e21a91d5a42a25f481e6eac7e7f6d0712220a7864f668fe5cb511ec7ef40c023ff1349ecf1417d4011c3227b244ed6434611c1cac5a580ce7378180e2b023435', 'AC', NULL, '2025-10-03 15:09:00'),
(197, 197, 'bsarmiento', 'cd85626826c871119b692aa57d97c3a26a5a506af43d177c2fc513bc65d9bc5aaa2858803f518519703429a736d4d82f9fd06155155f793a2b934c331a3c83e9', 'AC', NULL, '2025-03-14 20:16:00'),
(198, 198, 'dserrano', 'fb474ad0fcf4cd259a122548ede8432a83321335427a6ae965555f6c047f09f8e56f7b5adfb05d6638ecb923cd521f2638ef208b043ed45c25bc4cca892bc9d3', 'AC', NULL, '2025-03-13 14:06:00'),
(199, 199, 'osevillano', 'f89e43409a20c5483ca7e82aea8da8c96274362da68900c6c6b4c612c5eb8a78fff3f07999103c0df0f64e044115332f80e8734010a4086a6e03158ff69174a5', 'AC', NULL, '2025-06-03 11:54:00'),
(200, 200, 'bsolano', '37c3c710fdbd489b064057de6ef6947d47a90e8a32dac7c8519c02d1a1e5af1f8bfca5f6ce026b98ecb63c38d56cfc2e7b84eb2adb11562ca0195d1f305ea443', 'AC', NULL, '2025-03-14 15:16:00'),
(201, 201, 'jsuarez', 'bb826af8e18dde420b01afe72d8ed03345ce32826959bbf6aafca33f4685d503c2080d0003528ee029712d8c51318a02ba2b561423cb929bc3f86ca8b3783825', 'AC', NULL, '2025-05-03 17:21:00'),
(202, 202, 'jjsuarez', 'f8a35dedc6a955ba0f2579d1494914d4573f2cc57625a679cf69c7c86ad12ff79b9110ca46a4668b7a0c0f7affd5d76dfa81c4ca5ed13aadb5fca6672175db29', 'AC', NULL, '2025-10-03 12:00:00'),
(203, 203, 'dsuquillo', 'b5b4c6748b3b12649b17d6bdb78efe5f34b8e5a2071d7e9fa36a500b2d2ab8d70d9b0e1b1a6e70aa3a8306a94e7a8b4144e716e8e091c37ae45593f208312ca9', 'AC', NULL, '2025-10-03 20:33:00'),
(204, 204, 'starapuez', '6fdb41347a8dbc263947e4ce661f1efc69290d2b89619bcc39c52c125f0eda04a40b9d62d8f1ec0ae6e3d1e7c220f9c5a1dd74a4ef4e14cf79c333fef6c44426', 'AC', NULL, '2025-03-15 06:45:00'),
(205, 205, 'lteca', '019abb1d9382bda4e529e85b8216d98cb1b750ca0743d51e9927beeed4b16b589431609d7b2a6a693385df1ee3657e9c4b4a1794db60d03b543e2362a52ffece', 'AC', NULL, '2025-03-15 22:08:00'),
(206, 206, 'cteran', 'cd845e65c1a39311143adc02c8c661e24ca7b1cbca590e6382088d17cad41ca530aea93cd92c0ec71071d45c2d943cfd7779b6d47a74d784236a3c6831e23f9b', 'AC', NULL, '2025-10-03 10:50:00'),
(207, 207, 'ateran', 'ba61702688430346dd80f585fbf4896c9b5aa37d2ebfe0e99ed878cf3dfb0909e8f2e9ec187e81e74a638b3e0323f3e29ea4b4d571805f4384f03ab2b8dffc8e', 'AC', NULL, '2025-10-03 11:13:00'),
(208, 208, 'aiteran', '922265b8ba880307ddfb40558b0addbdcb7caded55cf8b8063363dc7d2231c12727711b8d7c53771bd08b91a949293bf1f3761f5d31257ab38b86274d9abbc82', 'AC', NULL, '2025-11-04 20:50:00'),
(209, 209, 'ktipaz', '3341e54ef453ade3126dce12fecaf20e3813b950af5fd36d7c3b9ebb41c12719f5946b62dad90391991f56d53562391d696736e5096e83554117f9bf42e31368', 'AC', NULL, '2025-03-14 17:15:00'),
(210, 210, 'htito', '454943388ce9e9c51c473a0354adfe19653caafb1e671c188fd674cb036a2c5af75018fd05ebae24bdf74a52dcc20b9668a35d132bef990dd0634a283f7777bc', 'AC', NULL, '2025-11-03 14:52:00'),
(211, 211, 'rtituana', 'a42af5d3d20e7d566ae6cafa7968c08dc2d6d4970bea4736d89b89765a0f343738e8a8fd687922669ec5d3d78d1e41472ddfa51179a6964e5d4cebe2b92fd212', 'AC', NULL, '2025-06-03 09:32:00'),
(212, 212, 'stoapanta', '', 'PA', '217eedd1ba8c592db97d0dbe54c7adfc', '2025-02-25 00:00:00'),
(213, 213, 'ntoapanta', '661cab654c00900aebe4b18a3ea637214162af323b931df4ff24051b67143e8a667fff1bbf92e806417b85a4a8f5bacefc147099316a66371c610ce3e42594c0', 'AC', NULL, '2025-10-03 14:36:00'),
(214, 214, 'rtobar', '92832f03c881be5c03552460b01c3b5d089fe5ec59d5e4d80e71890518a7f95529530b49557cc97bb1a47a51fa6d4cb2375242c1b735f196eb416eb01d0e2ab2', 'AC', NULL, '2025-03-17 08:51:00'),
(215, 215, 'ftorres', 'c3ee37212e3f620e5c5250a362eb984ffe0c6f05f2a19824b6e598c3fe341dece1b806fb295ee6e45a1ca975b58efd73587d2ba4dc2e448fb1594554ee5e86d5', 'AC', NULL, '2025-11-03 09:48:00'),
(216, 216, 'ltorres', '2a48a49457b80d417601fca53268a5625b40868fafcac865ab6166a67cfcef386ff8cf2047ae63db91654dac968802d55e295b46d93004f65eca5488f07b7bcd', 'AC', NULL, '2025-05-03 14:52:00'),
(217, 217, 'vugsha', '12eddb4b31e470b0f95f1d3694b25eef1d164142246d054dec5d67bd1030aeda691a75700979db0f81372a478b45f8d0c18ea60284cbe342880ab830adb50d95', 'AC', NULL, '2025-09-03 21:19:00'),
(218, 218, 'lurresta', 'f2d02b5f96570fdafea06835ff02a6e1cc252e2445416bb3726d585de75b62ea51f19c684b0752f5431a77592736c9851054578227c87ba6a8c1553a1e69f34f', 'AC', NULL, '2025-03-20 14:09:00'),
(219, 219, 'lvalencia', '5fdd04a78f20377a3517711101abf991ecc753466e46080b95d4eb31267551f787aa1e4093ab4a8a3a2784a931a04cf9e50c5d950b91f00081aef18c8022dcf6', 'AC', NULL, '2025-03-14 18:04:00'),
(220, 220, 'jvalenzuela', '258fb7b733626ca88b8d0ae74f899584e9ea91245642e4ed5bcd16bcb16d17926b188038488391d0165806c1c37d26a691a38a32d5bf0dac43d367a140824fcb', 'AC', NULL, '2025-05-03 15:22:00'),
(221, 221, 'jvelasco', 'f5554e9368f1cc8573e6e5cd52306ebdfeee62f1d9526ad1780f8261d380d1b9dc3aeabd67383e31bc5e638e4692a8e20e73eede78a5e17e9c99d3b274cace5c', 'AC', NULL, '2025-10-03 12:28:00'),
(222, 222, 'jcvelasco', 'ea461c01270c2117501c3777b60be3b347f23375b97d55df1fee26c62537b0f1e03380cf0a49553bf1e9ccd1950d05a8a475450bcd7c5217a416bb58379962a8', 'AC', NULL, '2025-10-03 15:03:00'),
(223, 223, 'evera', '88d952e7639e0274f48fe6e4df96385201a357062854a001f7b8ca1307d06a2602c056bf386eb62209a0871c36990c829e1a02a932453e161e9239efb7e456d0', 'AC', NULL, '2025-05-03 14:50:00'),
(224, 224, 'eviana', '91122ffb0c0d3db844cfae89801d713d6c79581349e4554f269655609db7f8085d37f7061f5ff6f986fa5f878294a65afea008bd8910c9f2ebc5aab35ed73ac0', 'AC', NULL, '2025-12-03 09:29:00'),
(225, 225, 'jyacelga', 'a470bc8a52ed22d2bd40fb0fb0caa618a9028010e4547b9213710ab57b9828f2863b4b1b283ca5175763fc9f70fd4cf8ffd1768c86bd667c550a3d4738ed21ea', 'AC', NULL, '2025-06-03 16:31:00'),
(226, 226, 'jyucas', '310e285c919e3020929a667b1d7221bce2d2e5ecca7cfd7c3a1799299a4a5fa45b3fdb4b675653e156e8b99c66efa15d706f56c56688f76ec7d66d5067a3a1c4', 'AC', NULL, '2025-07-03 13:59:00'),
(227, 227, 'vzambrano', '769e84a190b38fd378634840f6fe9a0dd60f24dfe09a62654e4bb92310cd7e248af3eb79922db3d29c5be1f87b0683e13b239a2f64239326567730ac28aac67c', 'AC', NULL, '2025-06-03 16:16:00'),
(228, 228, 'jjacosta', '6c734eec3edd1eac4cd64b4ebc9e7931d5c29004224165cea52e1c4586f675b8d9cdfb10c3d764605c27c4991d5fb7264ab3e4abb0cc0f21b0f7040c4a2645aa', 'AC', NULL, '2025-10-03 13:01:00'),
(229, 229, 'ealmeida', '8eff748740d36968eabc6986b61f3670abae83fd8fd163027ade941cb630e5dab5ccfaa8926cb168a3ddb54ac48956f43122eca7110db664a8e45def50f994e3', 'AC', NULL, '2025-06-03 06:10:00'),
(230, 230, 'ealvarez', 'd0c8fb74929fe1671703c247cff9d1bed4f7a3bb90c855b693b27d77cc152436e762bbcdacab9dd0816c2914c9c6b67410ec11acd216db18eb825cd30c7fb234', 'AC', NULL, '2025-10-03 12:25:00'),
(231, 231, 'mandramunio', '2919ce763abbdb768038eb9a89716b3a1b57c0e34e3a9e88c7bf708f3476dc12c205c5269e1f2f347bf52593343388279f548f6bfff39c6f1cb0fe565c44e0e6', 'AC', NULL, '2025-06-03 15:54:00'),
(232, 232, 'aaraque', 'e38586dad400c53c04b86311e72d58fffee8cdd11a94c69152ec94ba068f3fec1e0bb27851c2d0040e3b09353989766a81de2e2b85aa1989634e40d3632caa88', 'AC', NULL, '2025-03-15 06:24:00'),
(233, 233, 'jayala', '8ab650e5f05b918b3dd093bbd7ca14d8f598ae208440cea5b01c198cf29a74b072ce7152bc1fab6aa81fdeebb0f2af209d9c9682d122b29d867b0aeb95defe27', 'AC', NULL, '2025-10-03 09:00:00'),
(234, 234, 'lbatioja', 'c07aec7e5010776079a7776b56157141cebec9c37bd0d4785f47174d18db0dc1022016cf5456e6a039e389bd9f0957878ad4c5c54d3925de2d1bd963580d92fc', 'AC', NULL, '2025-11-03 09:11:00'),
(235, 235, 'kboada', '6b0116da43fad9d1f775e1ba32f3dc11e980911c1fcbb47e6be990b29ece0c2cf986eef4b40890a41877e174a02eef583a0f02227a1f4a0ead7c6ef89e0026e5', 'AC', NULL, '2025-06-03 16:07:00'),
(236, 236, 'jbuitron', '894483dff6b0210e73ff711c9f0cf3320bbc06364b86a755fb97de2e92fc3b08e5fa0ea42249938d28a64c343f3bc9d095f24d389d56134e85587be18c621973', 'AC', NULL, '2025-10-03 21:00:00'),
(237, 237, 'mbustos', '0571e53cabec28d27210b745236d467c5e0a765e885224bf5f0f481414184ea75fddc0d399e0024746fb232635741439ab80d65aa2aa5dceedd6113920b7e8f8', 'AC', NULL, '2025-06-03 09:56:00'),
(238, 238, 'lcabascango', '6942f1bbdebada0eb70b42ab927c37b3d0641dd9594c8ade7d117efce8a9834c9df60687f9efd39160614660946f028f54e13dc83deb75cf02361558b30f7a20', 'AC', NULL, '2025-11-03 22:20:00'),
(239, 239, 'ecaicedo', '01ee2ca741c79e09c370be5bcd7c17142d1bed1898738dca161221bc95519d804a85bebc2efbe0d6eb31ca244c72514a689acc184b26489215ecbb08fe62ea7d', 'AC', NULL, '2025-03-17 20:22:00'),
(240, 240, 'kcarcelen', '406d1ac5ef859ddfd686559c0892bab8326a948180d221ff90ff982adadfff073e23d545fb6257b3c78a0fa792cf3e735016ecdaa32fd419794964c0738b0c8b', 'AC', NULL, '2025-03-13 13:53:00'),
(241, 241, 'lcardenas', 'b7406127dc0646eda9a906125c5d7234c1e0f4838a6c98ca206bce03977c8b7e9e67b3177a5f8e700dca56c3e20c2f52c71e6d06844ddca448ac5c5ace8bdb41', 'AC', NULL, '2025-10-03 10:03:00'),
(242, 242, 'mcarlosama', '1eb7d286448c572ef8a098bac3bbebef37acdd209149e2fb5c546e11d90cb45f06c12811a0a904303a8995373668f385ff6f70417dc83adc965d1c7a6cc6b58a', 'AC', NULL, '2025-03-17 21:39:00'),
(243, 243, 'mcarvajal', 'eb1bd45ec4f0a2f74405327e86c352e00c3c71afcfbbc3b4ca750e66ddc3741e540096108bf9657bbf64714dbb2c1614eaa398bcdd40e01c2d7b10006e1e60fb', 'AC', NULL, '2025-03-17 08:29:00'),
(244, 244, 'jcastro', 'd64b05083d4ad74113b27178d70f7f5cc2f5ef2d25877c368a7bf35efa8cd62b5e96c0b3af0bd9ddb511809f89851afc9c07a4ac4876e3e8b93878d80e98eb6d', 'AC', NULL, '2025-03-18 13:42:00'),
(245, 245, 'ocastro', 'fde0493bb38da78f9a7916895a52a1283ab129f7070e0ea0e437f6ded62f84476f12f80375f4a2347594aa446c667717677d22a6658962f461c9d9cf08d73858', 'AC', NULL, '2025-03-15 16:45:00'),
(246, 246, 'echamorro', '36aa40c02502de481f15568b3276cd71f5609555641f6b23f615d9ed7997bcb73221d37ac2a6fe17f4e4449efae75977d4e2f3230e347a913cb653f146c6fff9', 'AC', NULL, '2025-11-03 15:02:00'),
(247, 247, 'mchavez', '9868034d0875f02eb72b33d1c804d345029a4e31a3792bb3dca65c734a05ba37ec3f1587d879928ed94f2a850c44d272a89bab233b161be86fd4ab01e0914b11', 'AC', NULL, '2025-06-03 14:40:00'),
(248, 248, 'echeca', '8dc2318ef7cab8764a833e682186974b7e612336505f5123220334c72d8b9f51174b681ac589fa93eb603b191ea1c80809f67e440428cc10cabd0a4c278623d9', 'AC', NULL, '2025-06-03 11:29:00'),
(249, 249, 'lchicaiza', '4415960e3dbded5d0e6b1f9bf412c3e7b057583fbb6335de8477cf0a819f8e95b66c9fc4da6d4e0cf81b8c70ecfe095a611b3214f8380474757b0bc15c03b91c', 'AC', NULL, '2025-06-03 19:32:00'),
(250, 250, 'dchuga', 'bf1f38bb085d2abe548b6cc434c299cba9ed44348e37c06d222fad239e07bdf45095e7a1ee8af00172e6bcc00d7eb45f04ac1877b5614fa2948f09574f555647', 'AC', NULL, '2025-11-03 13:46:00'),
(251, 251, 'bcolimba', '2040a7f922e48f1d99f5b87ece7325355d39a1dab8c61fbd43b19bc638784844651735448f77138194202a62060629f9a96355d12318961b8513aec3d8eefcb9', 'AC', NULL, '2025-08-04 09:26:00'),
(252, 252, 'gcongo', '425fec0ccb10afec9ce57a5ee9e78ec769da362da74f94a6a7fb17d169161ebdfe088abc1272d653ddcea750c8a78dda445088eced0f35168db2ce499bd7c25c', 'AC', NULL, '2025-11-03 06:14:00'),
(253, 253, 'hcruz', '8d43df365d052ad718011a6d00da5ad9d75d55f24255281acbccc81440a7a288f45a8ddf4b2a25dfb9d6f199498a227f91638135b24b977a72853fe4ac3ea97b', 'AC', NULL, '2025-06-03 09:12:00'),
(254, 254, 'dcuero', '351c1d89387d716024efc240c15da85baf639ab432597c3e7af5ec09b002860c51796ab2b6c1c097fddf28d558d3e9fe6d16d7ed9b2784c006faee47d46d869d', 'AC', NULL, '2025-03-17 10:03:00'),
(255, 255, 'jdelgado', 'e60f739c9ef1dfc13112d3fbfa5e1bdbe7a3f947f195bc9c358208ae4b4fb7e3d0df527814cfa948ba2f86c1e7c2bb8c401b22ef056ff9b42512282cc0b0d80e', 'AC', NULL, '2025-03-13 13:53:00'),
(256, 256, 'adelgado', '45eee10b93b7a7c22ddb1a62dfff10d881f851b8ad381fd7c9d29d7b38fa2a54336d8b10c7afc5468ae7b4825163ee7a85dbd54362c3cfe909fae6538e62615e', 'AC', NULL, '2025-10-03 12:40:00'),
(257, 257, 'cespinosa', '97b149d13466f11ff3353c1183dcfd0fcb7310c398c1d01bf013652ae9336a69ecd82fecd2d9607cc289423745549df9bdd42912945866e59df341ab55663101', 'AC', NULL, '2025-06-03 14:00:00'),
(258, 258, 'restrada', 'ad47614b461095584b10e35b786ad232f3c85bda013f8ecb76b629f298d4b91f79bfe4bc8d36aeeff21285b39b0a60c89792a72e25994b5ffa4d957908e47b9f', 'AC', NULL, '2025-11-03 11:18:00'),
(259, 259, 'jestupinan', '31166dc10b8e185f46a08c6ef712fef83716d534d5acae7f1c7c42f848bfcc39936640beabcd515d937ac700046b69160016a2c090b11d54c0e4ac61cad72dfd', 'AC', NULL, '2025-06-03 14:21:00'),
(260, 260, 'restupinan', '93cf6da5be541ba0c65b26f869df4d1255cd4ee0382b73cf45ffffabc7ef6b418d633f1896f12d89a3223661855b14785c4f58162ea8ece8d553da4ffb2b2ea4', 'AC', NULL, '2025-03-17 15:50:00'),
(261, 261, 'fflores', 'bd96d3418731601fee76f11d2b9d2f0600cd9a2afd5e4610c160dcbc7cc53bd5630da2d33cbd3032242cfb2091a3d2693eca89d4fe11e2b9fd444fb02b093df4', 'AC', NULL, '2025-05-03 15:39:00'),
(262, 262, 'rfuertes', '41a8aba193843abc4151e6c8f15cfcda1c430fd66681ef8bea6b878d9b342be3eb19667e0d32821a1ac56ba076fa71894584d5b1375dc4632e8c81a10bec992c', 'AC', NULL, '2025-06-03 09:37:00'),
(263, 263, 'fgarcia', '8fc353afdd78b9e48952b555c6139a12758e8d86b776542afae1e006de69a91bd40eb6b79c657564f7451c8c4f7c05d1e85edc5a0432caa5c614defcb1d9f162', 'AC', NULL, '2025-10-03 10:50:00'),
(264, 264, 'cgomez', '702389087d6135151d1a962b99fb6339c131f006210b417534870711a7a994fcdf66ff966a5c426dbf652bc853702acd645d0bd88b2222170dd32de12273e2b1', 'AC', NULL, '2025-03-14 17:57:00'),
(265, 265, 'lgrijalva', '4945b4afd19f0e2c81a8e0ceb5da81482ceccd754cc3846fd13d991997587a173c7d6e7ea1ac140d125eb1251c555e9b96600351e7d02de36700a959e23c9ddc', 'AC', NULL, '2025-03-15 06:01:00'),
(266, 266, 'kgudino', 'cfd202ad3bd696ef6be8b3c91c716c315c013648974e499dca0f7172444ab23a7b50ad0ddcefe679d7e9a89698d777aad30e97f53b2d5fe705c08ef0e9d5e724', 'AC', NULL, '2025-10-03 12:10:00'),
(267, 267, 'tgudino', 'e87c203e173a75593b62e833109ecc41bbe337b418d1c5a105b44fc5ff026ad1b0d308fe31f10db209377b3a547bb1d839ee86adba9cc02fff2f45732ef4e0b8', 'PE', NULL, '2025-10-03 11:22:00');
INSERT INTO `usuarios` (`ID_USUARIO`, `ID_PERSONA`, `USUARIO`, `PASS`, `ESTADO`, `HASH`, `FECHA`) VALUES
(268, 268, 'bjacome', '9b253defbab67e56c63abc4fce7a10f2d4ec75a46998d156b89d14e1eb76b596b10165945a35b866cc3075b0e202e9937a17a5ad1e5b610a1bc4a8568c7eed35', 'AC', NULL, '2025-07-03 07:46:00'),
(269, 269, 'wlanon', '49c3e3d62c0fd006adef64459d2b0f699bbe3b1baad0a9e944293839635c0e5eac5006ad7d3bbf830d02c71f0f730ca426b233c598f189f380e21d6edaaae398', 'AC', NULL, '2025-06-03 13:47:00'),
(270, 270, 'elara', 'c93a7108af05122bc437e4e70f95b1fb48b2b12f1186d27859b91adb1d322013c6a4dbb1dde6a4758143a9576e4a03ab3fd7e6b77773bdd95e8d11584546ca2b', 'AC', NULL, '2025-11-03 13:20:00'),
(271, 271, 'llara', '2f4dbb083017add3cc723d90a1539f35e4a88e3ebce4dc6d7334beef077593f674221519bd39672825fc512c181dddd662c4993d634d9e20aa8743899487e9ed', 'AC', NULL, '2025-11-03 14:54:00'),
(272, 272, 'llatacumba', '43307a17a0dcaba5a7bb7f3070e3daaf0e44614e9e3405afaefe259e88be2fd169960bf22accdfd90a8967c227efac8f9016f7f8b1a8783aeebeb7c661dfaccc', 'AC', NULL, '2025-10-03 14:31:00'),
(273, 273, 'cmarchan', '1ed16bb18872babd775e73bdd0069a28ba244f0e04e2092c24d09acf1d850864cc64dbc60a59b759f53bf147eafc196c554c71d1af8358bd5fd63fcfe9380e71', 'AC', NULL, '2025-09-03 17:55:00'),
(274, 274, 'mmartinez', '19e03f80a3dbd30d0baf67f8e7162f5afb61b71589ebad809af25563c2e4edc3a22e8cbfcb6ff6cc029c50feee7004e028ca5ccf36d472891d66f1d454356389', 'AC', NULL, '2025-12-03 11:35:00'),
(275, 275, 'cmejia', '0c517007a7f9b2b78286a11feecc9efeef7eb727cb7d484d9288647f76da19e970f9c09cf0a7f46344a26220af188a162d5d10e3f4c27025238ac368ef0d1e58', 'AC', NULL, '2025-04-18 14:15:00'),
(276, 276, 'smina', 'f5589990f1abd7228c7bfa5dbea4a95f9e5abbc00f1255a5dab158165a65125d862d4536246199bd6b989b5c0d42d20f9eb49ba0febf66f6bc60340162ec3b64', 'AC', NULL, '2025-03-17 17:29:00'),
(277, 277, 'kminda', '464c7efdaa28b0f37036d59affe1d1e5b9e156af3b861100d96772b57f4d941188817408200ebc3697c8d4b92ace9f9e1def1e4809c679751c6c6eff522c4042', 'AC', NULL, '2025-10-03 22:26:00'),
(278, 278, 'aminda', '5a4babf8375a7e08af485764e45bec8127358eb0cacc9b02ba3f94fe833717d815e454d85e272fefa891e25ebc100426093fafc2f46d34ca0d505c8aa4ea2ac6', 'AC', NULL, '2025-03-17 10:47:00'),
(279, 279, 'amino', '04f784c448512d6670e50ce3dc26308868abf1e9cff8d7780c006b5e733e6e23251f2e0973addc3d11874a243449c32ec2fd26869c77a8ae8adbed1b24d51407', 'AC', NULL, '2025-03-15 10:58:00'),
(280, 280, 'emontalvo', '36002a64403405234921540ef51e20af61e12ff34cfb2ba887d5c74d077b8cbaa9dbdfdc7ba2fcfac401b8c485c5eedc99c35fddab4b141d0beadb87ba1803fa', 'AC', NULL, '2025-06-03 09:48:00'),
(281, 281, 'jmorales', 'ec594a3fa31803f58a7df27f6195ca86bf38dba8a287bc5e5f51148b92eb8a79303220bd9906726992efea85926d78fcfc8d2c58fe67da77cbcb99c2e02dc4dc', 'AC', NULL, '2025-06-03 11:01:00'),
(282, 282, 'aortiz', '4b9197dc275292f218aa18df5ec369eccd03e7c3d4be1afda5f78624ee4ce1d352ce8bbae1290aa18c024cec052bc2aec7ee115bb7e5dd70a597aaac8e5a5183', 'AC', NULL, '2025-06-03 13:44:00'),
(283, 283, 'npacheco', '5c003e18130805db9533cff58692ddc48e8d14a5c5c71095cde2dba90fefa14a423b5df9269b1c950de6e6d6c0456c2339424ba2b0fabc86f41e76133eeccd35', 'AC', NULL, '2025-04-15 12:50:00'),
(284, 284, 'sparedes', 'ed79f6ee92050b699366b161489f030b51561c0398d77a9533348717ede19dbe4eb282f898fb6799e5b4c54fd27d981b5566fc7690e97869c8cb14927eacd5e8', 'AC', NULL, '2025-06-03 14:47:00'),
(285, 285, 'eperugachi', 'd2923643f9789f443051474cc15113f75faf7ab18707e5f2aedef43cb27d7297b05f20de7f8844d2df1ada29e8e55817797eabba23045daafa2766de865ff586', 'AC', NULL, '2025-06-03 11:41:00'),
(286, 286, 'lpila', '6db2826821f25b67dfd77346437b216e77cb28bd7a3a24b4a57f8abc42ea5543c2da5540b4f47d012409bc5b19361371ed74908a419c3108d28ba16f3d9fdeef', 'AC', NULL, '2025-10-03 14:13:00'),
(287, 287, 'bpozo', '7a79a7b77531c5b4a877b3e127be5be69e406f2d4488713567d23eba70a5c877a29c53e34855ef3d5f1abf69e8d30f3493d264cd90f005640500094a428e1b18', 'AC', NULL, '2025-06-03 16:38:00'),
(288, 288, 'hquinonez', '6dd4dd41091b208e0e56b88f7d0f0877b6b5b1163917e22269c29fd615c92d11dba95c4afc62571af68161773715f2b71a50106538fdb4dc4bcc65d92ca04dc3', 'AC', NULL, '2025-08-03 14:11:00'),
(289, 289, 'mquintas', '5a3b220d2151e6d7cbaba1e1520c723402d98ad7bee19354a6ebef9a9631c106c77a98c8eec07790b3d26727219a9e19ca200a3ce63febc88af69858e11efcb3', 'AC', NULL, '2025-06-03 18:28:00'),
(290, 290, 'rquintero', '7ab4f77ed50436fd3da46198e75ab323161a770e2fed12bfe5f7e6b86bf1d92af909744a43801abe5abd4386542ed4e629e6daf8094b1b2ca3a947e944dcfce5', 'AC', NULL, '2025-03-17 10:21:00'),
(291, 291, 'mramirez', 'a1a6c58c423019950ff1227dbfffb32ebf2ef549e01c4d6cbac986ea151d322ef584ca3c7f5bea926aeb9c9ca6504e62c797e7d134bf19f08a30c2d0b3465842', 'AC', NULL, '2025-10-03 10:34:00'),
(292, 292, 'jramos', '2d1fa52853a388b4289d6a91d82bad7188d0a1edbfaabb390610f01d3bfd1034b5893d79e7c1037aedc504511203aded92e9be88fe0a1eebae592538ba8a2a82', 'AC', NULL, '2025-03-15 10:39:00'),
(293, 293, 'jreyes', '1e6dec53dc485f345a6301eb295cd793e9a393f795d025a00b76124fc889456a5d218d9c15075ad172a49ca4346ed8f812dcd41b5f4d55139553ed63b28a1a0c', 'AC', NULL, '2025-03-16 22:17:00'),
(294, 294, 'esrodriguez', 'f14fd3b7b3709b89d29dacf867a8967db44df8dd2cfee60b9578388648d87bd72d440345c165491a39fef7852890421c8b9172862520659288ce0852e912917c', 'AC', NULL, '2025-03-18 08:09:00'),
(295, 295, 'edrodriguez', 'a0afb7dbe3a8b0f75ba342d6f0f37b052be638ac0df420b0ac2a929692222f74d1df0324ac51a9ff0890c7079f9cae807860574e192a621c93e1488879563643', 'AC', NULL, '2025-10-03 21:41:00'),
(296, 296, 'lcromero', '0d53e59ddf9926b1194c738850d974285e9fd46550f6553e9791c118ceca5c92b3c87e1a38f6423c650713dbd271a4d77ef2e72638534a42e4577e9e6cfc5aef', 'AC', NULL, '2025-03-14 17:45:00'),
(297, 297, 'kromero', '56d7a1cc6853a72a01d409206ca720894d2c8e92097583aba07b69e1721545fd72a3766b2d7a789b84e66ef4dd5f7beb7033540d9bb8de68eae994903a28ef12', 'AC', NULL, '2025-03-17 09:27:00'),
(298, 298, 'dsalgado', '833496d91bf2fe0b6259023fdcfcbc6d7da1bc98f944dced92a62c26a0db773b46d07d88abb8aa7439a3aa1968352b1d1d39e0066fd0d683663f39199cefc70f', 'AC', NULL, '2025-10-03 11:28:00'),
(299, 299, 'esegura', '881b00415f632529c5e78cdc71571be73c9cecbb435abd2e51548abf112d7aec30c3d92ea57a2d4e7aa07c51ac07e08247e0af051ac4fb1e4ee8c3cfa6d30540', 'AC', NULL, '2025-11-03 00:05:00'),
(300, 300, 'lsolorzano', '63b6c20399df624fb9b970f55738d03fafc780f3d438add82582ee36d3c96d6686376366c5e4340cce05aa66ea1db51a297d600f3d05ae8fb39097bbd0ebe655', 'AC', NULL, '2025-06-03 12:58:00'),
(301, 301, 'asuarez', 'ac26a50c6ef55923532162d83060e0ad9fad21fe7af0853a2f378ae3f878b0b622d1c5d4b99b319c64b26dbbff743a3690c5ee976ef7d6059275ceed0e9a6326', 'AC', NULL, '2025-06-03 09:42:00'),
(302, 302, 'ctanicuchi', 'c7ded87aa4ee6ef668d313148b5d6157d68ea439bb764458177478f24c48c0e6bf9b1fdf014285d129c6a4f6aca430c31ddc44767758644b659a140e749825c2', 'AC', NULL, '2025-10-03 15:04:00'),
(303, 303, 'mtello', 'c3fd72575b910ef7527a9b6dddccbbb3b6d213dd32fe472dc75c3e63d0c986a382e7c5da5ee168279d78951f62e57adf7d2b0dbbb57c556e4fc09783a9ef7590', 'AC', NULL, '2025-08-03 14:08:00'),
(304, 304, 'lteran', '1168cd1930879fa30ccace2aa2f6c56af24fd0492d5f944989f55b8e16301aa3001ed669350507d65f942bc29dc76bf7c9e49e00b07fcd7471b598075cda7c96', 'AC', NULL, '2025-10-03 12:32:00'),
(305, 305, 'btorres', 'eaea4d94ef8772a173fc907d78c6fbed636024e67c718cfc692f78757d18c57e25498329747416d267cc3fa97ff01598c779422aa592681ef68fb510ec42d14e', 'AC', NULL, '2025-11-03 10:12:00'),
(306, 306, 'wvaca', 'a8690005407045d64be913522250784f015f48acf8861e615b623bc4b6fc19bfe347186bdcb85217755073a0babf5d7ff82ff02829cf32cf87fb9eceee11eab2', 'AC', NULL, '2025-11-03 13:51:00'),
(307, 307, 'jjvalencia', 'd59f2234581e39fb5bc620f124a8de489b1e14ac4ca04b05a64add7a8de746627e16bfce6c94b6899bba80ff5f263a0b267e4028ed785b309f9a94a3ff6a2128', 'AC', NULL, '2025-07-03 16:47:00'),
(308, 308, 'cvalencia', '9e399d6cff6b35b6583a19ab023b0652da7d58ae962ac216ac903feaf2aaf70b304856a3b1e3f2bc7ef18190ae18d45cfcbf081684dc805ff5ad43f215586b30', 'AC', NULL, '2025-03-17 12:18:00'),
(309, 309, 'mvera', '49a835f7cd177d54b13eb7004157714a871f091d42d37db605baf4218c8af920407e4ef3f7ed79fa6126ceb0682366794df56c29dc49df1cfbe6074eeeb59399', 'AC', NULL, '2025-04-17 08:51:00'),
(310, 310, 'dvera', 'c4f74673c240c3b73cb4beea3868348a2441607d5042d4f672effc158af6618de443be7d2b357284a0d1dbff32eda0ce9ebc1c69673ef2ff68ffa7ab311bf878', 'AC', NULL, '2025-05-03 16:16:00'),
(311, 311, 'dvillalba', '0e072b9f122022ada9ada240103c98755949d3a07778f82ad8d5d2df4a439b8c62516f1ace88e362ac8f4cb20fb38ca48f5f3c715cb472c25bea772b2f41d443', 'AC', NULL, '2025-05-03 18:53:00'),
(312, 312, 'dvillota', 'cc63e13285aff3eb39c40f01dbae999609aa80911d55d2276470b931343904967fe47c7980f8aa89285580fea7d3614f33368d1eecdb9a0529988097760f71c0', 'AC', NULL, '2025-07-03 14:45:00'),
(313, 313, 'lvinueza', '95f7b08b30cff32e598f3d05f639e9c50c57d16ca3647a3b0a3c46fdaf43b681fb4b44d9cecbd24d486bfa9c71428626a6381729e9f7523977a624ad528900b0', 'AC', NULL, '2025-06-03 06:07:00'),
(314, 314, 'jeyacelga', 'd38f60f5cf3378216ded29489691cc3c6da3c6418e01eb100a0a18fdff1ceaae335f45fe24786ed7a2964cb21c52814a2a17bb23149b8b39727184914ed2c0da', 'AC', NULL, '2025-05-03 14:32:00'),
(315, 315, 'ngavilanes', '965d6450663df119a475f2e620f5b3bb0f2277e946ed1ab30f1a1aaafbefe3e6fe9606f2348e884361e597710315bfe6a00404c9d4ba292f3d8d4600b1978260', 'AC', NULL, '2025-11-03 14:56:00'),
(316, 316, 'sconstante', '4c0c8c01b3880cd2c6d86aa291b8c4c8878540268728b49436e130211d5202f8135200a440e2cdd68de18951cb8b0c892294d653abf4bfea6fae32c4979cc41f', 'AC', NULL, '2025-11-03 11:09:00'),
(317, 317, 'mguerra', '952ecdb7f56b47617e6062de14c4638f42e255741c643b1637cd62eb3a0833994d2458c79b2a675f79ea5b9e06c5a56e8731dd888e61734a0d14b7b1e557355f', 'AC', NULL, '2025-05-03 14:06:00'),
(318, 318, 'dalcivar', 'c6ad1569d8c6e99db95c7c2b584a17954efd5eb65ecb7d8f659efadb5819f9e0d76088d57219de4f61bed8764e4ae8d6892bd78fbd71210c8f1cce7c372c627b', 'AC', NULL, '2025-05-03 14:51:00'),
(319, 319, 'jalmeida', 'fdb06e6c4e111d46833cb97425e712aaeb86c357fa7fdf0c3c9c4e0d3d663cf88a0172d0d1fc1cb29cac98f4615b44f0e5807137b546f11615a60ac4bee9da38', 'AC', NULL, '2025-03-14 16:59:00'),
(320, 320, 'jalvarez', '29b433583c1b08ce2aab8380411c093b8383dbf9c3c86e148f6eee3a2bdabbf479ae7aa29cab773738a3345aeeb39cef7aa249a20a4a1a40f64984284acfc50e', 'AC', NULL, '2025-06-03 16:32:00'),
(321, 321, 'bandrade', '321df207f25477134aafff681579eed1ef0722ffd4dee2bcc93795161c973f30bf9445ef62122c82961790ca304f0488d38b3d8df1c7b27a821591b200078bf5', 'AC', NULL, '2025-10-03 16:36:00'),
(322, 322, 'aandramunio', '01c2e348b999cd91a0c70f659b1cc430a4284d038ce2dcb7b4696792cdb377b41bf68767b3aacc92a274e30006c655ad3f4439b1fcaac0179dd0519cfabde2e9', 'AC', NULL, '2025-10-03 19:05:00'),
(323, 323, 'manrango', '8bf811bf71b486566bb1caa0f1492b9e5a92e6278fc790227f9e7e96e934586b49021a36a2b0ac573d6e1a7656e96ad8805044cd8fec7045d80ffb734aa3916b', 'AC', NULL, '2025-03-17 18:35:00'),
(324, 324, 'danrrango', '8ce54b37405230bd964ad8ec751fc2049393fc1307c7a7a8b181aa4816bc8c748e2b8180e38dc247dc95b7056ab467375011732f8b0b3c8dc2f26aeafc46fb43', 'AC', NULL, '2025-11-03 11:56:00'),
(325, 325, 'aarteaga', '9d76b34f6a810b7a8039b2dad6273b21cda9774bb6363edfe723ab6683385f69a00ccd7206166f8bdb346575d95f6bc761a52f1e03bed3cf5d3869057a2392c9', 'AC', NULL, '2025-06-03 10:02:00'),
(326, 326, 'dastudillo', 'a5a2a79a9762c0fb7c29a58a7ceddee78d611545d30ea4c219b5d7983db58ee13084cc49203f26ffa1e4dce481d86f09bbb10d4d98db1a84f5ff2565e5a50000', 'AC', NULL, '2025-04-15 09:46:00'),
(327, 327, 'javila', 'afb38fdb68597e3a49506798612e16ec15ad4fd5e67c45f67bb770cac6e6ece512dd1dbc22e046c4c0b9515b277c8b8f7525a8f7124d7afdd1b4d58994c4ddc2', 'AC', NULL, '2025-03-17 10:51:00'),
(328, 328, 'jbadillo', 'c995540809270ee72b051c6571af2599faa05cf9cec6973cbe9af4d78942330866d003d38434b1b98810a17c29755b7b6d8fed0c2ea173f5fc03dcaedbdcdce5', 'AC', NULL, '2025-07-03 14:08:00'),
(329, 329, 'bbarragan', '3f0ac1c7cde8fce011996c8e2ba7864984b8f6f9b9afd986bb789f033853c27e370ddb5005408f113740c14c982379534a2c833ce4507729371e52465c9621c5', 'AC', NULL, '2025-06-03 22:40:00'),
(330, 330, 'vbermudez', 'f58ade2532e7c82c7ed7bcdfdb8710f7da9c28f3c66c082961818e387057ef38ee32196c4af8017f3532ddd95734b0117a023f3117e455cbedf69e66d8cbbbdc', 'AC', NULL, '2025-06-03 09:45:00'),
(331, 331, 'jcadena', '885014468e94de05781f24b621262be7e3a24e022df7be1805a3df5d01d1fae921252e27ca03544e74a5b420e5995b0f7e2fbf4e5d4c6c5b268a0f03c024bd1d', 'AC', NULL, '2025-03-14 17:02:00'),
(332, 332, 'cmcaicedo', '0af94c59d70f92ff157ae4ba13bedc2b9cc8ff0a2bd452964b6750b63419d420ffb88f322d40f62fda0d0584eaced0bfb9fdf95a02a629c2cc0f54492829321e', 'AC', NULL, '2025-06-03 14:04:00'),
(333, 333, 'edcaicedo', '699cef64f16105884a4eb303eaa42361174558915df418bd62f3679f08c41f9090432c7add51a2e450df40528757f29445790bd3eb2b0ce35a636e8022838847', 'AC', NULL, '2025-03-15 13:29:00'),
(334, 334, 'wscalderon', '8c3825fef0d17856f1e04e37d9e7972ff7dd71ea0d45c56ae054432888233bc029b32b56ee06a35ff1738d93a31e7fb3e2e59e2a7e2ada7d31d2534077c4fda4', 'AC', NULL, '2025-06-03 11:06:00'),
(335, 335, 'ajcalderon', 'a166cf3fe56cc7c6cc68a4db5aaf3a68c0ff5785a592ee728dc83efde0b5d0eb00eeb7677bee57f906381460ee93bd3e9e38124a81f190c1bb096f68188a43c2', 'AC', NULL, '2025-03-18 20:06:00'),
(336, 336, 'jcampos', '25e787d2fa8b06c76eef1d536bebd547e04b88c58ee583c77fa1f48a454af5ddb7e45298b61d12bc40977c40c75cd8828d5efaa3c80e46bab2b176e8daf47d70', 'AC', NULL, '2025-11-03 09:17:00'),
(337, 337, 'dcarrera', '39215dcae87de93622f870418cff59fce9f326246e78610fb1ea046237f8df3693ec75ea3d3ba67338fec793c0c80905055d5b56513898c4d8a58a2caca12c99', 'AC', NULL, '2025-10-03 12:23:00'),
(338, 338, 'ccarrillo', 'e8b427c1c72078b611871bfa20141f55bc0f940512b0bfa50768248bbb41dedbd916e803288026eb09b9c024e2a3fee7733566cd96c72f597ed9310ff7a78a41', 'AC', NULL, '2025-05-03 14:43:00'),
(339, 339, 'jcastillo', 'cb974cc9f9dbb8ad26a1a4bab12a1f83143ca4ba104abb622663688d2b7421c79af70d9fb1ee2a2fefdfd38ba97333594eda25c5addc3e1e8105f2d7d0c6515b', 'AC', NULL, '2025-10-03 13:00:00'),
(340, 340, 'dcatucuamba', '0677a13d674ddc33bfd443a7d5f30f7141837517a2c93c99a5febae9d54ac0728f1d7a8ff3e2e7b08962c2a40290c01f7e86e5d9b02a5a7cd94d9f72e6e6ac1d', 'AC', NULL, '2025-06-03 09:42:00'),
(341, 341, 'cchacon', '602b45861441990e4042db247b9cbe6ef917b28629152abf65fec35b835364760328828116a6c38581538e21b2deced1653aa1bc09b8fe56716f1d066215de7d', 'AC', NULL, '2025-04-15 09:32:00'),
(342, 342, 'mchala', 'f053e571a407ccbea2cb9848613bf573da0a7746318085c21f5116fa841a46474a43601ad1feb716b41dd475ac4ac8cfb2c784eddb5064206d2ef4ddd4b4523d', 'AC', NULL, '2025-11-04 20:39:00'),
(343, 343, 'achiquito', '57437f89cb70fa40614f0a396bd1059a312c3ac144029a44b0556b5ce76ee9eb84fd611213dfbbacfcb86d54502b61133dfae438ee00128fa026c29e77b94687', 'AC', NULL, '2025-03-15 20:19:00'),
(344, 344, 'cchisaguano', '819ad64127452ec4f88a4f2165b8758e4af3d96f7a1d50e88c84a198ba363672466e317302a5752ed3c2e5fca2c866f00652cb665e7cd632c8e097759af3b4a4', 'AC', NULL, '2025-03-16 20:25:00'),
(345, 345, 'fcifuentes', '472c2978834f481524d17aa918c7556b8f61486ac9dec1eb9d345474d148d3c8be2f672bc969d7c1bc34edb76fe90e4eba44f996c731435a3c2b9a8d59fa65f9', 'AC', NULL, '2025-03-17 10:11:00'),
(346, 346, 'ecolimba', 'bd9c0b4a5bd5df532f7e27f582aa7f1a110cf1d0143eca7d4359dec6c01cb7243ffaabc23f50c72fdd4af07f850ecd406e46a860755c710c8a50eed6927c5423', 'AC', NULL, '2025-07-04 10:26:00'),
(347, 347, 'scolimba', 'f150108d514ba4c59d3272bbfdd184827f61d8e866751fcd6041f8e70e80aa619b4668fea02a42848a4311611ed84d01c19d78f42056f5754cb7f58fc6ed57f3', 'AC', NULL, '2025-03-14 17:40:00'),
(348, 348, 'lcongo', '76d86dddeb19cd1abecb6f20e6892d51bb3caddc19f683c436215ee08d9b71b04616394efac930bde310cb30aab7ecdb93f0295b751de06a5a42a42ea70f6a84', 'AC', NULL, '2025-11-03 08:58:00'),
(349, 349, 'ccongo', '3db6ee8ecb7d54ac0ff2236334cb6509fda2bb13fdbf9cd9b6a0697670b504be3be0451147671258506da535b8668ff9c03f8753154a4e53a662ade56c93b7a2', 'AC', NULL, '2025-07-03 14:54:00'),
(350, 350, 'dcorozo', '1b43f2e9884515dfbdea6b62aa7bc901336b9c5583e9d13a895af5e8f7c791ccf803682ee389f388a782a6d07cb3e62e585b4a94e000b0aa3ea2b9aac1b3513d', 'AC', NULL, '2025-07-03 09:31:00'),
(351, 351, 'jcortes', 'f097dfdd7990c20ad8b0e19a2990e8f66467b11d88f35f270bac1922ce8fcc80ff1bf5cbdb7584af0a559a94777c2b82df52ad9deae05c0cb9ab8ae7744b6c26', 'AC', NULL, '2025-11-03 15:28:00'),
(352, 352, 'tcongo', '18a9e380ce15fde4d41b346ad6f237cf3f5adc5e4acd72dc92799da1db8d689229580af76ba3e585e5b15c3f7c84a49095c743209bac96f6c0b6d9627f677093', 'AC', NULL, '2025-10-03 13:31:00'),
(353, 353, 'memontenegro', '53f551c230a0d225c5efc59703bc54963027291a5d8be7e89070c74e9274dbee572b3253c49e6050134ca598050527d109a128cd9533511fa33fe722cf042a58', 'AC', NULL, '2025-03-15 12:14:00'),
(354, 354, 'adejesus', '50b70c036c21042bc7989d9ed704bc244bcced92166bbb738e1902755ee234ec50547474d31d6feb6134b4deadf51696975577765fcc52828d93023201419d38', 'AC', NULL, '2025-10-03 12:41:00'),
(355, 355, 'jdejesus', 'c56601400f1e3d24400187f2ca6acb27dcabfcf179ff96c0b933026cc6d6642c4881e378d2fec0fc37ea51e3e74689fe88909f02cdc2deee3d17912d02735a31', 'AC', NULL, '2025-10-03 15:04:00'),
(356, 356, 'eldelgado', '95e1e1b6a4f3580e1db793a92b398cf7696c7d75e1a66910d0c8dd0b8e9481568667d2177927857a7766b50363261a8a16ca3b8812071602acea50f6a304a251', 'AC', NULL, '2025-03-14 17:41:00'),
(357, 357, 'edelgado', 'db81f6478285ef8af73b3554d2f02664845ab11d5fcf3c20a2cec5b82a1d1e31cc025abcd53cc7ead50df16a64657abe6ccbb2fc0651496d946d22936a8f8609', 'AC', NULL, '2025-10-03 12:14:00'),
(358, 358, 'renriquez', 'a36376d5e28c3584ef7979200cb755d0b6f31454a7daa33baf4422f53cebb1905b289d70a537f04618bc0fde7db0bdd7ab82e1a43c767b00285021196797153b', 'AC', NULL, '2025-07-03 15:40:00'),
(359, 359, 'cespana', 'd42d5008191f47b087f7c3c220d4eb04688bdecb18640a621fe71751036a80f156caf0e471781cf9cd48975495443c3d497630158a78e61ee6d779a139482b1d', 'AC', NULL, '2025-11-03 12:26:00'),
(360, 360, 'kespinosa', 'e4046ef03f81b2a646000bba53a6804243ee143756564cba258416b5180c3d02a1c9888fcbf063484af635ff9ff0c005ded453b04b25aeeebb1b2fa1db5bb414', 'AC', NULL, '2025-06-03 12:26:00'),
(361, 361, 'gespinoza', 'ec0a74aa2a6371d5a97f020df5fed4fd267ac880e8bec01dc8bd86420d0f828dd3cd37a956b59274c583afc732d198ae97d3361ceb04de864be18ee180e1c334', 'AC', NULL, '2025-03-14 15:35:00'),
(362, 362, 'jespinoza', '9bb3233f984b321b7f8d2dc0e408dd0fc8a245a046d67d4494bff3b207600732f6bd41ae4203fd1bf8d664f9be4af04baf69fd038f0baa21f79f7fff0bfe7689', 'AC', NULL, '2025-06-03 11:24:00'),
(363, 363, 'iespinoza', '5f967d0c22bbfc86f7c2d287c585dcd1c732bcff431dfa8354b4e30ece7def226c0d37576d103c9f2db2a72bdd78827440ddcb27cb7bfcb570d421f52a34a13a', 'AC', NULL, '2025-11-03 00:18:00'),
(364, 364, 'lespinoza', '7563c4e2de1ed327c786594a76347a119d1ec7012b3a426f9ee9a51dadb8a0a8d5455b167ded09dfce6fd7bbc2e3eab514ce4628575cdf04cd60c086415f96ec', 'AC', NULL, '2025-03-17 17:19:00'),
(365, 365, 'jeestupinan', 'f4de8cb8a0b026dc78991e25c44d952f6f55bc9ac4b2769d174aed5506bdab957121dfc65cd7e7a1aee7e8963f83177c5a2d7bf1937c01cb9f6ff6cccd1e306a', 'AC', NULL, '2025-08-03 14:15:00'),
(366, 366, 'pfelix', '5f6359ad0805dee3a5b3a2c942b0392d1b6adaaac0ec45c3b805e7ba4924af2707d34b229558a56960afb71ac2e06a0e9afb48f3f5877aade48c1d280a8322f6', 'AC', NULL, '2025-03-15 23:01:00'),
(367, 367, 'jflores', 'dcf3872fb1c9ca6bffb11ab939aec710e28edabc7852d530fb1504d36a6244c0a09b1aebfbfbd060e0a9ef56e58c309f30f40cbcd047720239d92ea4d5cf2b0d', 'AC', NULL, '2025-03-17 14:59:00'),
(368, 368, 'jfuel', '81e96e7e91ae7193df0b38d10baeeb8f0734e5b12a5caba5b2f8ee72c6dc8e0bf247a56970625dc5ae22f1e9a6f764bde56ea86414a13adeb77a49b4124b75a1', 'AC', NULL, '2025-11-03 09:34:00'),
(369, 369, 'mgarcia', 'f61208939e7921cdc29812f22da890c58cec1d6cc53d2d866a8857886c84155235eaee7b223b00396bfd50b51ad1ac7aa4c64929ccf53937b00f73943de6cb52', 'AC', NULL, '2025-11-03 10:08:00'),
(370, 370, 'rgarcia', 'd8bea645bc038bb1875b99b45c19aba75313ae89f0b8129c43f1c8b83b5292f9faf298eb52e300f1ff8ac948e51ef7314938383b828aabc558705768e8ee3401', 'AC', NULL, '2025-03-13 16:12:00'),
(371, 371, 'mgonzalez', '2a140f43ff71c90a0011c73288909f7ac96347d98c237d1f0ffda343817b9322f9a5cc6ef569e8ac7ea247e6a601f8ab024ac381016651385b3f53ba627ae5f2', 'AC', NULL, '2025-03-17 09:47:00'),
(372, 372, 'rgonzalon', 'a71a8dc24eb8070c44757a149a51d3041d68dce903858ec33aff565ff338ed6351ddcf11ed2b47e2664b127008ffb9f4e896a7330dc42226f8ab483b279a7c34', 'AC', NULL, '2025-11-03 09:00:00'),
(373, 373, 'sgrijalva', 'a99b66d0f738f67c00bf09d5ed3691b50d9cc8b81c8b5779c00906a9acd29458bf7099f4c6ffbecca05441a730eeae5c3c9e1af7b397c802a0c2afd571d127d4', 'AC', NULL, '2025-11-03 06:11:00'),
(374, 374, 'dgruezo', 'edd1d55fd20dcbf99fd6c1fecc26855bba69911f9fe4dd118c3dd194bc981161b17824a635405317dae5300936308524e8d8636500b6e0c151b4ad30681616fa', 'AC', NULL, '2025-11-03 15:36:00'),
(375, 375, 'egualacata', '3984d3ab9e4e1947100e04a1f13fc1ef3a1d97b63cc98140feb49a5ea503737586709c16ee043f1525553cf11859e480bc75cc7ad7ca595ca2f2f328b53ab883', 'AC', NULL, '2025-03-17 10:24:00'),
(376, 376, 'agualsaqui', '1a3a70510e12f1126afbe85054dab60f686ce2931742b709f5a147cee26d9a67e31dc8b5560afa2dae0e626f6f99735effbdd4991c10c78abbd15ea0205be0aa', 'AC', NULL, '2025-06-03 09:36:00'),
(377, 377, 'deguerra', 'e658099a64ce7e1dfd1f18ece42c6074b7c070d031e2f17eea056426589254d03d862889d281d9b18e291840aa050f35bc1ec288834f56d26259a09d47257512', 'AC', NULL, '2025-06-03 09:57:00'),
(378, 378, 'sguerrero', 'b4fbdfbd080f5e1e8f51d5019ae9ccee1813b0bb3b9646028aa76bf7feb2b4e41cafea2d539be9fe99af1dcb00cf086187165b66910a7eccd059317ac9b909e0', 'AC', NULL, '2025-09-04 14:23:00'),
(379, 379, 'kherembas', '76e5b95c2187ee2144ec0076e828916a151da7d72bdbd5b20c327206aae18bf2194d72c186e1e1d38ec9e7cc9c0156de9cea46d0de92de257861f6209c96bd9f', 'AC', NULL, '2025-11-03 18:15:00'),
(380, 380, 'chernandez', '55dca5ead208d218522b919ecd68708b91c7655f83f6e19d132d31810adc0f7ec9409e751ea538e9a1fa39c1cad4f260d5b0bedddff8d36095ca805a63ecdc57', 'AC', NULL, '2025-11-03 17:25:00'),
(381, 381, 'hhidrobo', '3281589335bbf118151440842bbdd5d6bf5465e73f74d08bcdcd6a7b9a2158b05f00bcd31a3f96031e077da5a2d764714ca57d2f5889ee928e3664374312ae7f', 'AC', NULL, '2025-06-03 11:24:00'),
(382, 382, 'bibadango', 'a03624437e63aeb218cbb6643a52bb5475bc319f381d3f4cd831d83fa6113b495e8b5662237b536c2eb1261839c86b91455eb841b270e7f7924787c118f48046', 'AC', NULL, '2025-05-03 17:19:00'),
(383, 383, 'ksjacome', '08927015f655fb37b83fe9771dce638ffaf93daa8e460e0314a86867a798f011f4b5e72281421eeb977990d876398bf1978f9c80b99a3a3158b60fe01c3c57e3', 'AC', NULL, '2025-12-03 10:34:00'),
(384, 384, 'ojuma', '7f506813047a97583108835b241420697b32be9c6158164f7cb2391a599cbfc9bf53225fe39dc113ac9243ee02b40855a2d8cb49483d7fb10f2b2f99befa6784', 'AC', NULL, '2025-12-03 17:45:00'),
(385, 385, 'blara', 'f535f64665a2e99eb6e11352cd11cc6cc12ebf0b0856b5e392ee031a165102b8612b4b40849f1c1934fa557a735e27e4ea8ed8f1dd73d9f3adb59639ac587baf', 'AC', NULL, '2025-10-03 12:37:00'),
(386, 386, 'clara', 'c7ec36fd4b962b9f5eaa5c09831107904a6a4347ad12dcd67462c15d092841b39800634dfb714585144ec112c1e35831f852e4969ebcfbb8e2cb23c537c884bd', 'AC', NULL, '2025-03-14 18:28:00'),
(387, 387, 'kleon', 'c2bf8fac6ff2153ee3f29359018dbff6e6a20605e2ff06340f9c5dab3d3140a961f5712730e158bacb2e83880730b0b0e7d03b5fd6e92fa988aa35694a068d71', 'AC', NULL, '2025-10-03 11:35:00'),
(388, 388, 'jlerma', '71f9dc7553810228400714211bb2a6041cb6be0c3ea9cae9b4bdaebb7b1f048489535781dc70dad73f7b40d92ec3d4445930575de5fde19584c6f1d775acb1df', 'AC', NULL, '2025-10-03 13:17:00'),
(389, 389, 'bmafla', '3faba04b1f1a08f4464f323c92810f16569018f98bcc81b3b31d3c09509b180e81ee55ed4eccfbc7c2e84d6350ac377ea69c27787df8defb4022d3c4ef78aded', 'AC', NULL, '2025-03-18 09:03:00'),
(390, 390, 'emalpud', '31f84399a3ec14c33b07a7f130f96b7892543589adeff3094c86cb37c9e10da6c84344460db4e1df543561da61906a7609c095610279be8455d5ad545d8bec5e', 'AC', NULL, '2025-03-14 22:52:00'),
(391, 391, 'emanteca', '25d4273c3c68f0722664d43565ca1099042fac114d7649a3ac130be331d68300f7bb863632599fd257b1adb65e484774813fdc920e5d5f6bf6fbe77044f81a54', 'AC', NULL, '2025-11-03 08:58:00'),
(392, 392, 'jmarquez', '41ea1453c0cb92875413ff050fa6bc27aefdf16dba385192b3dfd73fb0c6206b7f6c8ba2ef988be62ce13c3dbcdd8d0e2431c0abfd7d8f50a0ac618c53d7d662', 'AC', NULL, '2025-03-14 18:49:00'),
(393, 393, 'mmarrett', 'a8dbf8c7df1312f200a8e7a92742c5479a1b342248dc31e1006207ac54f516c29e3b82c1bd507a932761e76b6c1c155959ba7647ccee4dea5258bd64a63b4dc1', 'AC', NULL, '2025-03-17 11:51:00'),
(394, 394, 'dmartinez', '491088a23faf4c6868ca5083e29e5c55fceceaf7e53adebf0081bd17f368ff2ea179ce4b51fbe3fba21dba1050fabec0efefe965ff63ac6fb9890423f5030fbe', 'AC', NULL, '2025-03-17 18:17:00'),
(395, 395, 'cmaygua', 'd44a721327306769cbde40d777e0a15b29437de6a09cd7160054cf90c335ba26239367b9f9a39a3794195efe5feb01c11716648fa772f26fe71dc464e8c5b394', 'AC', NULL, '2025-10-03 21:42:00'),
(396, 396, 'cmera', 'f14086d36fff20337fde19e6bf56d4e911d5b236a60221c4eadf26ed3ce7b4209470c8fbd2a4eb061cde9076733a49cef346b7d0f87f5f76dce2deac708b8999', 'AC', NULL, '2025-10-03 14:01:00'),
(397, 397, 'jmesias', '9a39faa7c5b701673652527bd8c4cce5decd4fe418f686b67147f6a2d674512a4b70ca687a6561912b280befc96c1165c4f19e026270227ce6c70c7cffea6385', 'AC', NULL, '2025-05-03 15:07:00'),
(398, 398, 'ameza', 'b26d01a0d81b369246248f6d0a4a3cb2138cc6061c63e7850bfa66b2dcec314c02587cab45ff11d182338e1eac0bfed83f07275d57e383e06383ad51e3677cd1', 'AC', NULL, '2025-03-15 13:20:00'),
(399, 399, 'evmina', '5b838f924fe1655e454cfd277ba516424bcb8610095d3da43454d4a85511db8e0603caa86be67570d3e46d7e189a3513d2af68f5fb7a08c2baecccc83699985d', 'AC', NULL, '2025-11-03 11:51:00'),
(400, 400, 'gmina', '7763eb0168b8ee3ca12d3678d86a5d74808542a50d9a3cb340d5f1af8f8daa3a32b180446ab63fbe7a1d8923f8f21a27c9a2cebfae88e06a2df9abe381d16a21', 'AC', NULL, '2025-11-03 12:12:00'),
(401, 401, 'jmina', '6e5e6a2ccde710551dce2f5b0de500ad6cde0a52d7c10f015d54762fc9891b1f6d585392614c6fe7c0350249653216956fb09f6313828137b0bd62fbe6dd119b', 'AC', NULL, '2025-09-04 11:31:00'),
(402, 402, 'sminda', 'eecf3c4367a9a647ff896230376317648e2f6ade2cee6811456e252ec7b280bf5b5889ef4d9d4e093690195213603b14e010f6aa32dd9c24fb87693f2518f496', 'AC', NULL, '2025-03-17 12:47:00'),
(403, 403, 'lmolina', '3fc953aa258c2120842ffa7ed6cd0274fbce27272a7b70eb3eaedbc32fdd7c00f931e273c7d4b405f549602df8c96f9afe05d277820e31b48d682ade5305dcf5', 'AC', NULL, '2025-03-14 18:42:00'),
(404, 404, 'cmonroy', 'a60121815562452961c2a66b6f539d1f0084ef86501d2da63c01577af034829df53939a6252bc919d3a46fd401ee01b20edbdd3a84b2e04331a44d6b32d948cb', 'AC', NULL, '2025-03-17 11:13:00'),
(405, 405, 'jmontenegro', 'b489e9b0adf205766cff1743dee0865354840b2b21fc936652fe50a7ea5e567e110ee50bd22ad30ce983ec01d2bebd4ab40baae49c64bce2504205d425c29460', 'AC', NULL, '2025-03-17 09:59:00'),
(406, 406, 'cmontesdeoca', 'f404f0dfc67572ded97f9c60617a338d04fc19829ea05b1472e8350fea2655e862c0affc833d0cb0f4ab82162ef6fc48774243226386b9f13d8dc3b45ff682cd', 'AC', NULL, '2025-03-19 10:57:00'),
(407, 407, 'dmoreno', 'bb17e55486ff392f4a9b8edcf625268f55c2b9e7310bcc57cd415f32624276796374113ca7969d23542cbe2f857a5577782bbe8f3b871dca22854bd88cbd0d1c', 'AC', NULL, '2025-10-03 19:20:00'),
(408, 408, 'lmoreno', 'b1df618052221482fd8dd5b3f69eab122b8c0212d18521c02aca2a996353be91a383d0fd4a4d9274281187a0eb5d849d4a0dde4b1ee0572359c22c51452d34ea', 'AC', NULL, '2025-05-03 21:50:00'),
(409, 409, 'amorillo', '1ecc0f3b2ecf137b90f079559aba0c2a0ca53ecbcbacb7ddd501454657879d55a7f9844f8a84bcea44f9a2619b04a1d0367d7c404e5b4c4240794743cf7ac9f3', 'AC', NULL, '2025-10-03 09:08:00'),
(410, 410, 'knavarro', 'd01aff27bce79417159d3244415b3d147de28435d790510468aa18754d38c48428eec7ffc425f7e27d8177e8e2e296509bada39bfdf1fc4a34bb21df955a7208', 'AC', NULL, '2025-04-24 16:39:59'),
(411, 411, 'wnazareno', '094b9b9626e3ed94dd1b76e3edeb1ed6f24b083f9142b5470ad7cb3b42f82a15be28c2c11b47c9523c2128b66ee389c005eec13f6f34f98cbcdd840ef028e76d', 'AC', NULL, '2025-03-17 10:15:00'),
(412, 412, 'moleas', '514e5edac80cb91e67cec82f6d3e5a1bdf224976f034e021884246823f9dae20c09ac34eeeee7dab9bfea06ed5ddb90814f59db305a6e532343691d2a87d6c09', 'AC', NULL, '2025-04-21 08:06:00'),
(413, 413, 'eolmedo', 'a7aa578b1963336a8fd2a3d608959317bfaba45fb18ddc91e264a31e8f8aac6dbe565f91ea029865d2a9f4311e96675e0bbe015c0fb80f0764b3a3e1abde9872', 'AC', NULL, '2025-11-03 13:57:00'),
(414, 414, 'jpabon', '99c550e1a3cdf8d1f0b6f00cfc14ae6a1a6b4407bfeb69c044b4da90ccb46fabad128882673610816ec82ad8a5f46824b53ab45925ab12521ceb2e5823c2ddb8', 'AC', NULL, '2025-12-03 13:13:00'),
(415, 415, 'japabon', 'e589f296c8894cfca325992749dfe948ef0d956da2bbdc04798048c1805c9198a0a23d7ca0d5c1a1c5b483184b0756d1192e17b6b8764ca57a72a4251c6d4457', 'AC', NULL, '2025-03-14 19:49:00'),
(416, 416, 'jpadilla', '9dfd7b2adce7c0a9c6ec0d2f8f85f5037554ff0bc0b5a4b0521e70801c7f0c298cefdb5a692530edb9735ac93ff7e6be3f29401f17d7ae91e586848763545ea1', 'AC', NULL, '2025-06-03 11:28:00'),
(417, 417, 'mpadilla', '12e627a0552c3b69e14bdbe1677f78209b59894d5e28fd8b38b35debcaa91bbb31719235bdbd0ca8c67aeab4094f13e8daec82ea0ad2cae0a64c43dd79818120', 'AC', NULL, '2025-11-03 08:59:00'),
(418, 418, 'rpaillacho', '6b7e78b822874d475e8611a6ecf7563ed53d2ed269321ecfc227ed3c3100917f03a2dacf69a293842d6f7a610ef47dd04cfd6936913d002185acf9c7d8fde9d7', 'AC', NULL, '2025-03-17 14:50:00'),
(419, 419, 'jvpastrana', 'a42de040a5c74c95d629793661b5ff3db2e425c636c3ecc1624be15efd7dc6176f7f1b8a9ef0fd33f4bd0a39401092e4ddc4ace9bf8ffd7dd0be60a4cb649ddf', 'AC', NULL, '2025-06-03 09:42:00'),
(420, 420, 'mpicuasi', '6b4382e2f5db1c7ed4f8370b447b12d1704d29f7c6c6bf3100612434ac0ab4d298d9b2d3c575e2908dc43291b3097de8aa5a8958e321866afe32ace58a2ab4c5', 'AC', NULL, '2025-05-03 15:31:00'),
(421, 421, 'wpinto', '7525f41a54098ff555b1c6a226b981acfd619734073635ae4c375781e0734bcf9015e8a3d3c330a4df609b2d0c570043130c35f007da6fdc1cf1212b8582fc1e', 'AC', NULL, '2025-03-13 06:08:00'),
(422, 422, 'bplacencia', '567dc172a2fd8c25bf9ab8f6c7ec39c93c91388670be76ae826a37f4210f484b0f0a9adb25a45f452a0d70fb7377b68b275fc976d3dd4fa51592742e3dfb9db9', 'AC', NULL, '2025-10-03 13:49:00'),
(423, 423, 'cportocarrero', '72029eda30cf83cf7cafe85ec041a2770870629d725fcfc5541da7383e48eddd3d738c5fcb703f2cb611c808732c5e9c108b3440bc8b36e0f0f9b5fb8568c42b', 'AC', NULL, '2025-06-03 13:24:00'),
(424, 424, 'gpupiales', '7b4312a28f86944dcff380a358b23fc4e9351c31c5399e062db5dccaebfbdfb08b69e2db16e2df7e52ef9ce67d67dbecd0cc1fbd67208476475755abc93b8ad9', 'AC', NULL, '2025-10-03 12:18:00'),
(425, 425, 'jquelal', 'f7592bb60040604168fffb9bb98b35f78a74764c162c7eca6c6efae77d91342824e9f350f076b86fbc293ddd8924d4cfd9df66bc0cf6634ba9782aa2349af986', 'AC', NULL, '2025-04-20 09:52:00'),
(426, 426, 'mquerembas', 'a20fdc4bad18023c9c2ea631eaab4c88aba869edfa69127942a5f52da3b68244e7bb26b7e2aba451b8e09e3302c947b556acee0a6d9ea95d36856d100c606549', 'AC', NULL, '2025-10-03 09:43:00'),
(427, 427, 'tquinonez', 'b0c02bcd3944f4316067294f5f8891fd74e84718956dccfa672b9bba8b802f4807efcd7ae26ba03c05ee4b5e585309c929fa56beafd3400e6bdc6c2ef35e5322', 'AC', NULL, '2025-03-17 18:49:00'),
(428, 428, 'cquinonez', '48c0962a0b1297039151b90b81e1a0d2bcff61ca33e8aea88f7122f9b236ec27cd985ddab3c424ea3236214a1628ef9b9d8f44ec260eec629bfb89a71de13d83', 'AC', NULL, '2025-10-03 12:49:00'),
(429, 429, 'fquinonez', 'ce54011d7c70e63e006ddde818acfc538b136b5e3079d492ff11aaec609ec4ef662066b375b0027e450c1837865651cda50e0b9bd1c8cbf00992831f58ee7d2f', 'AC', NULL, '2025-12-03 11:57:00'),
(430, 430, 'eramirez', 'a7df8a7416195fd55d803a26c12bc72ed0ebb8de0a3424bb3e0d7b76c2de8dc9d86bd8b81fdfcf911cb2958084e929426dc07e76653335464fd66826695fd77c', 'AC', NULL, '2025-06-03 16:33:00'),
(431, 431, 'erivadeneira', '43ddafcd7d8eb5e73bbbe4d1a05b20665742ee21a9b7541a90ff84f810086233f96a3b78d605b411ca6ffe03d696f4549f0908fb45a0ad226a16d3304853550e', 'AC', NULL, '2025-03-18 06:19:00'),
(432, 432, 'arivera', '21490ecfef4dc658ba24b315cdcd052a336a443adbabbc3fed233c19cebc8a137f5ae29abf900ea0079849139591fe252d4c847f6b7a131f1e0cb40137e0e4c7', 'AC', NULL, '2025-03-17 09:52:00'),
(433, 433, 'jrodriguez', '9bb4eb2fac832d55af4bfdac9f2524928b6699dc87111fe0614669903144c749786423772a242291bd83cf10b324d91911d7ef75497556ce6d22f522c698ec4d', 'AC', NULL, '2025-07-03 10:24:00'),
(434, 434, 'jarodriguez', '7b41bba69880d950591d2fc9124b4fafa01ab83605e17da2ac19d353a3f6a1be5f2fb887d7622c9a7700e08f60afc24ae8f457142704c9f82e4dfb671e8c8848', 'AC', NULL, '2025-11-03 11:32:00'),
(435, 435, 'prosas', '94a32948050941a83b748c3b67b615ded972678a04bf54832f19bbd5915ba7eb994f8da9ad0d6c87d22fd267bc9e0e52a55b6d6959afe2b3b5858a5a2fd29bb3', 'AC', NULL, '2025-03-17 11:09:00'),
(436, 436, 'jasanchez', '540145fa526bf38dbebe9f03789f3321d76870356cdc0efb635f28d19eeed2bbaf7e6df3b0dd1b7fb24e0464e3e557246c225d95ce32e987a19dfebe6da9993b', 'AC', NULL, '2025-10-03 15:19:00'),
(437, 437, 'csailema', '59b592f5a0e94aa7f26cc19031e0913e8b8b5a3d1754bd7f3682cfac4892c0af98763bc4e896b3946beaaeaef9bf0e19d9cb8c9f839953f4bbb1b0354a61c053', 'AC', NULL, '2025-06-03 15:15:00'),
(438, 438, 'pasalazar', 'ed31e75bb58129baede3253b125aba8de62624eb2e221293e0bf1472c36308106338ff2a8fc4e0ddccf003b502ea4a7168c95940f124ec77b698a0b17ff2c8df', 'AC', NULL, '2025-08-03 22:29:00'),
(439, 439, 'csanchez', 'd0feaadbeb5cc244470b5736030e186cacd4d94661af5fb0d148bcf6241b918fb3d474a1455b91101718f38f99db32ea20ee54b50c7e510f7d430f6a7ad0549f', 'AC', NULL, '2025-03-17 12:09:00'),
(440, 440, 'wsandoval', 'ff4b0abaef6dd12a39a0fe3926f38e897e670f55c9118b84be0f734e527381b0ace2172367ec933679e436ab794a0acadf9fed9b29e19495b898aa187cc0b3ce', 'AC', NULL, '2025-12-03 05:07:00'),
(441, 441, 'bsanmartin', '5b1394a6a51d71bddcc7d5fe9375d6228c3bf4b3b5b77857131a78adedd3690d3c7b7fa3a8955a2fe4deed2f86d13440ba3da88b3932f5f4e047b24e02ba9f18', 'AC', NULL, '2025-10-03 11:19:00'),
(442, 442, 'ctambaco', 'd6813a0c04fe5c6029f340b5d2e326098bcd3fb3b9871a169d68eba321dafa72073967c9498aa1f4bd83e9e87fe403d000f6e0f407c596520eedffc8b98549a7', 'AC', NULL, '2025-06-03 12:02:00'),
(443, 443, 'wtapia', '782b5699a3c5478fd446078c1c5db3bb57efdf4595ffe31f1c674e9eb084ed034a9e33582971b739966aa2c2f1c85e5e8a447b80d0ba6ff60d46878a2addb655', 'AC', NULL, '2025-03-15 20:03:00'),
(444, 444, 'gteran', '20d1edc94e845f627617ecdbfe91c505f674b4e521afe9afa6ad45845571ecd043ce54bd60fa469a9ef6c0a4421d3199a60fb445a6fff67535796a5d1e7b9cce', 'AC', NULL, '2025-10-03 19:30:00'),
(445, 445, 'ptigse', 'd9d0d2a612970d7eaaed5cc85752cc591a800e0e9170354e3d9955b3d1f04615635f5f5af7aca19049ae1434dced3198380d8dfde012266c42eff0dd5fb926dd', 'AC', NULL, '2025-10-03 11:01:00'),
(446, 446, 'mtomaico', '6122d86920190cfbc7ed7251804fcaa0d2da17e469bef9ba85a5f4376e59b3ec28fba5603f159f2a65b51617283b962fc17205227ea9f1a814eacca900ffb25e', 'AC', NULL, '2025-08-04 12:29:00'),
(447, 447, 'rtroya', '5264767e9bb6c04ec133b88ee945df612fa2b0f3625f6af18334cdf0784cc90bd07145772dc58aa81a3e87a623e0f2899792dfb0cd65dd687b92a4133a864908', 'AC', NULL, '2025-09-04 14:49:00'),
(448, 448, 'etulcan', 'f19a6ed9b69e3c95e2ccecf45c5681f5f14d506997e816cea0e9f254a6210477a383ecf3e593d90b026b20e6b374bbde1829891cc06661326571c8ca617492da', 'AC', NULL, '2025-04-13 15:15:00'),
(449, 449, 'dtulcanaza', 'fb4b810c6c7f887f16e73c649250f9b72cbc35bae853684b736336f90ac8fbd697ed940521c4e05574e0cbab68697e12f833df21a3b9a139f77c309b5ba7dd35', 'AC', NULL, '2025-06-03 12:53:00'),
(450, 450, 'ctupiza', '6671705216121d678a91c6bd97e57558748c27511bf65788b00214b25a52a3808fbc6285e495b5be06cd57f55b97bd96a326ab3c4f12406e5c4405d12695848f', 'AC', NULL, '2025-06-03 06:00:00'),
(451, 451, 'ltupiza', '0176a708c9beee0415769e3c6ee71a77a22a8a0cc74ea8614ec699b52de2de25192f4048f23c5fa832fc16d2d0991c77d068474f8202a84b66def0e1f262e6b9', 'AC', NULL, '2025-06-03 09:39:00'),
(452, 452, 'ftuza', '4197cf4148145217685fbe08a36f6b69a7fc2f911230258d77fd809c25237602e64b0a2fcf640de5b55326057356f401a0333737067c95d51745bbda86279e27', 'AC', NULL, '2025-11-03 20:53:00'),
(453, 453, 'lubidia', '031e05d440d61e7e185c83c81a007c5c2849b6b4e93603cae50c041be0fb6e175f200da2f3be982f55e669adfdf1cdaa736a0af4e1fd63b565cd126d04b0c40e', 'AC', NULL, '2025-10-03 12:39:00'),
(454, 454, 'murresta', 'f4398689e8804d1539db831941c5ec31a7417960f7d03255ba21f927ea0394d35523f7b99778aba0870c866999477111c6779861fbaaf55905b99fcd0a17e90d', 'AC', NULL, '2025-03-19 16:51:00'),
(455, 455, 'ovalencia', '32762611f175f01fca458dd267ef1bfee8ce7c820f7fad25dcbe7035f19d1cae0130aa7f83ee616eea6deeaefcfaa3d40e9cf171b2378c06eaa7ee0b14a1dc49', 'AC', NULL, '2025-10-03 15:24:00'),
(456, 456, 'bvalencia', '4f10fc339ed3172ef40640494d659fca47a75ca024f8fb10f73325bea160ce5ce7fe7cd43353b8cdc6534dfab6c3ea579b55a0697bace225fbe50583e47ec44a', 'AC', NULL, '2025-11-03 09:45:00'),
(457, 457, 'eveliz', 'fbe61e3d981be492dbc7cb7f1ea3d5b7b24ded1302578d861eeec9cc18308aebc9a94561f3fdcf3dde9f1dc8b9922c22393c173b5c706c371e0603f6b06cfb7c', 'AC', NULL, '2025-06-03 11:36:00'),
(458, 458, 'dvicuna', 'f165f6a2f580194d4fc884c5db5f36207c639c7f02da9d63a939d848ca21c246c74cf690b0618cde512ae94b02c4493f58b3e681f80d68fbf3e911b4cf3e1a84', 'AC', NULL, '2025-05-03 14:24:00'),
(459, 459, 'dvillalva', '06f4b7e1e7f25c354a805b9943430aefbe63e70fa2db9d0b90c8b1fadd74d2a1ab10a87cc75218b583e45656d0ef6279b25611e65208de39553ed7dc2c38533c', 'AC', NULL, '2025-11-03 13:50:00'),
(460, 460, 'avillarreal', '738162803a149d3f63fe4da2d18392bc68d71f0b6b7b654e77fce58c0ad9f1a64a0601b35554124d859c5551870a4eb51e4788c98e89988c496354eddd49ca04', 'AC', NULL, '2025-03-17 07:38:00'),
(461, 461, 'dviteri', '4a37763082127c7e2aa136bc34967aa5514d0f41ae7e98f21c471afc64c013bf1e0b054a86b712d281371de8d69fc6cb991cb99285b8884d19031ed6b872bbf1', 'AC', NULL, '2025-07-03 08:27:00'),
(462, 462, 'vvivero', '95e3fa1b15ae63080b74e1dba148201f60bf7b4eb6a2c988008896dc62a0a449c6300b85508faa0890b30c9e91446f23509b3e20fce1f2218a6f2b4318809d78', 'AC', NULL, '2025-11-03 13:53:00'),
(463, 463, 'jgruiz', 'c55e70b1c3270e574af89dbcc53ce428727aa482ebc9c99e736b3a2cce6deacbd78b15af15aec091ed82c958bc59a9dd610d0a82e9c7fd2e178a03f401049c01', 'AC', NULL, '2025-05-03 19:20:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_sistema`
--

CREATE TABLE `usuario_sistema` (
  `ID_USUARIO_SISTEMA` int(11) NOT NULL,
  `ID_SISTEMA` int(11) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `ESTADO_USUARIO_SISTEMA` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_sistema`
--

INSERT INTO `usuario_sistema` (`ID_USUARIO_SISTEMA`, `ID_SISTEMA`, `ID_USUARIO`, `ESTADO_USUARIO_SISTEMA`) VALUES
(1, 1, 1, 'AC'),
(2, 2, 2, 'AC'),
(3, 2, 3, 'AC'),
(4, 2, 4, 'AC'),
(5, 2, 7, 'IN'),
(6, 2, 8, 'IN'),
(7, 2, 9, 'AC'),
(8, 2, 10, 'AC'),
(9, 2, 11, 'AC'),
(10, 2, 12, 'AC'),
(11, 2, 13, 'AC'),
(12, 2, 14, 'AC'),
(13, 2, 15, 'AC'),
(14, 2, 16, 'AC'),
(15, 2, 17, 'AC'),
(16, 2, 18, 'AC'),
(17, 2, 19, 'AC'),
(18, 2, 20, 'AC'),
(19, 2, 21, 'AC'),
(20, 2, 22, 'AC'),
(21, 2, 23, 'AC'),
(22, 2, 24, 'AC'),
(23, 2, 25, 'AC'),
(24, 2, 26, 'AC'),
(25, 2, 27, 'AC'),
(26, 2, 28, 'AC'),
(27, 2, 29, 'AC'),
(28, 2, 30, 'AC'),
(29, 2, 31, 'AC'),
(30, 2, 32, 'AC'),
(31, 2, 33, 'AC'),
(32, 2, 34, 'AC'),
(33, 2, 35, 'AC'),
(34, 2, 36, 'AC'),
(35, 2, 37, 'AC'),
(36, 2, 38, 'AC'),
(37, 2, 39, 'AC'),
(38, 2, 40, 'AC'),
(39, 2, 41, 'AC'),
(40, 2, 42, 'AC'),
(41, 2, 43, 'AC'),
(42, 2, 44, 'AC'),
(43, 2, 45, 'PE'),
(44, 2, 46, 'AC'),
(45, 2, 47, 'AC'),
(46, 2, 48, 'AC'),
(47, 2, 49, 'AC'),
(48, 2, 50, 'AC'),
(49, 2, 51, 'AC'),
(50, 2, 52, 'AC'),
(51, 2, 53, 'AC'),
(52, 2, 54, 'AC'),
(53, 2, 55, 'AC'),
(54, 2, 56, 'AC'),
(55, 2, 57, 'AC'),
(56, 2, 58, 'AC'),
(57, 2, 59, 'AC'),
(58, 2, 60, 'AC'),
(59, 2, 61, 'AC'),
(60, 2, 62, 'AC'),
(61, 2, 63, 'AC'),
(62, 2, 64, 'AC'),
(63, 2, 65, 'AC'),
(64, 2, 66, 'AC'),
(65, 2, 67, 'AC'),
(66, 2, 68, 'AC'),
(67, 2, 69, 'AC'),
(68, 2, 70, 'AC'),
(69, 2, 71, 'AC'),
(70, 2, 72, 'AC'),
(71, 2, 73, 'AC'),
(72, 2, 74, 'AC'),
(73, 2, 75, 'AC'),
(74, 2, 76, 'AC'),
(75, 2, 77, 'AC'),
(76, 2, 78, 'AC'),
(77, 2, 79, 'AC'),
(78, 2, 80, 'AC'),
(79, 2, 81, 'AC'),
(80, 2, 82, 'AC'),
(81, 2, 83, 'AC'),
(82, 2, 84, 'AC'),
(83, 2, 85, 'AC'),
(84, 2, 86, 'AC'),
(85, 2, 87, 'AC'),
(86, 2, 88, 'AC'),
(87, 2, 89, 'AC'),
(88, 2, 90, 'AC'),
(89, 2, 91, 'AC'),
(90, 2, 92, 'AC'),
(91, 2, 93, 'AC'),
(92, 2, 94, 'AC'),
(93, 2, 95, 'AC'),
(94, 2, 96, 'AC'),
(95, 2, 97, 'AC'),
(96, 2, 98, 'AC'),
(97, 2, 99, 'AC'),
(98, 2, 100, 'AC'),
(99, 2, 101, 'AC'),
(100, 2, 102, 'AC'),
(101, 2, 103, 'AC'),
(102, 2, 104, 'AC'),
(103, 2, 105, 'AC'),
(104, 2, 106, 'AC'),
(105, 2, 107, 'AC'),
(106, 2, 108, 'AC'),
(107, 2, 109, 'AC'),
(108, 2, 110, 'AC'),
(109, 2, 111, 'AC'),
(110, 2, 112, 'AC'),
(111, 2, 113, 'AC'),
(112, 2, 114, 'AC'),
(113, 2, 115, 'AC'),
(114, 2, 116, 'AC'),
(115, 2, 117, 'AC'),
(116, 2, 118, 'AC'),
(117, 2, 119, 'AC'),
(118, 2, 120, 'AC'),
(119, 2, 121, 'AC'),
(120, 2, 122, 'AC'),
(121, 2, 123, 'AC'),
(122, 2, 124, 'AC'),
(123, 2, 125, 'AC'),
(124, 2, 126, 'AC'),
(125, 2, 127, 'AC'),
(126, 2, 128, 'AC'),
(127, 2, 129, 'AC'),
(128, 2, 130, 'AC'),
(129, 2, 131, 'AC'),
(130, 2, 132, 'AC'),
(131, 2, 133, 'AC'),
(132, 2, 134, 'AC'),
(133, 2, 135, 'AC'),
(134, 2, 136, 'AC'),
(135, 2, 137, 'AC'),
(136, 2, 138, 'AC'),
(137, 2, 139, 'AC'),
(138, 2, 140, 'AC'),
(139, 2, 141, 'AC'),
(140, 2, 142, 'AC'),
(141, 2, 143, 'AC'),
(142, 2, 144, 'AC'),
(143, 2, 145, 'AC'),
(144, 2, 146, 'AC'),
(145, 2, 147, 'AC'),
(146, 2, 148, 'AC'),
(147, 2, 149, 'AC'),
(148, 2, 150, 'AC'),
(149, 2, 151, 'AC'),
(150, 2, 152, 'AC'),
(151, 2, 153, 'AC'),
(152, 2, 154, 'AC'),
(153, 2, 155, 'AC'),
(154, 2, 156, 'AC'),
(155, 2, 157, 'AC'),
(156, 2, 158, 'AC'),
(157, 2, 159, 'AC'),
(158, 2, 160, 'AC'),
(159, 2, 161, 'AC'),
(160, 2, 162, 'AC'),
(161, 2, 163, 'AC'),
(162, 2, 164, 'AC'),
(163, 2, 165, 'AC'),
(164, 2, 166, 'AC'),
(165, 2, 167, 'AC'),
(166, 2, 168, 'AC'),
(167, 2, 169, 'AC'),
(168, 2, 170, 'AC'),
(169, 2, 171, 'AC'),
(170, 2, 172, 'AC'),
(171, 2, 173, 'AC'),
(172, 2, 174, 'AC'),
(173, 2, 175, 'AC'),
(174, 2, 176, 'AC'),
(175, 2, 177, 'AC'),
(176, 2, 178, 'AC'),
(177, 2, 179, 'AC'),
(178, 2, 180, 'AC'),
(179, 2, 181, 'AC'),
(180, 2, 182, 'AC'),
(181, 2, 183, 'AC'),
(182, 2, 184, 'AC'),
(183, 2, 185, 'AC'),
(184, 2, 186, 'AC'),
(185, 2, 187, 'AC'),
(186, 2, 188, 'AC'),
(187, 2, 189, 'AC'),
(188, 2, 190, 'AC'),
(189, 2, 191, 'AC'),
(190, 2, 192, 'AC'),
(191, 2, 193, 'AC'),
(192, 2, 194, 'AC'),
(193, 2, 195, 'AC'),
(194, 2, 196, 'AC'),
(195, 2, 197, 'AC'),
(196, 2, 198, 'AC'),
(197, 2, 199, 'AC'),
(198, 2, 200, 'AC'),
(199, 2, 201, 'AC'),
(200, 2, 202, 'AC'),
(201, 2, 203, 'AC'),
(202, 2, 204, 'AC'),
(203, 2, 205, 'AC'),
(204, 2, 206, 'AC'),
(205, 2, 207, 'AC'),
(206, 2, 208, 'AC'),
(207, 2, 209, 'AC'),
(208, 2, 210, 'AC'),
(209, 2, 211, 'AC'),
(210, 2, 212, 'PA'),
(211, 2, 213, 'AC'),
(212, 2, 214, 'AC'),
(213, 2, 215, 'AC'),
(214, 2, 216, 'AC'),
(215, 2, 217, 'AC'),
(216, 2, 218, 'AC'),
(217, 2, 219, 'AC'),
(218, 2, 220, 'AC'),
(219, 2, 221, 'AC'),
(220, 2, 222, 'AC'),
(221, 2, 223, 'AC'),
(222, 2, 224, 'AC'),
(223, 2, 225, 'AC'),
(224, 2, 226, 'AC'),
(225, 2, 227, 'AC'),
(226, 2, 228, 'AC'),
(227, 2, 229, 'AC'),
(228, 2, 230, 'AC'),
(229, 2, 231, 'AC'),
(230, 2, 232, 'AC'),
(231, 2, 233, 'AC'),
(232, 2, 234, 'AC'),
(233, 2, 235, 'AC'),
(234, 2, 236, 'AC'),
(235, 2, 237, 'AC'),
(236, 2, 238, 'AC'),
(237, 2, 239, 'AC'),
(238, 2, 240, 'AC'),
(239, 2, 241, 'AC'),
(240, 2, 242, 'AC'),
(241, 2, 243, 'AC'),
(242, 2, 244, 'AC'),
(243, 2, 245, 'AC'),
(244, 2, 246, 'AC'),
(245, 2, 247, 'AC'),
(246, 2, 248, 'AC'),
(247, 2, 249, 'AC'),
(248, 2, 250, 'AC'),
(249, 2, 251, 'AC'),
(250, 2, 252, 'AC'),
(251, 2, 253, 'AC'),
(252, 2, 254, 'AC'),
(253, 2, 255, 'AC'),
(254, 2, 256, 'AC'),
(255, 2, 257, 'AC'),
(256, 2, 258, 'AC'),
(257, 2, 259, 'AC'),
(258, 2, 260, 'AC'),
(259, 2, 261, 'AC'),
(260, 2, 262, 'AC'),
(261, 2, 263, 'AC'),
(262, 2, 264, 'AC'),
(263, 2, 265, 'AC'),
(264, 2, 266, 'AC'),
(265, 2, 267, 'PE'),
(266, 2, 268, 'AC'),
(267, 2, 269, 'AC'),
(268, 2, 270, 'AC'),
(269, 2, 271, 'AC'),
(270, 2, 272, 'AC'),
(271, 2, 273, 'AC'),
(272, 2, 274, 'AC'),
(273, 2, 275, 'AC'),
(274, 2, 276, 'AC'),
(275, 2, 277, 'AC'),
(276, 2, 278, 'AC'),
(277, 2, 279, 'AC'),
(278, 2, 280, 'AC'),
(279, 2, 281, 'AC'),
(280, 2, 282, 'AC'),
(281, 2, 283, 'AC'),
(282, 2, 284, 'AC'),
(283, 2, 285, 'AC'),
(284, 2, 286, 'AC'),
(285, 2, 287, 'AC'),
(286, 2, 288, 'AC'),
(287, 2, 289, 'AC'),
(288, 2, 290, 'AC'),
(289, 2, 291, 'AC'),
(290, 2, 292, 'AC'),
(291, 2, 293, 'AC'),
(292, 2, 294, 'AC'),
(293, 2, 295, 'AC'),
(294, 2, 296, 'AC'),
(295, 2, 297, 'AC'),
(296, 2, 298, 'AC'),
(297, 2, 299, 'AC'),
(298, 2, 300, 'AC'),
(299, 2, 301, 'AC'),
(300, 2, 302, 'AC'),
(301, 2, 303, 'AC'),
(302, 2, 304, 'AC'),
(303, 2, 305, 'AC'),
(304, 2, 306, 'AC'),
(305, 2, 307, 'AC'),
(306, 2, 308, 'AC'),
(307, 2, 309, 'AC'),
(308, 2, 310, 'AC'),
(309, 2, 311, 'AC'),
(310, 2, 312, 'AC'),
(311, 2, 313, 'AC'),
(312, 2, 314, 'AC'),
(313, 2, 315, 'AC'),
(314, 2, 316, 'AC'),
(315, 2, 317, 'AC'),
(316, 2, 318, 'AC'),
(317, 2, 319, 'AC'),
(318, 2, 320, 'AC'),
(319, 2, 321, 'AC'),
(320, 2, 322, 'AC'),
(321, 2, 323, 'AC'),
(322, 2, 324, 'AC'),
(323, 2, 325, 'AC'),
(324, 2, 326, 'AC'),
(325, 2, 327, 'AC'),
(326, 2, 328, 'AC'),
(327, 2, 329, 'AC'),
(328, 2, 330, 'AC'),
(329, 2, 331, 'AC'),
(330, 2, 332, 'AC'),
(331, 2, 333, 'AC'),
(332, 2, 334, 'AC'),
(333, 2, 335, 'AC'),
(334, 2, 336, 'AC'),
(335, 2, 337, 'AC'),
(336, 2, 338, 'AC'),
(337, 2, 339, 'AC'),
(338, 2, 340, 'AC'),
(339, 2, 341, 'AC'),
(340, 2, 342, 'AC'),
(341, 2, 343, 'AC'),
(342, 2, 344, 'AC'),
(343, 2, 345, 'AC'),
(344, 2, 346, 'AC'),
(345, 2, 347, 'AC'),
(346, 2, 348, 'AC'),
(347, 2, 349, 'AC'),
(348, 2, 350, 'AC'),
(349, 2, 351, 'AC'),
(350, 2, 352, 'AC'),
(351, 2, 353, 'AC'),
(352, 2, 354, 'AC'),
(353, 2, 355, 'AC'),
(354, 2, 356, 'AC'),
(355, 2, 357, 'AC'),
(356, 2, 358, 'AC'),
(357, 2, 359, 'AC'),
(358, 2, 360, 'AC'),
(359, 2, 361, 'AC'),
(360, 2, 362, 'AC'),
(361, 2, 363, 'AC'),
(362, 2, 364, 'AC'),
(363, 2, 365, 'AC'),
(364, 2, 366, 'AC'),
(365, 2, 367, 'AC'),
(366, 2, 368, 'AC'),
(367, 2, 369, 'AC'),
(368, 2, 370, 'AC'),
(369, 2, 371, 'AC'),
(370, 2, 372, 'AC'),
(371, 2, 373, 'AC'),
(372, 2, 374, 'AC'),
(373, 2, 375, 'AC'),
(374, 2, 376, 'AC'),
(375, 2, 377, 'AC'),
(376, 2, 378, 'AC'),
(377, 2, 379, 'AC'),
(378, 2, 380, 'AC'),
(379, 2, 381, 'AC'),
(380, 2, 382, 'AC'),
(381, 2, 383, 'AC'),
(382, 2, 384, 'AC'),
(383, 2, 385, 'AC'),
(384, 2, 386, 'AC'),
(385, 2, 387, 'AC'),
(386, 2, 388, 'AC'),
(387, 2, 389, 'AC'),
(388, 2, 390, 'AC'),
(389, 2, 391, 'AC'),
(390, 2, 392, 'AC'),
(391, 2, 393, 'AC'),
(392, 2, 394, 'AC'),
(393, 2, 395, 'AC'),
(394, 2, 396, 'AC'),
(395, 2, 397, 'AC'),
(396, 2, 398, 'AC'),
(397, 2, 399, 'AC'),
(398, 2, 400, 'AC'),
(399, 2, 401, 'AC'),
(400, 2, 402, 'AC'),
(401, 2, 403, 'AC'),
(402, 2, 404, 'AC'),
(403, 2, 405, 'AC'),
(404, 2, 406, 'AC'),
(405, 2, 407, 'AC'),
(406, 2, 408, 'AC'),
(407, 2, 409, 'AC'),
(408, 2, 410, 'AC'),
(409, 2, 411, 'AC'),
(410, 2, 412, 'AC'),
(411, 2, 413, 'AC'),
(412, 2, 414, 'AC'),
(413, 2, 415, 'AC'),
(414, 2, 416, 'AC'),
(415, 2, 417, 'AC'),
(416, 2, 418, 'AC'),
(417, 2, 419, 'AC'),
(418, 2, 420, 'AC'),
(419, 2, 421, 'AC'),
(420, 2, 422, 'AC'),
(421, 2, 423, 'AC'),
(422, 2, 424, 'AC'),
(423, 2, 425, 'AC'),
(424, 2, 426, 'AC'),
(425, 2, 427, 'AC'),
(426, 2, 428, 'AC'),
(427, 2, 429, 'AC'),
(428, 2, 430, 'AC'),
(429, 2, 431, 'AC'),
(430, 2, 432, 'AC'),
(431, 2, 433, 'AC'),
(432, 2, 434, 'AC'),
(433, 2, 435, 'AC'),
(434, 2, 436, 'AC'),
(435, 2, 437, 'AC'),
(436, 2, 438, 'AC'),
(437, 2, 439, 'AC'),
(438, 2, 440, 'AC'),
(439, 2, 441, 'AC'),
(440, 2, 442, 'AC'),
(441, 2, 443, 'AC'),
(442, 2, 444, 'AC'),
(443, 2, 445, 'AC'),
(444, 2, 446, 'AC'),
(445, 2, 447, 'AC'),
(446, 2, 448, 'AC'),
(447, 2, 449, 'AC'),
(448, 2, 450, 'AC'),
(449, 2, 451, 'AC'),
(450, 2, 452, 'AC'),
(451, 2, 453, 'AC'),
(452, 2, 454, 'AC'),
(453, 2, 455, 'AC'),
(454, 2, 456, 'AC'),
(455, 2, 457, 'AC'),
(456, 2, 458, 'AC'),
(457, 2, 459, 'AC'),
(458, 2, 460, 'AC'),
(459, 2, 461, 'AC'),
(460, 2, 462, 'AC'),
(461, 2, 463, 'AC');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_distritos_agentes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_distritos_agentes` (
`ID_DISTRITO_AGENTE` int(11)
,`DISTRITO` varchar(8)
,`CANTON` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_funciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_funciones` (
`ID_FUNCION` int(11)
,`FUNCION` varchar(40)
,`ESTADO_FUNCION` char(2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_grupo_operativo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_grupo_operativo` (
`ID_GRUPO_OPERATIVO` int(11)
,`GRUPO_OPERATIVO` varchar(50)
,`ID_TIPO_GRUPO` int(11)
,`ACTIVO` varchar(2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_indisponibilidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_indisponibilidad` (
`ID_INDISPONIBILIDAD` int(11)
,`ID_USUARIO` int(11)
,`ID_TIPO_INDISPONIBILIDAD` int(11)
,`FECHA_DESDE` datetime
,`FECHA_HASTA` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_personas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_personas` (
`ID_PERSONA` int(11)
,`ID_DISTRITO_AGENTE` int(11)
,`ID_FUNCION` int(11)
,`CEDULA` varchar(10)
,`NOMBRES` varchar(30)
,`APELLIDOS` varchar(30)
,`CODIGO_AGENTE` varchar(6)
,`TELEFONO_AGENTE` varchar(12)
,`AGENTE` char(2)
,`EMAIL` varchar(40)
,`ID_GRUPO_OPERATIVO` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_sistemas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_sistemas` (
`ID_SISTEMA` int(11)
,`NOMBRE_SISTEMA` varchar(80)
,`ESTADO_SISTEMA` char(2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_tipo_grupo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_tipo_grupo` (
`ID_TIPO_GRUPO` int(11)
,`TIPO_GRUPO` varchar(50)
,`DESCRIPCION` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_tipo_indisponibilidad`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_tipo_indisponibilidad` (
`ID_TIPO_INDISPONIBILIDAD` int(11)
,`TIPO_INDISPONIBILIDAD` varchar(60)
,`ESTADO` char(2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_usuarios` (
`ID_USUARIO` int(11)
,`ID_PERSONA` int(11)
,`USUARIO` char(20)
,`PASS` varchar(256)
,`ESTADO` char(2)
,`HASH` varchar(250)
,`FECHA` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_usuario_sistema`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_usuario_sistema` (
`ID_USUARIO_SISTEMA` int(11)
,`ID_SISTEMA` int(11)
,`ID_USUARIO` int(11)
,`ESTADO_USUARIO_SISTEMA` char(2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_distritos_agentes`
--
DROP TABLE IF EXISTS `v_distritos_agentes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_distritos_agentes`  AS SELECT `distritos_agentes`.`ID_DISTRITO_AGENTE` AS `ID_DISTRITO_AGENTE`, `distritos_agentes`.`DISTRITO` AS `DISTRITO`, `distritos_agentes`.`CANTON` AS `CANTON` FROM `distritos_agentes` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_funciones`
--
DROP TABLE IF EXISTS `v_funciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_funciones`  AS SELECT `funciones`.`ID_FUNCION` AS `ID_FUNCION`, `funciones`.`FUNCION` AS `FUNCION`, `funciones`.`ESTADO_FUNCION` AS `ESTADO_FUNCION` FROM `funciones` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_grupo_operativo`
--
DROP TABLE IF EXISTS `v_grupo_operativo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_grupo_operativo`  AS SELECT `grupo_operativo`.`ID_GRUPO_OPERATIVO` AS `ID_GRUPO_OPERATIVO`, `grupo_operativo`.`GRUPO_OPERATIVO` AS `GRUPO_OPERATIVO`, `grupo_operativo`.`ID_TIPO_GRUPO` AS `ID_TIPO_GRUPO`, `grupo_operativo`.`ACTIVO` AS `ACTIVO` FROM `grupo_operativo` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_indisponibilidad`
--
DROP TABLE IF EXISTS `v_indisponibilidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_indisponibilidad`  AS SELECT `indisponibilidad`.`ID_INDISPONIBILIDAD` AS `ID_INDISPONIBILIDAD`, `indisponibilidad`.`ID_USUARIO` AS `ID_USUARIO`, `indisponibilidad`.`ID_TIPO_INDISPONIBILIDAD` AS `ID_TIPO_INDISPONIBILIDAD`, `indisponibilidad`.`FECHA_DESDE` AS `FECHA_DESDE`, `indisponibilidad`.`FECHA_HASTA` AS `FECHA_HASTA` FROM `indisponibilidad` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_personas`
--
DROP TABLE IF EXISTS `v_personas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_personas`  AS SELECT `personas`.`ID_PERSONA` AS `ID_PERSONA`, `personas`.`ID_DISTRITO_AGENTE` AS `ID_DISTRITO_AGENTE`, `personas`.`ID_FUNCION` AS `ID_FUNCION`, `personas`.`CEDULA` AS `CEDULA`, `personas`.`NOMBRES` AS `NOMBRES`, `personas`.`APELLIDOS` AS `APELLIDOS`, `personas`.`CODIGO_AGENTE` AS `CODIGO_AGENTE`, `personas`.`TELEFONO_AGENTE` AS `TELEFONO_AGENTE`, `personas`.`AGENTE` AS `AGENTE`, `personas`.`EMAIL` AS `EMAIL`, `personas`.`ID_GRUPO_OPERATIVO` AS `ID_GRUPO_OPERATIVO` FROM `personas` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_sistemas`
--
DROP TABLE IF EXISTS `v_sistemas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_sistemas`  AS SELECT `sistemas`.`ID_SISTEMA` AS `ID_SISTEMA`, `sistemas`.`NOMBRE_SISTEMA` AS `NOMBRE_SISTEMA`, `sistemas`.`ESTADO_SISTEMA` AS `ESTADO_SISTEMA` FROM `sistemas` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_tipo_grupo`
--
DROP TABLE IF EXISTS `v_tipo_grupo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tipo_grupo`  AS SELECT `tipo_grupo`.`ID_TIPO_GRUPO` AS `ID_TIPO_GRUPO`, `tipo_grupo`.`TIPO_GRUPO` AS `TIPO_GRUPO`, `tipo_grupo`.`DESCRIPCION` AS `DESCRIPCION` FROM `tipo_grupo` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_tipo_indisponibilidad`
--
DROP TABLE IF EXISTS `v_tipo_indisponibilidad`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tipo_indisponibilidad`  AS SELECT `tipo_indisponibilidad`.`ID_TIPO_INDISPONIBILIDAD` AS `ID_TIPO_INDISPONIBILIDAD`, `tipo_indisponibilidad`.`TIPO_INDISPONIBILIDAD` AS `TIPO_INDISPONIBILIDAD`, `tipo_indisponibilidad`.`ESTADO` AS `ESTADO` FROM `tipo_indisponibilidad` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_usuarios`
--
DROP TABLE IF EXISTS `v_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuarios`  AS SELECT `usuarios`.`ID_USUARIO` AS `ID_USUARIO`, `usuarios`.`ID_PERSONA` AS `ID_PERSONA`, `usuarios`.`USUARIO` AS `USUARIO`, `usuarios`.`PASS` AS `PASS`, `usuarios`.`ESTADO` AS `ESTADO`, `usuarios`.`HASH` AS `HASH`, `usuarios`.`FECHA` AS `FECHA` FROM `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_usuario_sistema`
--
DROP TABLE IF EXISTS `v_usuario_sistema`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuario_sistema`  AS SELECT `usuario_sistema`.`ID_USUARIO_SISTEMA` AS `ID_USUARIO_SISTEMA`, `usuario_sistema`.`ID_SISTEMA` AS `ID_SISTEMA`, `usuario_sistema`.`ID_USUARIO` AS `ID_USUARIO`, `usuario_sistema`.`ESTADO_USUARIO_SISTEMA` AS `ESTADO_USUARIO_SISTEMA` FROM `usuario_sistema` ;

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
-- Indices de la tabla `distritos_agentes`
--
ALTER TABLE `distritos_agentes`
  ADD PRIMARY KEY (`ID_DISTRITO_AGENTE`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`ID_FUNCION`);

--
-- Indices de la tabla `grupo_operativo`
--
ALTER TABLE `grupo_operativo`
  ADD PRIMARY KEY (`ID_GRUPO_OPERATIVO`),
  ADD KEY `tipo_grupo_id` (`ID_TIPO_GRUPO`);

--
-- Indices de la tabla `indisponibilidad`
--
ALTER TABLE `indisponibilidad`
  ADD PRIMARY KEY (`ID_INDISPONIBILIDAD`),
  ADD KEY `FK_REFERENCE_5` (`ID_USUARIO`),
  ADD KEY `FK_REFERENCE_6` (`ID_TIPO_INDISPONIBILIDAD`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orden_servicio_grua`
--
ALTER TABLE `orden_servicio_grua`
  ADD PRIMARY KEY (`ID_ORDEN_GRUA`);

--
-- Indices de la tabla `osgo_anexo`
--
ALTER TABLE `osgo_anexo`
  ADD PRIMARY KEY (`ID_ANEXO`),
  ADD KEY `osgo_anexo_id_orden_servicio_index` (`ID_ORDEN_SERVICIO`),
  ADD KEY `osgo_anexo_tipo_anexo_index` (`TIPO_ANEXO`),
  ADD KEY `idx_anexo_tipo` (`TIPO_ANEXO`),
  ADD KEY `idx_anexo_fecha` (`FECHA`),
  ADD KEY `idx_anexo_estado` (`ESTADO`);

--
-- Indices de la tabla `osgo_anexo_detalle`
--
ALTER TABLE `osgo_anexo_detalle`
  ADD PRIMARY KEY (`ID_ANEXO_DETALLE`),
  ADD KEY `osgo_anexo_detalle_id_anexo_index` (`ID_ANEXO`);

--
-- Indices de la tabla `osgo_anexo_recurso`
--
ALTER TABLE `osgo_anexo_recurso`
  ADD PRIMARY KEY (`ID_ANEXO_RECURSO`),
  ADD KEY `osgo_anexo_recurso_id_anexo_index` (`ID_ANEXO`),
  ADD KEY `osgo_anexo_recurso_id_recurso_index` (`ID_RECURSO`);

--
-- Indices de la tabla `osgo_control_horas`
--
ALTER TABLE `osgo_control_horas`
  ADD PRIMARY KEY (`ID_CONTROL_HORAS`),
  ADD UNIQUE KEY `osgo_control_horas_id_persona_fecha_unique` (`ID_PERSONA`,`FECHA`),
  ADD KEY `osgo_control_horas_estado_index` (`ESTADO`),
  ADD KEY `idx_control_persona` (`ID_PERSONA`),
  ADD KEY `idx_control_estado` (`ESTADO`);

--
-- Indices de la tabla `osgo_control_horas_mensuales`
--
ALTER TABLE `osgo_control_horas_mensuales`
  ADD PRIMARY KEY (`ID_CONTROL_MENSUAL`);

--
-- Indices de la tabla `osgo_detalle_orden_servicio`
--
ALTER TABLE `osgo_detalle_orden_servicio`
  ADD PRIMARY KEY (`ID_DET_ORDEN_SERVICIO`),
  ADD KEY `orden_servicio_id` (`ID_ORDEN_SERVICIO`),
  ADD KEY `fk_detalle_funcion` (`ID_FUNCION`),
  ADD KEY `idx_detalle_responsable` (`RESPONSABLE`);

--
-- Indices de la tabla `osgo_estado_orden`
--
ALTER TABLE `osgo_estado_orden`
  ADD PRIMARY KEY (`ID_ESTADO_ORDEN`);

--
-- Indices de la tabla `osgo_historial_horas`
--
ALTER TABLE `osgo_historial_horas`
  ADD PRIMARY KEY (`ID_HISTORIAL`),
  ADD KEY `osgo_historial_horas_id_control_horas_index` (`ID_CONTROL_HORAS`),
  ADD KEY `fk_historial_horas_orden` (`ID_ORDEN_SERVICIO`);

--
-- Indices de la tabla `osgo_horarios`
--
ALTER TABLE `osgo_horarios`
  ADD PRIMARY KEY (`ID_HORARIO`),
  ADD KEY `osgo_horarios_activo_index` (`ACTIVO`);

--
-- Indices de la tabla `osgo_orden_servicio`
--
ALTER TABLE `osgo_orden_servicio`
  ADD PRIMARY KEY (`ID_ORDEN_SERVICIO`),
  ADD KEY `estado_id` (`ID_ESTADO_ORDEN`),
  ADD KEY `idx_orden_fecha` (`FECHA`),
  ADD KEY `idx_orden_estado` (`ID_ESTADO_ORDEN`),
  ADD KEY `idx_orden_creado_por` (`CREADO_POR`);

--
-- Indices de la tabla `osgo_orden_servicio_grua`
--
ALTER TABLE `osgo_orden_servicio_grua`
  ADD PRIMARY KEY (`ID_ORDEN_GRUA`);

--
-- Indices de la tabla `osgo_recursos`
--
ALTER TABLE `osgo_recursos`
  ADD PRIMARY KEY (`ID_RECURSO`),
  ADD KEY `osgo_recursos_tipo_recurso_index` (`TIPO_RECURSO`),
  ADD KEY `osgo_recursos_activo_index` (`ACTIVO`);

--
-- Indices de la tabla `osgo_sectores`
--
ALTER TABLE `osgo_sectores`
  ADD PRIMARY KEY (`ID_SECTOR`);

--
-- Indices de la tabla `osgo_servicio_grua`
--
ALTER TABLE `osgo_servicio_grua`
  ADD PRIMARY KEY (`ID_SERVICIO_GRUA`);

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
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `osgo_vehiculo`
--
ALTER TABLE `osgo_vehiculo`
  ADD PRIMARY KEY (`ID_VEHICULO`),
  ADD UNIQUE KEY `placa` (`PLACA`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`ID_PERSONA`),
  ADD KEY `FK_REFERENCE_7` (`ID_DISTRITO_AGENTE`),
  ADD KEY `FK_REFERENCE_8` (`ID_FUNCION`),
  ADD KEY `fk_personas_grupo` (`ID_GRUPO_OPERATIVO`),
  ADD KEY `idx_persona_funcion` (`ID_FUNCION`),
  ADD KEY `idx_persona_grupo` (`ID_GRUPO_OPERATIVO`),
  ADD KEY `idx_persona_agente` (`AGENTE`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

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
  ADD PRIMARY KEY (`ID_USUARIO`),
  ADD KEY `FK_REFERENCE_1` (`ID_PERSONA`);

--
-- Indices de la tabla `usuario_sistema`
--
ALTER TABLE `usuario_sistema`
  ADD PRIMARY KEY (`ID_USUARIO_SISTEMA`),
  ADD KEY `FK_REFERENCE_3` (`ID_SISTEMA`),
  ADD KEY `FK_REFERENCE_4` (`ID_USUARIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `distritos_agentes`
--
ALTER TABLE `distritos_agentes`
  MODIFY `ID_DISTRITO_AGENTE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `funciones`
--
ALTER TABLE `funciones`
  MODIFY `ID_FUNCION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grupo_operativo`
--
ALTER TABLE `grupo_operativo`
  MODIFY `ID_GRUPO_OPERATIVO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indisponibilidad`
--
ALTER TABLE `indisponibilidad`
  MODIFY `ID_INDISPONIBILIDAD` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `orden_servicio_grua`
--
ALTER TABLE `orden_servicio_grua`
  MODIFY `ID_ORDEN_GRUA` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de la tabla `osgo_estado_orden`
--
ALTER TABLE `osgo_estado_orden`
  MODIFY `ID_ESTADO_ORDEN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `osgo_historial_horas`
--
ALTER TABLE `osgo_historial_horas`
  MODIFY `ID_HISTORIAL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_horarios`
--
ALTER TABLE `osgo_horarios`
  MODIFY `ID_HORARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `osgo_orden_servicio`
--
ALTER TABLE `osgo_orden_servicio`
  MODIFY `ID_ORDEN_SERVICIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `osgo_orden_servicio_grua`
--
ALTER TABLE `osgo_orden_servicio_grua`
  MODIFY `ID_ORDEN_GRUA` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `osgo_recursos`
--
ALTER TABLE `osgo_recursos`
  MODIFY `ID_RECURSO` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `osgo_sectores`
--
ALTER TABLE `osgo_sectores`
  MODIFY `ID_SECTOR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `osgo_servicio_grua`
--
ALTER TABLE `osgo_servicio_grua`
  MODIFY `ID_SERVICIO_GRUA` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `ID_VEHICULO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `ID_PERSONA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

--
-- AUTO_INCREMENT de la tabla `sistemas`
--
ALTER TABLE `sistemas`
  MODIFY `ID_SISTEMA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_grupo`
--
ALTER TABLE `tipo_grupo`
  MODIFY `ID_TIPO_GRUPO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_indisponibilidad`
--
ALTER TABLE `tipo_indisponibilidad`
  MODIFY `ID_TIPO_INDISPONIBILIDAD` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

--
-- AUTO_INCREMENT de la tabla `usuario_sistema`
--
ALTER TABLE `usuario_sistema`
  MODIFY `ID_USUARIO_SISTEMA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=462;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `grupo_operativo`
--
ALTER TABLE `grupo_operativo`
  ADD CONSTRAINT `grupo_operativo_ibfk_1` FOREIGN KEY (`ID_TIPO_GRUPO`) REFERENCES `tipo_grupo` (`ID_TIPO_GRUPO`);

--
-- Filtros para la tabla `indisponibilidad`
--
ALTER TABLE `indisponibilidad`
  ADD CONSTRAINT `FK_REFERENCE_5` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`),
  ADD CONSTRAINT `FK_REFERENCE_6` FOREIGN KEY (`ID_TIPO_INDISPONIBILIDAD`) REFERENCES `tipo_indisponibilidad` (`ID_TIPO_INDISPONIBILIDAD`),
  ADD CONSTRAINT `fk_indisp_tipo` FOREIGN KEY (`ID_TIPO_INDISPONIBILIDAD`) REFERENCES `tipo_indisponibilidad` (`ID_TIPO_INDISPONIBILIDAD`),
  ADD CONSTRAINT `fk_indisp_usuario` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`);

--
-- Filtros para la tabla `osgo_anexo`
--
ALTER TABLE `osgo_anexo`
  ADD CONSTRAINT `fk_anexo_orden` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`) ON DELETE CASCADE,
  ADD CONSTRAINT `osgo_anexo_id_orden_servicio_foreign` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `osgo_anexo_detalle`
--
ALTER TABLE `osgo_anexo_detalle`
  ADD CONSTRAINT `fk_anexo_detalle_anexo` FOREIGN KEY (`ID_ANEXO`) REFERENCES `osgo_anexo` (`ID_ANEXO`) ON DELETE CASCADE;

--
-- Filtros para la tabla `osgo_anexo_recurso`
--
ALTER TABLE `osgo_anexo_recurso`
  ADD CONSTRAINT `osgo_anexo_recurso_id_recurso_foreign` FOREIGN KEY (`ID_RECURSO`) REFERENCES `osgo_recursos` (`ID_RECURSO`) ON DELETE SET NULL;

--
-- Filtros para la tabla `osgo_control_horas`
--
ALTER TABLE `osgo_control_horas`
  ADD CONSTRAINT `osgo_control_horas_id_persona_foreign` FOREIGN KEY (`ID_PERSONA`) REFERENCES `personas` (`ID_PERSONA`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `osgo_detalle_orden_servicio`
--
ALTER TABLE `osgo_detalle_orden_servicio`
  ADD CONSTRAINT `fk_detalle_funcion` FOREIGN KEY (`ID_FUNCION`) REFERENCES `funciones` (`ID_FUNCION`),
  ADD CONSTRAINT `osgo_detalle_orden_servicio_ibfk_1` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`);

--
-- Filtros para la tabla `osgo_historial_horas`
--
ALTER TABLE `osgo_historial_horas`
  ADD CONSTRAINT `fk_historial_horas_orden` FOREIGN KEY (`ID_ORDEN_SERVICIO`) REFERENCES `osgo_orden_servicio` (`ID_ORDEN_SERVICIO`) ON DELETE CASCADE,
  ADD CONSTRAINT `osgo_historial_horas_id_control_horas_foreign` FOREIGN KEY (`ID_CONTROL_HORAS`) REFERENCES `osgo_control_horas` (`ID_CONTROL_HORAS`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `osgo_orden_servicio`
--
ALTER TABLE `osgo_orden_servicio`
  ADD CONSTRAINT `osgo_orden_servicio_ibfk_2` FOREIGN KEY (`ID_ESTADO_ORDEN`) REFERENCES `osgo_estado_orden` (`ID_ESTADO_ORDEN`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `FK_REFERENCE_7` FOREIGN KEY (`ID_DISTRITO_AGENTE`) REFERENCES `distritos_agentes` (`ID_DISTRITO_AGENTE`),
  ADD CONSTRAINT `FK_REFERENCE_8` FOREIGN KEY (`ID_FUNCION`) REFERENCES `funciones` (`ID_FUNCION`),
  ADD CONSTRAINT `fk_personas_distrito` FOREIGN KEY (`ID_DISTRITO_AGENTE`) REFERENCES `distritos_agentes` (`ID_DISTRITO_AGENTE`),
  ADD CONSTRAINT `fk_personas_funcion` FOREIGN KEY (`ID_FUNCION`) REFERENCES `funciones` (`ID_FUNCION`),
  ADD CONSTRAINT `fk_personas_grupo` FOREIGN KEY (`ID_GRUPO_OPERATIVO`) REFERENCES `grupo_operativo` (`ID_GRUPO_OPERATIVO`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_persona` FOREIGN KEY (`ID_PERSONA`) REFERENCES `personas` (`ID_PERSONA`);

--
-- Filtros para la tabla `usuario_sistema`
--
ALTER TABLE `usuario_sistema`
  ADD CONSTRAINT `fk_usist_sistema` FOREIGN KEY (`ID_SISTEMA`) REFERENCES `sistemas` (`ID_SISTEMA`),
  ADD CONSTRAINT `fk_usist_usuario` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
