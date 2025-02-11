-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 07/02/2025 às 01:07
-- Versão do servidor: 10.11.8-MariaDB-0ubuntu0.24.04.1
-- Versão do PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `lambreta`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `liga`
--

CREATE TABLE `liga` (
  `id` int(11) NOT NULL,
  `nome` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `liga`
--

INSERT INTO `liga` (`id`, `nome`) VALUES
(1, 'Brasileirão Betano'),
(2, 'Premier League'),
(3, 'La Liga EA Sports'),
(4, 'Serie A Enilive');

-- --------------------------------------------------------

--
-- Estrutura para tabela `time`
--

CREATE TABLE `time` (
  `id` int(11) NOT NULL,
  `nome` varchar(70) NOT NULL,
  `id_liga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `time`
--

INSERT INTO `time` (`id`, `nome`, `id_liga`) VALUES
(101, 'São Paulo', 1),
(102, 'Athletico Paranaense', 1),
(103, 'Flamengo', 1),
(104, 'Fortaleza', 1),
(105, 'Cuiabá', 1),
(106, 'Atlético Mineiro', 1),
(107, 'Botafogo', 1),
(108, 'América MG', 1),
(109, 'Santos', 1),
(110, 'Fluminense', 1),
(111, 'Grêmio', 1),
(112, 'Goiás', 1),
(113, 'Cruzeiro', 1),
(114, 'Vasco', 1),
(115, 'Coritiba', 1),
(116, 'Red Bull Bragantino', 1),
(117, 'Bahia', 1),
(118, 'Internacional', 1),
(119, 'Palmeiras', 1),
(120, 'Corinthians', 1),
(201, 'Wolverhampton', 2),
(202, 'Tottenham Hotspur', 2),
(203, 'Aston Villa', 2),
(204, 'Watford', 2),
(205, 'West Ham', 2),
(206, 'Leeds United', 2),
(207, 'Brighton & Hove Albion', 2),
(208, 'Arsenal', 2),
(209, 'Norwich City', 2),
(210, 'Southampton', 2),
(211, 'Everton', 2),
(212, 'Crystal Palace', 2),
(213, 'Brentford', 2),
(214, 'Manchester City', 2),
(215, 'Burnley', 2),
(216, 'Chelsea', 2),
(217, 'Liverpool', 2),
(218, 'Leicester City', 2),
(219, 'Manchester United', 2),
(220, 'Newcastle United', 2),
(301, 'Real Mallorca', 3),
(302, 'Getafe', 3),
(303, 'Real Madrid', 3),
(304, 'Deportivo Alaves', 3),
(305, 'Cadiz CF', 3),
(306, 'Real Sociedad', 3),
(307, 'Levante', 3),
(308, 'Rayo Vallecano', 3),
(309, 'Villareal', 3),
(310, 'Elche', 3),
(311, 'Sevilla', 3),
(312, 'Athletic Club de Bilbao', 3),
(313, 'Barcelona', 3),
(314, 'Espanyol de Barcelona', 3),
(315, 'Osasuna', 3),
(316, 'Valencia', 3),
(317, 'Granada', 3),
(318, 'Real Betis', 3),
(319, 'Celta Vigo', 3),
(320, 'Atletico de Madrid', 3),
(401, 'Venezia', 4),
(402, 'Empoli', 4),
(403, 'Udinese', 4),
(404, 'Roma', 4),
(405, 'Spezia', 4),
(406, 'Sassuolo', 4),
(407, 'Atalanta', 4),
(408, 'Torino', 4),
(409, 'Cagliari', 4),
(410, 'Milan', 4),
(411, 'Genoa', 4),
(412, 'Inter de Milão', 4),
(413, 'Lazio', 4),
(414, 'Sampdoria', 4),
(415, 'Salernitana', 4),
(416, 'Napoli', 4),
(417, 'Bologna', 4),
(418, 'Verona', 4),
(419, 'Fiorentina', 4),
(420, 'Juventus', 4);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `liga`
--
ALTER TABLE `liga`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `time`
--
ALTER TABLE `time`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
