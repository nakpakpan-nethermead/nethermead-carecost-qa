-- phpMyAdmin SQL Dump
-- version 4.0.2-rc1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 24, 2014 at 02:16 PM
-- Server version: 5.6.19
-- PHP Version: 5.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `clear_cost_dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE IF NOT EXISTS `providers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npi` text COLLATE utf8_unicode_ci,
  `npi_surrogate` text COLLATE utf8_unicode_ci,
  `first_name` text COLLATE utf8_unicode_ci,
  `org_last_name` text COLLATE utf8_unicode_ci,
  `designations` tinytext COLLATE utf8_unicode_ci,
  `img_url` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_suite_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_zip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_entity_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `physician_since` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_providers_on_id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`id`, `npi`, `npi_surrogate`, `first_name`, `org_last_name`, `designations`, `img_url`, `created_at`, `updated_at`, `provider_type`, `gender`, `provider_address`, `provider_suite_number`, `provider_city`, `provider_zip`, `provider_county`, `provider_state`, `provider_country`, `provider_entity_type`, `physician_since`) VALUES
(1, 'demo', 'demo', 'Senthil', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(2, 'demo', 'demo', 'Munu', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(3, 'demo', 'demo', 'Chandhar', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(4, 'demo', 'demo', 'Sathish', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(5, 'demo', 'demo', 'Hari', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(6, 'demo', 'demo', 'Parag', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002'),
(7, 'demo', 'demo', 'Pratip', 'Kumar', 'Developer', 'doctor.jpg', NULL, NULL, 'home', 'M', 'no 127, beach colony , US', '123123', 'New York', '31267', 'GA', 'GA', 'USA', 'Office', '2002');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
