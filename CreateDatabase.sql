-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2013 at 08:06 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `piofthetiger`
--
CREATE DATABASE `piofthetiger` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_mysql500_ci;
USE `piofthetiger`;

-- --------------------------------------------------------

--
-- Table structure for table `addressbook`
--

CREATE TABLE IF NOT EXISTS `addressbook` (
  `IdAddressBook` int(4) NOT NULL,
  `EmailAddress` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `AddressName` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  PRIMARY KEY (`IdAddressBook`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

--
-- Dumping data for table `addressbook`
--

INSERT INTO `addressbook` (`IdAddressBook`, `EmailAddress`, `AddressName`) VALUES
(1, 'shaikhan2702@yahoo.com', 'Robert'),
(2, 'mb.ghinea@gmail.com', 'Ghinea'),
(3, 'fantasycl2003@yahoo.com', 'Mishu');

-- --------------------------------------------------------

--
-- Table structure for table `appsettings`
--

CREATE TABLE IF NOT EXISTS `appsettings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Key` varchar(255) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Value` varchar(8000) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Description` varchar(8000) COLLATE utf8_general_mysql500_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `appsettings`
--

INSERT INTO `appsettings` (`ID`, `Key`, `Value`, `Description`) VALUES
(1, 'SMTPServer', 'smtp.gmail.com', NULL),
(2, 'SMTPUserName', 'PiOTT.Alerts@gmail.com', NULL),
(3, 'SMTPPassword', '1234%asd', NULL),
(4, 'SMTPPort', '587', NULL),
(5, 'SMTPUseSSL', 'true', NULL),
(6, 'PicturesSavePath', 'C:\\Users\\Mishu\\Documents\\GitHub\\Shiretii\\PiOfTheTiger.Web\\public\\pictures', NULL),
(7, 'PicturesSaveInterval', '2', NULL),
(8, 'PicturesCompareTolerance', '4', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `camera`
--

CREATE TABLE IF NOT EXISTS `camera` (
  `IdCamera` int(11) NOT NULL AUTO_INCREMENT,
  `CameraName` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Path` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `PictureHeight` int(11) NOT NULL,
  `PictureWidth` int(11) NOT NULL,
  PRIMARY KEY (`IdCamera`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `camera`
--

INSERT INTO `camera` (`IdCamera`, `CameraName`, `Path`, `PictureHeight`, `PictureWidth`) VALUES
(1, 'Camera 1', '/dev/usb/hiddev1', 600, 800);

-- --------------------------------------------------------

--
-- Table structure for table `sentemail`
--

CREATE TABLE IF NOT EXISTS `sentemail` (
  `IdSentEmail` int(11) NOT NULL AUTO_INCREMENT,
  `SentDate` datetime NOT NULL,
  `To` varchar(100) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Cc` varchar(50) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Subject` varchar(500) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Body` varchar(8000) COLLATE utf8_general_mysql500_ci NOT NULL,
  PRIMARY KEY (`IdSentEmail`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `sentemail`
--

INSERT INTO `sentemail` (`IdSentEmail`, `SentDate`, `To`, `Cc`, `Subject`, `Body`) VALUES
(1, '2013-04-21 03:13:16', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(2, '2013-04-21 06:10:51', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(3, '2013-04-21 07:31:50', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(4, '2013-04-21 07:57:47', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(5, '2013-04-21 08:02:46', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(6, '2013-04-21 08:03:49', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(7, '2013-04-21 08:04:11', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(8, '2013-04-21 08:04:43', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(9, '2013-04-21 08:06:18', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>'),
(10, '2013-04-21 08:06:29', 'mb.ghinea@gmail.com, shaikhan2702@yahoo.com, fantasycl2003@yahoo.com', 'PiOTT.Alerts@gmail.com', 'PiOTT - Test Send Mail', '<p>Acesta este un test!</p>');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `IdUser` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Password` varchar(20) COLLATE utf8_general_mysql500_ci NOT NULL,
  `Sex` smallint(6) NOT NULL,
  PRIMARY KEY (`IdUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`IdUser`, `Username`, `Password`, `Sex`) VALUES
(1, 'admin', 'a', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
