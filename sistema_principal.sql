-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2025 a las 18:47:35
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
  MODIFY `ID_DISTRITO_AGENTE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `ID_PERSONA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;

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
  MODIFY `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
