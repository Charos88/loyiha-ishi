-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 13 2024 г., 10:34
-- Версия сервера: 10.4.6-MariaDB
-- Версия PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Alfraganus`
--
CREATE DATABASE IF NOT EXISTS `Alfraganus` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Alfraganus`;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `Bio pasport malumotlari`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `Bio pasport malumotlari` (
`Id` int(15)
,`Ismi` varchar(15)
,`Familyasi` varchar(15)
,`Sharifi` int(11)
);

-- --------------------------------------------------------

--
-- Структура таблицы `Xusnora jo'ja`
--

CREATE TABLE `Xusnora jo'ja` (
  `Id` int(15) DEFAULT NULL,
  `Ismi` varchar(15) NOT NULL,
  `Familyasi` varchar(15) NOT NULL,
  `Sharifi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура для представления `Bio pasport malumotlari`
--
DROP TABLE IF EXISTS `Bio pasport malumotlari`;

CREATE ALGORITHM=UNDEFINED DEFINER=`SELECT`@`%` SQL SECURITY DEFINER VIEW `Bio pasport malumotlari`  AS SELECT `Xusnora jo'ja`.`Id` AS `Id`, `Xusnora jo'ja`.`Ismi` AS `Ismi`, `Xusnora jo'ja`.`Familyasi` AS `Familyasi`, `Xusnora jo'ja`.`Sharifi` AS `Sharifi` FROM `Xusnora jo'ja` ;
--
-- База данных: `bio_passport`
--
CREATE DATABASE IF NOT EXISTS `bio_passport` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bio_passport`;

-- --------------------------------------------------------

--
-- Структура таблицы `biometric_data`
--

CREATE TABLE `biometric_data` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fingerprint` blob DEFAULT NULL,
  `face_image` blob DEFAULT NULL,
  `iris_scan` blob DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `biometric_data`
--

INSERT INTO `biometric_data` (`id`, `user_id`, `fingerprint`, `face_image`, `iris_scan`, `timestamp`) VALUES
(1, 1, NULL, NULL, NULL, '2024-12-13 10:34:04'),
(2, 2, NULL, NULL, NULL, '2024-12-13 10:34:04'),
(3, 3, NULL, NULL, NULL, '2024-12-13 10:34:04');

-- --------------------------------------------------------

--
-- Структура таблицы `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `action`, `timestamp`) VALUES
(1, 1, 'User logged in', '2024-12-13 10:34:05'),
(2, 2, 'User updated passport information', '2024-12-13 10:34:05'),
(3, 3, 'Admin deleted biometric data for user', '2024-12-13 10:34:05');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `passport_number` varchar(20) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `date_of_issue` date NOT NULL,
  `expiry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `dob`, `gender`, `passport_number`, `nationality`, `date_of_issue`, `expiry_date`) VALUES
(1, 'John', 'Doe', '1990-05-15', 'male', 'A1234567', 'USA', '2015-06-01', '2025-06-01'),
(2, 'Jane', 'Smith', '1985-03-20', 'female', 'B7654321', 'UK', '2016-07-15', '2026-07-15'),
(3, 'Alex', 'Johnson', '1992-11-30', 'male', 'C9876543', 'Canada', '2018-01-20', '2028-01-20');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `biometric_data`
--
ALTER TABLE `biometric_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `passport_number` (`passport_number`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `biometric_data`
--
ALTER TABLE `biometric_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `biometric_data`
--
ALTER TABLE `biometric_data`
  ADD CONSTRAINT `biometric_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- База данных: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
