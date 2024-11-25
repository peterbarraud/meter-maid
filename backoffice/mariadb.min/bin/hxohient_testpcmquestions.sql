-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 28, 2023 at 11:57 AM
-- Server version: 8.0.34
-- PHP Version: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hxohient_testpcmquestions`
--

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `id` tinyint NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `question_id` smallint UNSIGNED DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `file_name` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`id`, `description`, `question_id`, `url`, `file_name`) VALUES
(26, NULL, 26, 'http://ROTATIONALDYNAMICSA1', '3a46ee65d8804883943eb75fb11cb425.png'),
(27, NULL, 27, 'http://ROTATIONALDYNAMICSA1', '6cf22e6b4c584d699ea26eb18de386c7.png');

-- --------------------------------------------------------

--
-- Table structure for table `appuser`
--

CREATE TABLE `appuser` (
  `id` tinyint UNSIGNED NOT NULL,
  `email` varchar(200) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  `showtimer` char(1) DEFAULT '1',
  `lastapprefresh` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `appuser`
--

INSERT INTO `appuser` (`id`, `email`, `pwd`, `firstname`, `lastname`, `role`, `showtimer`, `lastapprefresh`) VALUES
(1, 'pokerj@gmail.com', 'pokerj#07', 'Poker', 'John', 'student', '1', '2023-09-25 04:48:25'),
(2, 'gapeterb@gmail.com', 'pokerj#07', 'Peter', 'Barraud', 'admin', '1', '2023-09-25 03:51:33');

-- --------------------------------------------------------

--
-- Table structure for table `choice`
--

CREATE TABLE `choice` (
  `id` smallint UNSIGNED NOT NULL,
  `question_id` smallint UNSIGNED NOT NULL,
  `correct_ans` tinyint(1) DEFAULT NULL,
  `file_name` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` smallint UNSIGNED NOT NULL,
  `q_type_id` tinyint DEFAULT NULL,
  `topic_id` tinyint UNSIGNED NOT NULL,
  `file_name` char(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`id`, `q_type_id`, `topic_id`, `file_name`) VALUES
(26, 3, 30, '2ec76fef255e439fabf51580206563eb.png'),
(27, 3, 30, 'c9a0e62324b44899b18f3e3986705f65.png');

-- --------------------------------------------------------

--
-- Table structure for table `questiontype`
--

CREATE TABLE `questiontype` (
  `id` tinyint UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questiontype`
--

INSERT INTO `questiontype` (`id`, `name`, `title`) VALUES
(1, 'mcq', 'MCQ'),
(2, 'tf', 'True / False'),
(3, 'long', 'Long form'),
(4, 'mmcq', 'Multiple, multiple choice');

-- --------------------------------------------------------

--
-- Table structure for table `studentattempted`
--

CREATE TABLE `studentattempted` (
  `id` smallint UNSIGNED NOT NULL,
  `question_id` smallint UNSIGNED NOT NULL,
  `student_id` tinyint UNSIGNED NOT NULL,
  `timetakeninsec` tinyint DEFAULT NULL,
  `timeattempted_ts` timestamp NULL DEFAULT NULL,
  `score` decimal(6,2) DEFAULT NULL,
  `attempts` tinyint UNSIGNED DEFAULT NULL,
  `savefordoubt` varchar(1) DEFAULT NULL,
  `isnote` char(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studentattempted`
--

INSERT INTO `studentattempted` (`id`, `question_id`, `student_id`, `timetakeninsec`, `timeattempted_ts`, `score`, `attempts`, `savefordoubt`, `isnote`) VALUES
(6, 27, 1, 0, '2023-09-22 10:37:23', 1.00, 0, '0', '0'),
(7, 26, 1, 0, '2023-09-23 16:53:37', 1.00, 0, '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` tinyint UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `name`, `title`) VALUES
(1, 'physics', 'Physics on Stage'),
(2, 'chemistry', 'Chemistry on Stage'),
(3, 'maths', 'Mathematics on Stage');

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE `topic` (
  `id` tinyint UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `subject_id` tinyint UNSIGNED NOT NULL,
  `show_topic` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `topic`
--

INSERT INTO `topic` (`id`, `title`, `subject_id`, `show_topic`) VALUES
(1, 'Solid State', 2, '0'),
(2, 'Metallurgy', 2, '0'),
(3, 'THERMODYNAMICS-02', 2, '0'),
(4, 'Aldol & Similar Name Reactions', 2, '0'),
(5, 'Purification & Characterisation of Organic Compounds', 2, '0'),
(6, 'Reduction', 2, '0'),
(7, 'THERMOCHEMISTRY', 2, '0'),
(8, 'Hydrocarbon', 2, '0'),
(9, 'Quantum Number', 2, '0'),
(10, 'Nomenclature and Common Names', 2, '1'),
(11, 'Carbonyl Compound', 2, '0'),
(12, '├»┬╗┬┐Halogen Derivative', 2, '0'),
(13, 'Chemical Kinetics', 2, '0'),
(14, 'Periodic Table', 2, '0'),
(15, 'Acidic Strength and Basic Strength', 2, '0'),
(16, 'Stereoisomerism', 2, '0'),
(17, 'Coordination Chemistry', 2, '0'),
(18, 'Isomerism', 2, '0'),
(19, 'Alcohol & Ether', 2, '0'),
(20, 'CONCENTRATION TERMS', 2, '0'),
(21, 'Liquid Solution', 2, '0'),
(22, 'REDOX & EQUIVALENT CONCEPTS', 2, '0'),
(23, 'Electronic Displacement Effects', 2, '1'),
(24, 'MOLE CONCEPT & EUDIOMETRY', 2, '0'),
(25, 'Oxidation', 2, '0'),
(26, 'Chemical Bonding', 2, '0'),
(27, 'IONIC EQUILIBRIUM', 2, '1'),
(28, 'Content', 2, '0'),
(29, 'THERMODYNAMICS-01', 2, '0'),
(30, 'Rotational Dynamics', 1, '1'),
(31, 'Circular Motion', 1, '1'),
(32, 'Geometrical Optics', 1, '1'),
(33, '├»┬╗┬┐', 1, '0'),
(34, 'Work, Power & Energy', 1, '1'),
(35, 'Simple Harmonic Motion', 1, '1'),
(36, 'Center of Mass, Momentum & Collision', 1, '0'),
(37, 'Capacitance', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `trapcmsys`
--

CREATE TABLE `trapcmsys` (
  `id` tinyint NOT NULL,
  `lastbuild` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trapcmsys`
--

INSERT INTO `trapcmsys` (`id`, `lastbuild`, `title`) VALUES
(1, '2023-09-25 15:03:35', 'traPCM');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `answer_ibfk_1` (`question_id`);

--
-- Indexes for table `appuser`
--
ALTER TABLE `appuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `choice`
--
ALTER TABLE `choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `questiontype`
--
ALTER TABLE `questiontype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studentattempted`
--
ALTER TABLE `studentattempted`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `trapcmsys`
--
ALTER TABLE `trapcmsys`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `appuser`
--
ALTER TABLE `appuser`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `choice`
--
ALTER TABLE `choice`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `questiontype`
--
ALTER TABLE `questiontype`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `studentattempted`
--
ALTER TABLE `studentattempted`
  MODIFY `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `topic`
--
ALTER TABLE `topic`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `trapcmsys`
--
ALTER TABLE `trapcmsys`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `choice`
--
ALTER TABLE `choice`
  ADD CONSTRAINT `choice_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`);

--
-- Constraints for table `studentattempted`
--
ALTER TABLE `studentattempted`
  ADD CONSTRAINT `studentattempted_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  ADD CONSTRAINT `studentattempted_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `appuser` (`id`);

--
-- Constraints for table `topic`
--
ALTER TABLE `topic`
  ADD CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
