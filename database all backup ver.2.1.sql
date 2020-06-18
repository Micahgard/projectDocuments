-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: ocvwlym0zv3tcn68.cbetxkdyhwsb.us-east-1.rds.amazonaws.com
-- Generation Time: Jun 18, 2020 at 02:21 AM
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
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `AdminID` int(11) NOT NULL,
  `username` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `role` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`AdminID`, `username`, `password`, `email`, `phone`, `role`) VALUES
(1, 'sarah', 'admin', 'sarah@gmail.com', '0211111111', 'assistant'),
(2, 'micah', 'admin', 'micah@gmail.com', '0212222222', 'senior'),
(3, 'joel', 'admin', 'joel@gmail.com', '0213333333', 'assistant'),
(4, 'mojeeb', 'admin', 'mojeeb@gmail.com', '0214444444', 'facility'),
(5, 'aaron', 'admin', 'aaron@gmail.com', '0215555555', 'clerk'),
(6, 'jason', 'admin', 'jason@gmail.com', '0216666666', 'research'),
(7, 'zaid', 'admin', 'zaid@gmail.com', '0217777777', 'pharmacy');

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
-- Dumping data for table `Admission`
--

INSERT INTO `Admission` (`AdmissionID`, `description`, `admissiondate`, `status`, `patientID`, `wardID`) VALUES
(1, 'chest pain', '2020-03-06', 'complete', 4, 10),
(2, 'head trauma', '2020-04-03', 'complete', 7, 12),
(6, 'heart murmur', '2020-05-03', 'complete', 11, 16),
(7, 'chest pain', '2020-06-09', 'current', 9, 14),
(8, 'headache', '2020-06-12', 'current', 15, 13),
(9, 'eyes', '2020-05-13', 'billed', 8, 14),
(10, 'ears', '2019-05-14', 'billed', 15, 16),
(11, 'nose', '2020-05-15', 'billed', 4, 11),
(12, 'legs pain', '2020-01-01', 'close', 13, 11),
(13, 'legs pain', '2020-01-02', 'close', 12, 13),
(14, 'legs pain', '2020-01-03', 'close', 11, 14);

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
  `AllocationID` int(11) NOT NULL,
  `fee` decimal(8,2) NOT NULL,
  `role` text COLLATE utf8_unicode_ci NOT NULL,
  `doctorID` int(11) NOT NULL,
  `admissionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Allocation`
--

INSERT INTO `Allocation` (`AllocationID`, `fee`, `role`, `doctorID`, `admissionID`) VALUES
(6, '50.00', 'primary', 36, 2),
(7, '25.00', 'secondary', 42, 2),
(10, '200.00', 'primary', 40, 1),
(11, '150.00', 'primary', 37, 6),
(12, '100.00', 'secondary', 39, 6),
(13, '40.00', 'primary', 41, 9),
(14, '40.00', 'primary', 41, 11);

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
  `speciality` text COLLATE utf8_unicode_ci NOT NULL,
  `salary` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Doctor`
--

INSERT INTO `Doctor` (`DoctorID`, `lastname`, `firstname`, `street`, `suburb`, `city`, `phone`, `speciality`, `salary`) VALUES
(35, 'Pau', 'Lian', '235 Pasdal Road', 'Henderson', 'Auckland', '0221463711', 'Cronology', '124345.00'),
(36, 'Page', 'James', '56 Avon Street', 'Mt Albert', 'Auckland', '0272145467', 'Haematology', '124200.00'),
(37, 'Cook', 'Samuel', '78 St John Lane', 'Avondale', 'Auckland', '0273457121', 'Neurology', '125000.00'),
(38, 'Green', 'Rodney', '94 North Road', 'Mt Albert', 'Auckland', '0272225341', 'Oncology', '134150.00'),
(39, 'Jones', 'William', '55 James Street', 'Fitzroy', 'Auckland', '', 'Cardiology', '133000.00'),
(40, 'Bonham', 'Frederick', '67 Arrow Street', 'Lynfield', 'Auckland', '0278811441', 'Critical Care', '120000.00'),
(41, 'Cornwell', 'Jean', '45 Moon Avenue', 'Avondale', 'Auckland', '0276688112', 'Dermatology', '133000.00'),
(42, 'Jones', 'Samantha', '25 Jade Lane', 'Glen Eden', 'Auckland', '0273434666', 'Cardiology ', '140000.00'),
(44, 'King', 'Bill', '54 avon street', 'mt Albert', 'Auckland', '', 'Haematology', '122400.00');

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
CREATE TRIGGER `doctor_speciality_empty` BEFORE INSERT ON `Doctor` FOR EACH ROW BEGIN 
IF NEW.speciality = "" THEN 
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'speciality is empty';
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
-- Dumping data for table `Medication`
--

INSERT INTO `Medication` (`MedicationID`, `name`, `cost`) VALUES
(2, 'medication102', '500.00'),
(3, 'medication1', '100.00'),
(4, 'medication2', '1000.00'),
(6, 'Ibuprofen 200mg', '6.00'),
(7, 'Paracetamol 200mg', '7.70'),
(8, 'Prochlorperazine maleate 5mg', '8.80'),
(9, 'Aspirin 200mg', '9.90'),
(10, 'Eye Drops', '5.50'),
(11, 'Ear Drops', '7.50'),
(12, 'Nasal Spray', '4.50'),
(13, 'Codeine 200mg', '7.50'),
(14, 'VitaminC', '20.00');

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
-- Dumping data for table `Patient`
--

INSERT INTO `Patient` (`PatientID`, `lastname`, `firstname`, `street`, `suburb`, `city`, `email`, `phone`, `insurcode`) VALUES
(4, 'Fane', 'Andrew', '12 Queen Street', 'Mt Albert', 'Auckland', 'andrewfane@xtra.co.nz', '0211131122', 'ASB3432'),
(5, 'Burke', 'Andrew', '34 Jade Street', 'Glen Eden', 'Auckland', 'andrewburke@xtra.co.nz', '0211114122', 'ASB5687'),
(6, 'Ripley', 'Ellen', '45 Reeves Lane', 'Glen Eden', 'Auckland', 'ellenripley@xtra.co.nz', '0211121122', 'NZB6521'),
(7, 'Shames', 'Ian', '52 Green Lane', 'Mt Roskill', 'Auckland', 'ianshames@xtra.co.nz', '0211221122', 'TSB4576'),
(8, 'King', 'Sarah', '14 Roper Street', 'Avondale', 'Auckland', 'sarahking@xtra.co.nz', '0211114122', 'ASB6515'),
(9, 'Fane', 'Eva', '65 Falls Road', 'Avondale', 'Auckland', 'evafane@xtra.co.nz', '0211111199', 'WPB4566'),
(10, 'Freemen', 'Anthony', '86 Line Road', 'Mt Albert', 'Auckland', 'tonyfreemen@xtra.co.nz', '0211144133', 'ASB8811'),
(11, 'Grey', 'Isabella', '23 King Street', 'Lynnfield', 'Auckland', 'isabellagrey@xtra.co.nz', '0211111166', 'NZB5511'),
(12, 'Heath', 'Joseph', '123 Queen Street', 'Mt Albert', 'Auckland', 'josephheath@xtra.co.nz', '0211141188', 'WPB5512'),
(13, 'King', 'Peter', '120 Queen ST', 'CBD', 'Auckland', 'peterking@gmail.com', '0212223333', 'ASB1234'),
(14, 'Li', 'Henry', '123 Queen ST', 'CBD', 'Auckland', 'henryli@gmail.com', '0223345567', ''),
(15, 'Lin', 'Joel', '124 Daasdc Road', 'Henderson', 'Auckland', 'lin@nzal.com', '012345345', ''),
(16, 'Gardner', 'Micah', '42 Summer', 'ponsonby', 'auckland', 'abc@gmail.com', '0201234567', '12345');

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
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`PaymentCode`, `paymentdate`, `amount`, `admissionID`) VALUES
(1, '2020-03-08', '20.00', 1),
(2, '2020-03-17', '25.00', 1),
(4, '2020-05-08', '60.50', 6),
(5, '2020-05-23', '40.00', 9),
(6, '2020-05-24', '23.00', 10),
(7, '2020-05-25', '38.50', 11);

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
  `admissionID` int(11) NOT NULL,
  `medicationID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Prescription`
--

INSERT INTO `Prescription` (`PrescriptionID`, `prescriptiondate`, `amount`, `admissionID`, `medicationID`) VALUES
(1, '2020-03-06', '4.00', 1, 7),
(2, '2020-03-07', '5.00', 1, 8),
(3, '2020-04-13', '6.00', 2, 9),
(5, '2020-05-12', '7.00', 6, 6),
(6, '2020-06-10', '6.00', 6, 14),
(7, '2020-06-18', '2.00', 9, 10),
(8, '2020-06-18', '3.00', 10, 11);

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
  `enddate` date NOT NULL,
  `outcome` text COLLATE utf8_unicode_ci NOT NULL,
  `budget` decimal(10,2) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `topicID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Researchproject`
--

INSERT INTO `Researchproject` (`ProjectID`, `enddate`, `outcome`, `budget`, `doctorID`, `topicID`) VALUES
(1, '2020-06-01', 'journal article', '2000.00', 35, 5),
(2, '2020-06-02', 'book chapter', '5000.00', 36, 7),
(3, '2020-06-03', 'conference paper', '3500.00', 37, 8);

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
-- Dumping data for table `Researchtopic`
--

INSERT INTO `Researchtopic` (`TopicID`, `description`, `level`) VALUES
(1, 'Addictions', 4),
(2, 'Pandemics', 5),
(3, 'Allergies', 1),
(4, 'Diabetes', 5),
(5, 'Pain and pain relief', 3),
(6, 'Cardiovascular', 7),
(7, 'Viral oncology', 4),
(8, 'Lymphoma', 2);

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
-- Dumping data for table `Ward`
--

INSERT INTO `Ward` (`WardID`, `name`, `location`, `capacity`) VALUES
(10, 'Apollo', 'Floor 1', 20),
(11, 'Artemis', 'Floor 1', 18),
(12, 'Athena', 'Floor 1', 16),
(13, 'Chelsea', 'Floor 2', 20),
(14, 'Burns', 'Floor 3', 12),
(15, 'Cardiology', 'Floor 2', 18),
(16, 'Superman', 'Floor 4', 10);

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
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`AdminID`);

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
  ADD PRIMARY KEY (`AllocationID`),
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
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Admission`
--
ALTER TABLE `Admission`
  MODIFY `AdmissionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Allocation`
--
ALTER TABLE `Allocation`
  MODIFY `AllocationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Doctor`
--
ALTER TABLE `Doctor`
  MODIFY `DoctorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `Medication`
--
ALTER TABLE `Medication`
  MODIFY `MedicationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Patient`
--
ALTER TABLE `Patient`
  MODIFY `PatientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `PaymentCode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Prescription`
--
ALTER TABLE `Prescription`
  MODIFY `PrescriptionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Researchproject`
--
ALTER TABLE `Researchproject`
  MODIFY `ProjectID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Researchtopic`
--
ALTER TABLE `Researchtopic`
  MODIFY `TopicID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `Ward`
--
ALTER TABLE `Ward`
  MODIFY `WardID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
