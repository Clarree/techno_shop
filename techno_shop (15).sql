-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 08 2024 г., 23:18
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `techno_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `деталі_замовлення`
--

CREATE TABLE `деталі_замовлення` (
  `ID` int(11) NOT NULL,
  `Кількість` int(11) DEFAULT NULL,
  `ID_замовлення` int(11) DEFAULT NULL,
  `ID_товару` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `деталі_замовлення`
--

INSERT INTO `деталі_замовлення` (`ID`, `Кількість`, `ID_замовлення`, `ID_товару`) VALUES
(1, 2, 1, 1),
(2, 1, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `користувач`
--

CREATE TABLE `користувач` (
  `ID` int(11) NOT NULL,
  `Логін` varchar(255) DEFAULT NULL,
  `Пароль` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `користувач`
--

INSERT INTO `користувач` (`ID`, `Логін`, `Пароль`) VALUES
(1, 'golubegor', '$2y$10$ADzye8nY.ivbxNKG0uiLYeZdDmNAExCM2hzGwBKCtJxsA465w53YK'),
(2, 'golubegor', '$2y$10$MddeD0A3fp8ddBUg/VVFxeGieLs7WJdTIK4gHboI2MjNSlsBWqNq6');

-- --------------------------------------------------------

--
-- Структура таблицы `платіж`
--

CREATE TABLE `платіж` (
  `ID` int(11) NOT NULL,
  `Сума` decimal(10,2) DEFAULT NULL,
  `Тип_платежу` varchar(255) DEFAULT NULL,
  `ID_замовлення` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `платіж`
--

INSERT INTO `платіж` (`ID`, `Сума`, `Тип_платежу`, `ID_замовлення`) VALUES
(1, 5000.00, 'Готівка', 1),
(2, 15000.00, 'Картка', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `покупець`
--

CREATE TABLE `покупець` (
  `ID` int(11) NOT NULL,
  `Ім_я` varchar(255) DEFAULT NULL,
  `Адреса` varchar(255) DEFAULT NULL,
  `Контактні_дані` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `покупець`
--

INSERT INTO `покупець` (`ID`, `Ім_я`, `Адреса`, `Контактні_дані`) VALUES
(1, 'Іванов Іван', 'Київ', 'ivan@example.com'),
(2, 'Петров Петро', 'Львів', 'petro@example.com');

-- --------------------------------------------------------

--
-- Структура таблицы `замовлення`
--

CREATE TABLE `замовлення` (
  `ID` int(11) NOT NULL,
  `Дата` date DEFAULT NULL,
  `Статус` varchar(255) DEFAULT NULL,
  `ID_покупця` int(11) DEFAULT NULL,
  `ID_товару` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `замовлення`
--

INSERT INTO `замовлення` (`ID`, `Дата`, `Статус`, `ID_покупця`, `ID_товару`) VALUES
(1, '2023-01-01', 'Очікується', 1, 1),
(2, '2023-01-02', 'Виконано', 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `товар`
--

CREATE TABLE `товар` (
  `ID` int(11) NOT NULL,
  `Назва` varchar(255) DEFAULT NULL,
  `Опис` text DEFAULT NULL,
  `Ціна` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `товар`
--

INSERT INTO `товар` (`ID`, `Назва`, `Опис`, `Ціна`) VALUES
(0, 'Планшет', NULL, 10000.00),
(1, 'Смартфон', 'Опис смартфона', 5000.00),
(2, 'Ноутбук', 'Опис ноутбука', 15000.00);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `деталі_замовлення`
--
ALTER TABLE `деталі_замовлення`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_замовлення` (`ID_замовлення`),
  ADD KEY `ID_товару` (`ID_товару`);

--
-- Индексы таблицы `користувач`
--
ALTER TABLE `користувач`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `платіж`
--
ALTER TABLE `платіж`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_замовлення` (`ID_замовлення`);

--
-- Индексы таблицы `покупець`
--
ALTER TABLE `покупець`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `замовлення`
--
ALTER TABLE `замовлення`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_покупця` (`ID_покупця`),
  ADD KEY `ID_товару` (`ID_товару`);

--
-- Индексы таблицы `товар`
--
ALTER TABLE `товар`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `користувач`
--
ALTER TABLE `користувач`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1345;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `деталі_замовлення`
--
ALTER TABLE `деталі_замовлення`
  ADD CONSTRAINT `деталі_замовлення_ibfk_1` FOREIGN KEY (`ID_замовлення`) REFERENCES `замовлення` (`ID`),
  ADD CONSTRAINT `деталі_замовлення_ibfk_2` FOREIGN KEY (`ID_товару`) REFERENCES `товар` (`ID`);

--
-- Ограничения внешнего ключа таблицы `платіж`
--
ALTER TABLE `платіж`
  ADD CONSTRAINT `платіж_ibfk_1` FOREIGN KEY (`ID_замовлення`) REFERENCES `замовлення` (`ID`);

--
-- Ограничения внешнего ключа таблицы `замовлення`
--
ALTER TABLE `замовлення`
  ADD CONSTRAINT `замовлення_ibfk_1` FOREIGN KEY (`ID_покупця`) REFERENCES `покупець` (`ID`),
  ADD CONSTRAINT `замовлення_ibfk_2` FOREIGN KEY (`ID_товару`) REFERENCES `товар` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
