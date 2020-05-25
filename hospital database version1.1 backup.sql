-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: ocvwlym0zv3tcn68.cbetxkdyhwsb.us-east-1.rds.amazonaws.com
-- Generation Time: May 25, 2020 at 12:55 AM
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

--
-- Triggers `Admission`
--
DELIMITER $$
CREATE TRIGGER `admission_date_empty` BEFORE INSERT ON `Admission` FOR EACH ROW BEGIN 
IF NEW.admissiondate = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'admissiondate is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `admission_description_empty` BEFORE INSERT ON `Admission` FOR EACH ROW BEGIN 
IF NEW.description = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'description is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `admission_status_empty` BEFORE INSERT ON `Admission` FOR EACH ROW BEGIN 
IF NEW.status = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'status is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Allocation`
--

CREATE TABLE `Allocation` (
  `AllowcationID` int(11) NOT NULL,
  `fee` decimal(8,2) NOT NULL,
  `role` text COLLATE utf8_unicode_ci NOT NULL,
  `doctorID` int(11) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Allocation`
--
DELIMITER $$
CREATE TRIGGER `allocation_fee_below0.00` BEFORE INSERT ON `Allocation` FOR EACH ROW BEGIN 
IF NEW.fee<0.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'fee out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `allocation_fee_over99999.99` BEFORE INSERT ON `Allocation` FOR EACH ROW BEGIN 
IF NEW.fee>99999.99 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'fee out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `allocation_role_empty` BEFORE INSERT ON `Allocation` FOR EACH ROW BEGIN 
IF NEW.role = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'role is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Doctor`
--

CREATE TABLE `Doctor` (
  `DoctorID` int(11) NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `firstname` text COLLATE utf8_unicode_ci NOT NULL,
  `street` text COLLATE utf8_unicode_ci NOT NULL,
  `suburb` text COLLATE utf8_unicode_ci NOT NULL,
  `city` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `specialty` text COLLATE utf8_unicode_ci NOT NULL,
  `salary` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Doctor`
--
DELIMITER $$
CREATE TRIGGER `doctor_firstname_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.firstname = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'firstname is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_lastname_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.lastname = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'lastname is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_salary_below20000.00` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.salary<20000.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'salary out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_salary_over200000.00` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.salary>200000.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'salary out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_specialty_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.specialty = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'specialty is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_street_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.street = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'street is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `doctor_suburb_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.suburb = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'suburb is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Medication`
--

CREATE TABLE `Medication` (
  `MedicationID` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `cost` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Medication`
--
DELIMITER $$
CREATE TRIGGER `medication_cost_below0.00` BEFORE INSERT ON `Medication` FOR EACH ROW BEGIN 
IF NEW.cost<0.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'cost out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medication_cost_over9999.99` BEFORE INSERT ON `Medication` FOR EACH ROW BEGIN 
IF NEW.cost>9999.99 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'cost out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medication_name_empty` BEFORE INSERT ON `Medication` FOR EACH ROW BEGIN 
IF NEW.name = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'name is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Patient`
--

CREATE TABLE `Patient` (
  `PatientID` int(11) NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `firstname` text COLLATE utf8_unicode_ci NOT NULL,
  `street` text COLLATE utf8_unicode_ci NOT NULL,
  `suburb` text COLLATE utf8_unicode_ci NOT NULL,
  `city` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `insurcode` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Patient`
--
DELIMITER $$
CREATE TRIGGER `patient_city_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.city = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'city is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_email_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.email = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'email is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_firstname_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.firstname = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'firstname is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_lastname_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.lastname = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'lastname is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_phone_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.phone = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'phone is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_street_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.street = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'street is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patient_suburb_empty` BEFORE INSERT ON `Patient` FOR EACH ROW BEGIN 
IF NEW.suburb = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'suburb is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `PaymentCode` int(11) NOT NULL,
  `paymentdate` date NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Payment`
--
DELIMITER $$
CREATE TRIGGER `payment_amount_below0.00` BEFORE INSERT ON `Payment` FOR EACH ROW BEGIN 
IF NEW.amount<0.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'amount out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `payment_amount_over99999.99` BEFORE INSERT ON `Payment` FOR EACH ROW BEGIN 
IF NEW.amount>99999.99 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'amount out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `payment_paymentdate_empty` BEFORE INSERT ON `Payment` FOR EACH ROW BEGIN 
IF NEW.paymentdate = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'paymentdate is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Prescription`
--

CREATE TABLE `Prescription` (
  `PrescriptionID` int(11) NOT NULL,
  `prescriptiondate` date NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `medicationID` int(11) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Prescription`
--
DELIMITER $$
CREATE TRIGGER `prescription_amount_below0.00` BEFORE INSERT ON `Prescription` FOR EACH ROW BEGIN 
IF NEW.amount<0.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'amount out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `prescription_amount_over999.99` BEFORE INSERT ON `Prescription` FOR EACH ROW BEGIN 
IF NEW.amount>999.99 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'amount out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `prescription_prescriptiondate_empty` BEFORE INSERT ON `Prescription` FOR EACH ROW BEGIN 
IF NEW.prescriptiondate = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'prescriptiondate is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Researchproject`
--

CREATE TABLE `Researchproject` (
  `ProjectID` int(11) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `topicID` int(11) NOT NULL,
  `enddate` date NOT NULL,
  `outcome` text COLLATE utf8_unicode_ci NOT NULL,
  `budget` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Researchproject`
--
DELIMITER $$
CREATE TRIGGER `researchproject_budget_below0.00` BEFORE INSERT ON `Researchproject` FOR EACH ROW BEGIN 
IF NEW.budget<0.00 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'budget out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `researchproject_budget_over9999999.99` BEFORE INSERT ON `Researchproject` FOR EACH ROW BEGIN 
IF NEW.budget>9999999.99 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'budget out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `researchproject_enddate_empty` BEFORE INSERT ON `Researchproject` FOR EACH ROW BEGIN 
IF NEW.enddate = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'enddate is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `researchproject_outcome_empty` BEFORE INSERT ON `Researchproject` FOR EACH ROW BEGIN 
IF NEW.outcome = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'outcome is empty';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Researchtopic`
--

CREATE TABLE `Researchtopic` (
  `TopicID` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Researchtopic`
--
DELIMITER $$
CREATE TRIGGER `researchtopic_description_empty` BEFORE INSERT ON `Researchtopic` FOR EACH ROW BEGIN 
IF NEW.description = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'description is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `researchtopic_level_below1` BEFORE INSERT ON `Researchtopic` FOR EACH ROW BEGIN 
IF NEW.level<1 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'level out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `researchtopic_level_over10` BEFORE INSERT ON `Researchtopic` FOR EACH ROW BEGIN 
IF NEW.level>10 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'level out of range';
 END IF; 
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Ward`
--

CREATE TABLE `Ward` (
  `WardID` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `location` text COLLATE utf8_unicode_ci NOT NULL,
  `capacity` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Ward`
--
DELIMITER $$
CREATE TRIGGER `ward_capacity_below1` BEFORE INSERT ON `Ward` FOR EACH ROW BEGIN 
IF NEW.capacity<1 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'capacity out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ward_capacity_over20` BEFORE INSERT ON `Ward` FOR EACH ROW BEGIN 
IF NEW.capacity>20 THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'capacity out of range';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ward_location_empty` BEFORE INSERT ON `Ward` FOR EACH ROW BEGIN 
IF NEW.location = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'location is empty';
 END IF; 
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ward_name_empty` BEFORE INSERT ON `Ward` FOR EACH ROW BEGIN 
IF NEW.name = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'name is empty';
 END IF; 
 END
$$
DELIMITER ;

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
  MODIFY `AllowcationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Doctor`
--
ALTER TABLE `Doctor`
  MODIFY `DoctorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `Medication`
--
ALTER TABLE `Medication`
  MODIFY `MedicationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `WardID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
