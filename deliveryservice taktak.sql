-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 28, 2022 at 05:43 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deliveryservice`
--
CREATE DATABASE IF NOT EXISTS `deliveryservice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `deliveryservice`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(6) NOT NULL,
  `street` varchar(20) NOT NULL,
  `plz` int(6) NOT NULL,
  `hausNr` int(3) NOT NULL,
  `city` varchar(12) NOT NULL,
  `country` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `street`, `plz`, `hausNr`, `city`, `country`) VALUES
(1, 'praterstraße', 1020, 200, 'Wien', 'Österreich'),
(2, 'stephansplatz', 1010, 50, 'Wien', 'Österreich'),
(3, 'Karlsplatz', 1040, 20, 'Wien', 'Österreich'),
(4, 'Reumannplatz', 1100, 14, 'Wien', 'Österreich'),
(5, 'Nestroyplatz', 1020, 6, 'Wien', 'Österreich'),
(6, 'Speizingergasse', 1200, 10, 'Wien', 'Österreich'),
(7, 'Davidgasse', 1230, 200, 'Wien', 'Österreich'),
(8, 'Grellgasse', 1210, 18, 'Wien', 'Österreich'),
(9, 'Berlinergasse', 1010, 23, 'Wien', 'Österreich');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` int(6) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `constructionYear` int(4) DEFAULT NULL,
  `mark` varchar(10) DEFAULT NULL,
  `fkDriver` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `brand`, `constructionYear`, `mark`, `fkDriver`) VALUES
(1, 'OPEL', 2013, 'W 165 220', 1),
(2, 'Mercedes', 2019, 'WBNB 007', 2),
(3, 'VW', 2018, 'THC 1101 W', 3),
(4, 'Mercedes', 1999, 'Test 105 2', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deliver`
--

CREATE TABLE `deliver` (
  `fkObject` int(6) NOT NULL,
  `fkEmployee` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `deliverycompany`
--

CREATE TABLE `deliverycompany` (
  `id` int(6) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `fkOpeningHours` int(6) DEFAULT NULL,
  `companyName` varchar(30) NOT NULL,
  `website` varchar(60) NOT NULL,
  `fkAddress` int(6) NOT NULL,
  `phoneNr` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deliverycompany`
--

INSERT INTO `deliverycompany` (`id`, `email`, `fkOpeningHours`, `companyName`, `website`, `fkAddress`, `phoneNr`) VALUES
(1, 'wedeliver@mail.at', 1, 'WeDeliver', 'www.wedeliver.com', 5, 214657384);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(6) NOT NULL,
  `job` enum('support','branch manager','driver') DEFAULT NULL,
  `fName` varchar(15) NOT NULL,
  `lName` varchar(15) NOT NULL,
  `available` enum('true','false') DEFAULT 'true',
  `fkAddress` int(6) NOT NULL,
  `driverLicense` enum('true','false') DEFAULT NULL,
  `car` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `job`, `fName`, `lName`, `available`, `fkAddress`, `driverLicense`, `car`) VALUES
(1, 'driver', 'Abbas', 'Ali', 'true', 3, 'true', 1),
(2, 'driver', 'jaafar', 'khadour', 'true', 2, 'true', 2),
(3, 'support', 'Alan', 'Mohammed', 'false', 0, 'false', NULL),
(4, 'driver', 'Johanna', 'Müller', 'true', 6, 'true', 3),
(5, 'branch manager', 'Rafael', 'Reinhart', 'true', 6, 'false', NULL),
(6, 'support', 'Markus', 'Ürget', 'true', 3, 'true', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gets`
--

CREATE TABLE `gets` (
  `fkDeliveryCompany` int(6) NOT NULL,
  `fkObject` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `has`
--

CREATE TABLE `has` (
  `fkSender` int(6) NOT NULL,
  `fkObject` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hires`
--

CREATE TABLE `hires` (
  `fkDeliveryCompany` int(6) DEFAULT NULL,
  `fkEmployees` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `object`
--

CREATE TABLE `object` (
  `id` int(6) NOT NULL,
  `recipientAddress` int(6) NOT NULL,
  `senderAddress` int(6) NOT NULL,
  `weight` varchar(8) DEFAULT NULL,
  `recipientName` varchar(15) NOT NULL,
  `senderName` varchar(15) NOT NULL,
  `type` enum('Mail','Package') DEFAULT NULL,
  `sendingDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `object`
--

INSERT INTO `object` (`id`, `recipientAddress`, `senderAddress`, `weight`, `recipientName`, `senderName`, `type`, `sendingDate`) VALUES
(1, 1, 2, '2,5 kg', 'Ali', 'Abbas', 'Package', '2021-12-19 12:05:26'),
(2, 6, 4, NULL, 'Tuqa', 'Aya', 'Mail', '2021-12-19 12:09:06'),
(3, 9, 8, '10 kg', 'Johannes', 'Daniel', 'Package', '2021-12-19 12:10:11');

-- --------------------------------------------------------

--
-- Table structure for table `openinghours`
--

CREATE TABLE `openinghours` (
  `id` int(6) NOT NULL,
  `openingDays` varchar(40) NOT NULL,
  `openingHours` varchar(20) DEFAULT NULL,
  `freeDays` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `openinghours`
--

INSERT INTO `openinghours` (`id`, `openingDays`, `openingHours`, `freeDays`) VALUES
(1, 'Monday - Friday', '8:00 - 18:00', 'Saturday and Sunday');

-- --------------------------------------------------------

--
-- Table structure for table `recipient`
--

CREATE TABLE `recipient` (
  `id` int(6) NOT NULL,
  `fkFName` varchar(15) NOT NULL,
  `fkLName` varchar(15) NOT NULL,
  `fkAddress` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sender`
--

CREATE TABLE `sender` (
  `id` int(6) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `address` int(6) NOT NULL,
  `phoneNr` int(15) NOT NULL,
  `fName` varchar(15) NOT NULL,
  `lName` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sender`
--

INSERT INTO `sender` (`id`, `email`, `address`, `phoneNr`, `fName`, `lName`) VALUES
(1, 'amine1997@gmail.com', 1, 66778899, 'Amine', 'Alahmad'),
(2, 'SaadAD@hotmail.at', 4, 33744400, 'Saad', 'saadun'),
(3, 'amina@hotmail.com', 7, 33742200, 'Amina', 'Alabdo'),
(4, 'ElisaFeelings@elisa.at', 1, 3273200, 'Elisa', 'Khuri');

-- --------------------------------------------------------

--
-- Table structure for table `to`
--

CREATE TABLE `to` (
  `fkObject` int(6) NOT NULL,
  `fkRecipient` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliver`
--
ALTER TABLE `deliver`
  ADD KEY `fkObject` (`fkObject`),
  ADD KEY `fkEmployee` (`fkEmployee`);

--
-- Indexes for table `deliverycompany`
--
ALTER TABLE `deliverycompany`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website` (`website`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fkOpeningHours` (`fkOpeningHours`),
  ADD KEY `fkAddress` (`fkAddress`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `car` (`car`);

--
-- Indexes for table `gets`
--
ALTER TABLE `gets`
  ADD KEY `fkObject` (`fkObject`),
  ADD KEY `fkDeliveryCompany` (`fkDeliveryCompany`);

--
-- Indexes for table `has`
--
ALTER TABLE `has`
  ADD KEY `fkSender` (`fkSender`),
  ADD KEY `fkObject` (`fkObject`);

--
-- Indexes for table `hires`
--
ALTER TABLE `hires`
  ADD KEY `fkDeliveryCompany` (`fkDeliveryCompany`),
  ADD KEY `fkEmployees` (`fkEmployees`);

--
-- Indexes for table `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipientAddress` (`recipientAddress`),
  ADD KEY `senderAddress` (`senderAddress`);

--
-- Indexes for table `openinghours`
--
ALTER TABLE `openinghours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sender`
--
ALTER TABLE `sender`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phoneNr` (`phoneNr`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `address` (`address`);

--
-- Indexes for table `to`
--
ALTER TABLE `to`
  ADD KEY `fkObject` (`fkObject`),
  ADD KEY `fkRecipient` (`fkRecipient`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `deliverycompany`
--
ALTER TABLE `deliverycompany`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `object`
--
ALTER TABLE `object`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `openinghours`
--
ALTER TABLE `openinghours`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recipient`
--
ALTER TABLE `recipient`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sender`
--
ALTER TABLE `sender`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deliver`
--
ALTER TABLE `deliver`
  ADD CONSTRAINT `deliver_ibfk_1` FOREIGN KEY (`fkObject`) REFERENCES `object` (`id`),
  ADD CONSTRAINT `deliver_ibfk_2` FOREIGN KEY (`fkEmployee`) REFERENCES `employee` (`id`);

--
-- Constraints for table `deliverycompany`
--
ALTER TABLE `deliverycompany`
  ADD CONSTRAINT `deliverycompany_ibfk_1` FOREIGN KEY (`fkOpeningHours`) REFERENCES `openinghours` (`id`),
  ADD CONSTRAINT `deliverycompany_ibfk_2` FOREIGN KEY (`fkAddress`) REFERENCES `address` (`id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`car`) REFERENCES `cars` (`id`);

--
-- Constraints for table `gets`
--
ALTER TABLE `gets`
  ADD CONSTRAINT `gets_ibfk_1` FOREIGN KEY (`fkObject`) REFERENCES `object` (`id`),
  ADD CONSTRAINT `gets_ibfk_2` FOREIGN KEY (`fkDeliveryCompany`) REFERENCES `deliverycompany` (`id`);

--
-- Constraints for table `has`
--
ALTER TABLE `has`
  ADD CONSTRAINT `has_ibfk_1` FOREIGN KEY (`fkSender`) REFERENCES `sender` (`id`),
  ADD CONSTRAINT `has_ibfk_2` FOREIGN KEY (`fkObject`) REFERENCES `object` (`id`);

--
-- Constraints for table `hires`
--
ALTER TABLE `hires`
  ADD CONSTRAINT `hires_ibfk_1` FOREIGN KEY (`fkDeliveryCompany`) REFERENCES `deliverycompany` (`id`),
  ADD CONSTRAINT `hires_ibfk_2` FOREIGN KEY (`fkEmployees`) REFERENCES `employee` (`id`);

--
-- Constraints for table `object`
--
ALTER TABLE `object`
  ADD CONSTRAINT `object_ibfk_1` FOREIGN KEY (`recipientAddress`) REFERENCES `address` (`id`),
  ADD CONSTRAINT `object_ibfk_2` FOREIGN KEY (`senderAddress`) REFERENCES `address` (`id`);

--
-- Constraints for table `recipient`
--
ALTER TABLE `recipient`
  ADD CONSTRAINT `recipient_ibfk_1` FOREIGN KEY (`id`) REFERENCES `object` (`id`);

--
-- Constraints for table `sender`
--
ALTER TABLE `sender`
  ADD CONSTRAINT `sender_ibfk_1` FOREIGN KEY (`address`) REFERENCES `address` (`id`);

--
-- Constraints for table `to`
--
ALTER TABLE `to`
  ADD CONSTRAINT `to_ibfk_1` FOREIGN KEY (`fkObject`) REFERENCES `object` (`id`),
  ADD CONSTRAINT `to_ibfk_2` FOREIGN KEY (`fkRecipient`) REFERENCES `recipient` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
