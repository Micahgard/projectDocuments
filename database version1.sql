-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: ocvwlym0zv3tcn68.cbetxkdyhwsb.us-east-1.rds.amazonaws.com
-- Generation Time: May 18, 2020 at 03:37 AM
-- Server version: 5.7.23-log
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `umpablvyo92sy9r5`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admission`
--

CREATE TABLE `Admission` (
  `AdmissionID` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `admissiondate` date NOT NULL,
  `status` text COLLATE utf8_unicode_ci NOT NULL,
  `patientID` int(11) NOT NULL,
  `wardID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Allocation`
--

CREATE TABLE `Allocation` (
  `AllowcationID` int(11) NOT NULL,
  `fee` decimal(5,2) NOT NULL,
  `role` text COLLATE utf8_unicode_ci NOT NULL,
  `doctorID` int(11) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Doctor`
--

CREATE TABLE `Doctor` (
  `DoctorID` int(11) NOT NULL,
  `firstname` text COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `street` text COLLATE utf8_unicode_ci NOT NULL,
  `suburb` text COLLATE utf8_unicode_ci NOT NULL,
  `city` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `specialty` text COLLATE utf8_unicode_ci NOT NULL,
  `salary` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Medication`
--

CREATE TABLE `Medication` (
  `MedicationID` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `cost` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Patient`
--

CREATE TABLE `Patient` (
  `PatientID` int(11) NOT NULL,
  `firstname` text COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `street` text COLLATE utf8_unicode_ci NOT NULL,
  `suburb` text COLLATE utf8_unicode_ci NOT NULL,
  `city` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `insurcode` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `PaymentCode` int(11) NOT NULL,
  `paymentdate` date NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Prescription`
--

CREATE TABLE `Prescription` (
  `PrescriptionID` int(11) NOT NULL,
  `prescriptiondate` date NOT NULL,
  `amount` decimal(3,2) NOT NULL,
  `medicationID` int(11) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Researchproject`
--

CREATE TABLE `Researchproject` (
  `ProjectID` int(11) NOT NULL,
  `enddate` date NOT NULL,
  `outcome` text COLLATE utf8_unicode_ci NOT NULL,
  `budget` decimal(7,2) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `topicID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Researchtopic`
--

CREATE TABLE `Researchtopic` (
  `TopicID` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Ward`
--

CREATE TABLE `Ward` (
  `WardID` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `location` text COLLATE utf8_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admission`
--
ALTER TABLE `Admission`
  ADD PRIMARY KEY (`AdmissionID`),
  ADD KEY `patientID` (`patientID`),
  ADD KEY `wardID` (`wardID`);

--
-- Indexes for table `Allocation`
--
ALTER TABLE `Allocation`
  ADD PRIMARY KEY (`AllowcationID`),
  ADD KEY `doctorID` (`doctorID`),
  ADD KEY `admissionID` (`admissionID`);

--
-- Indexes for table `Doctor`
--
ALTER TABLE `Doctor`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indexes for table `Medication`
--
ALTER TABLE `Medication`
  ADD PRIMARY KEY (`MedicationID`);

--
-- Indexes for table `Patient`
--
ALTER TABLE `Patient`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`PaymentCode`),
  ADD KEY `admissionID` (`admissionID`);

--
-- Indexes for table `Prescription`
--
ALTER TABLE `Prescription`
  ADD PRIMARY KEY (`PrescriptionID`),
  ADD KEY `medicationID` (`medicationID`),
  ADD KEY `admissionID` (`admissionID`);

--
-- Indexes for table `Researchproject`
--
ALTER TABLE `Researchproject`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `doctorID` (`doctorID`),
  ADD KEY `topicID` (`topicID`);

--
-- Indexes for table `Researchtopic`
--
ALTER TABLE `Researchtopic`
  ADD PRIMARY KEY (`TopicID`);

--
-- Indexes for table `Ward`
--
ALTER TABLE `Ward`
  ADD PRIMARY KEY (`WardID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admission`
--
ALTER TABLE `Admission`
  MODIFY `AdmissionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Allocation`
--
ALTER TABLE `Allocation`
  MODIFY `AllowcationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Doctor`
--
ALTER TABLE `Doctor`
  MODIFY `DoctorID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Medication`
--
ALTER TABLE `Medication`
  MODIFY `MedicationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `PaymentCode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Prescription`
--
ALTER TABLE `Prescription`
  MODIFY `PrescriptionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Researchproject`
--
ALTER TABLE `Researchproject`
  MODIFY `ProjectID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Researchtopic`
--
ALTER TABLE `Researchtopic`
  MODIFY `TopicID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Ward`
--
ALTER TABLE `Ward`
  MODIFY `WardID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Admission`
--
ALTER TABLE `Admission`
  ADD CONSTRAINT `Admission_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `Patient` (`PatientID`),
  ADD CONSTRAINT `Admission_ibfk_2` FOREIGN KEY (`wardID`) REFERENCES `Ward` (`WardID`);

--
-- Constraints for table `Allocation`
--
ALTER TABLE `Allocation`
  ADD CONSTRAINT `Allocation_ibfk_1` FOREIGN KEY (`doctorID`) REFERENCES `Doctor` (`DoctorID`),
  ADD CONSTRAINT `Allocation_ibfk_2` FOREIGN KEY (`admissionID`) REFERENCES `Admission` (`AdmissionID`);

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`admissionID`) REFERENCES `Admission` (`AdmissionID`);

--
-- Constraints for table `Prescription`
--
ALTER TABLE `Prescription`
  ADD CONSTRAINT `Prescription_ibfk_1` FOREIGN KEY (`medicationID`) REFERENCES `Medication` (`MedicationID`),
  ADD CONSTRAINT `Prescription_ibfk_2` FOREIGN KEY (`admissionID`) REFERENCES `Admission` (`AdmissionID`);

--
-- Constraints for table `Researchproject`
--
ALTER TABLE `Researchproject`
  ADD CONSTRAINT `Researchproject_ibfk_1` FOREIGN KEY (`doctorID`) REFERENCES `Doctor` (`DoctorID`),
  ADD CONSTRAINT `Researchproject_ibfk_2` FOREIGN KEY (`topicID`) REFERENCES `Researchtopic` (`TopicID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
