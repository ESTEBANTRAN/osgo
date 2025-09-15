-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-09-2025 a las 22:27:49
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

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `osgo_estado_orden`
--
ALTER TABLE `osgo_estado_orden`
  ADD PRIMARY KEY (`ID_ESTADO_ORDEN`);

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
  ADD UNIQUE KEY `osgo_users_email_unique` (`email`);

--
-- Indices de la tabla `osgo_vehiculo`
--
ALTER TABLE `osgo_vehiculo`
  ADD PRIMARY KEY (`ID_VEHICULO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

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
  MODIFY `ID_VEHICULO` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
