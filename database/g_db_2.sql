-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 31, 2024 at 04:22 AM
-- Server version: 10.11.4-MariaDB-1~deb12u1
-- PHP Version: 8.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `g_db_2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePost` (IN `postID` INT)   BEGIN
    DECLARE exitHandler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exitHandler = TRUE;

    START TRANSACTION;

    -- Delete post record
    DELETE FROM Posts WHERE PostID = postID;

    IF exitHandler THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EnrollStudentInCourse` (IN `studentID` INT, IN `courseID` INT)   BEGIN
  DECLARE exitHandler BOOLEAN DEFAULT FALSE;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exitHandler = TRUE;

  START TRANSACTION;

  -- Your statements here
  INSERT INTO Enrollments (StudentID, CourseID) VALUES (studentID, courseID);

  IF exitHandler THEN
      ROLLBACK;
  ELSE
      COMMIT;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPostsInCourse` (IN `courseID` INT)   BEGIN
  SELECT * FROM Posts WHERE CourseID = courseID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPost` (IN `studentID` INT, IN `courseID` INT, IN `content` TEXT)   BEGIN
    DECLARE exitHandler BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exitHandler = TRUE;

    START TRANSACTION;

    -- Insert post record
    INSERT INTO Posts (StudentID, CourseID, Content) VALUES (studentID, courseID, content);

    IF exitHandler THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoveStudentFromCourse` (IN `studentID` INT, IN `courseID` INT)   BEGIN
  DECLARE exitHandler BOOLEAN DEFAULT FALSE;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exitHandler = TRUE;

  START TRANSACTION;

  -- Deleting the enrollment record
  DELETE FROM Enrollments WHERE StudentID = studentID AND CourseID = courseID;

  IF exitHandler THEN
      ROLLBACK;
  ELSE
      COMMIT;
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ChangeLog`
--

CREATE TABLE `ChangeLog` (
  `LogID` int(11) NOT NULL,
  `TableName` varchar(255) NOT NULL,
  `Action` varchar(10) NOT NULL,
  `RecordID` int(11) NOT NULL,
  `ChangeDetails` text DEFAULT NULL,
  `Timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ChangeLog`
--

INSERT INTO `ChangeLog` (`LogID`, `TableName`, `Action`, `RecordID`, `ChangeDetails`, `Timestamp`) VALUES
(1, 'Posts', 'INSERT', 46, 'Content: probando change log, CourseID: 6, StudentID: 1', '2024-01-30 14:39:43'),
(2, 'Posts', 'UPDATE', 45, 'Content: probando c, CourseID: 6, StudentID: 1', '2024-01-30 14:41:13'),
(3, 'Posts', 'INSERT', 47, 'Content: Mensaje de Guillermo, CourseID: 1, StudentID: 13', '2024-01-31 03:15:43'),
(4, 'Posts', 'UPDATE', 47, 'Content: Mensaje de Guillermo (editado), CourseID: 1, StudentID: 13', '2024-01-31 03:16:53'),
(5, 'Posts', 'UPDATE', 46, 'Content: Probando Chat de Curso de Base de Datos , CourseID: 6, StudentID: 1', '2024-01-31 03:27:07');

-- --------------------------------------------------------

--
-- Table structure for table `Courses`
--

CREATE TABLE `Courses` (
  `CourseID` int(11) NOT NULL,
  `CourseName` varchar(255) NOT NULL,
  `Semester` varchar(255) NOT NULL,
  `DepartmentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Courses`
--

INSERT INTO `Courses` (`CourseID`, `CourseName`, `Semester`, `DepartmentID`) VALUES
(1, 'Anatomía Humana', '2024 Spring', 1),
(2, 'Farmacología Básica', '2024 Spring', 1),
(3, 'Introducción a la Cirugía', '2024 Spring', 1),
(4, 'Desarrollo Web Avanzado', '2024 Spring', 2),
(5, 'Ingeniería de Software', '2024 Spring', 2),
(6, 'Bases de Datos Avanzadas', '2024 Spring', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Departments`
--

CREATE TABLE `Departments` (
  `DepartmentID` int(11) NOT NULL,
  `DepartmentName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Departments`
--

INSERT INTO `Departments` (`DepartmentID`, `DepartmentName`) VALUES
(1, 'Medicine'),
(2, 'Software Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `Enrollments`
--

CREATE TABLE `Enrollments` (
  `EnrollmentID` int(11) NOT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Enrollments`
--

INSERT INTO `Enrollments` (`EnrollmentID`, `StudentID`, `CourseID`) VALUES
(34, 6, 3),
(35, 1, 5),
(36, 1, 4),
(37, 8, 6),
(38, 8, 4),
(39, 6, 6),
(40, 13, 1),
(41, 6, 1),
(42, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `Posts`
--

CREATE TABLE `Posts` (
  `PostID` int(11) NOT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `Content` text NOT NULL,
  `Timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Posts`
--

INSERT INTO `Posts` (`PostID`, `StudentID`, `CourseID`, `Content`, `Timestamp`) VALUES
(1, 2, 1, 'Hola, este es mi primer post en el curso 1.', '2024-01-30 17:00:00'),
(2, 2, 1, '¡Hola a todos! Estoy emocionado de ser parte de este curso.', '2024-01-30 17:30:00'),
(3, 3, 1, '¿Alguien tiene alguna pregunta sobre la primera lección?', '2024-01-30 18:00:00'),
(4, 4, 2, '¡Saludos! Listo para comenzar el curso 2.', '2024-01-30 18:30:00'),
(5, 5, 2, 'Me encanta el tema que estamos cubriendo esta semana.', '2024-01-30 19:00:00'),
(6, 6, 2, '¿Alguien más tiene el mismo libro de texto?', '2024-01-30 19:30:00'),
(7, 1, 3, '¿Algún consejo para preparar el examen final?', '2024-02-01 15:00:00'),
(8, 2, 3, 'Me perdí la última clase, ¿alguien puede ponerme al día2?', '2024-02-01 15:30:00'),
(9, 3, 3, 'Este curso está desafiante pero gratificante.', '2024-02-01 16:00:00'),
(10, 4, 4, '¿Alguien más está considerando un proyecto adicional?', '2024-02-01 16:30:00'),
(11, 5, 4, 'Me encantó la conferencia invitada de ayer.', '2024-02-01 17:00:00'),
(12, 6, 4, 'Estoy buscando compañeros para un proyecto grupal.', '2024-02-01 17:30:00'),
(13, 1, 5, '¿Alguien tiene sugerencias de lectura adicional?', '2024-02-01 18:00:00'),
(14, 2, 5, 'Me encantaría organizar un evento social para nuestro curso.', '2024-02-01 18:30:00'),
(15, 3, 5, 'Este tema específico es fascinante.', '2024-02-01 19:00:00'),
(16, 4, 6, '¡Hola a todos! Acabo de unirme al curso.', '2024-02-01 19:30:00'),
(17, 5, 6, '¿Qué temas cubriremos en las próximas semanas?', '2024-02-01 20:00:00'),
(18, 6, 6, 'Este es mi segundo curso aquí. ¡Encantado de estar de vuelta!', '2024-02-01 20:30:00'),
(19, NULL, 6, 'Hola llevo BASE de Datos II', '2024-01-29 18:10:05'),
(20, NULL, 6, 'Hola llevo BASE de Datos II', '2024-01-29 18:13:37'),
(21, NULL, 6, 'Estudio DB II', '2024-01-29 18:14:09'),
(22, NULL, 6, 'Estudio DB II', '2024-01-29 18:16:20'),
(23, NULL, 6, 'Estudio DB II', '2024-01-29 18:16:50'),
(24, NULL, 6, 'Estudio DB II', '2024-01-29 18:17:42'),
(25, NULL, 6, 'Estudio DB II', '2024-01-29 18:17:45'),
(26, NULL, 6, 'Estudio DB II', '2024-01-29 18:18:51'),
(27, NULL, 6, 'Estudio DB II', '2024-01-29 18:19:04'),
(28, NULL, 6, 'Estudio DB II asdasd', '2024-01-29 18:19:10'),
(29, NULL, 6, 'Estudio DB II asdasd', '2024-01-29 18:20:40'),
(30, NULL, 2, 'sidis', '2024-01-29 18:21:25'),
(31, NULL, 3, 'sidis', '2024-01-29 18:21:44'),
(32, 6, 3, 'sidis', '2024-01-29 18:22:16'),
(40, 1, 6, 'masi', '2024-01-29 19:16:07'),
(41, 5, 3, 'xd asdsad', '2024-01-29 19:21:40'),
(42, 1, 5, 'Hola', '2024-01-30 04:32:33'),
(43, 1, 6, 'holas', '2024-01-30 05:49:20'),
(44, 1, 4, 'Hola de M0', '2024-01-30 13:24:39'),
(45, 1, 6, 'probando c', '2024-01-30 14:18:08'),
(46, 1, 6, 'Probando Chat de Curso de Base de Datos ', '2024-01-30 14:39:43'),
(47, 13, 1, 'Mensaje de Guillermo (editado)', '2024-01-31 03:15:43');

--
-- Triggers `Posts`
--
DELIMITER $$
CREATE TRIGGER `AfterDeletePostsTrigger` AFTER DELETE ON `Posts` FOR EACH ROW BEGIN
    INSERT INTO ChangeLog (TableName, Action, RecordID, ChangeDetails)
    VALUES ('Posts', 'DELETE', OLD.PostID, CONCAT('Content: ', OLD.Content, ', CourseID: ', OLD.CourseID, ', StudentID: ', OLD.StudentID));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterInsertUpdateDeletePostsTrigger` AFTER INSERT ON `Posts` FOR EACH ROW BEGIN
    INSERT INTO ChangeLog (TableName, Action, RecordID, ChangeDetails)
    VALUES ('Posts', 'INSERT', NEW.PostID, CONCAT('Content: ', NEW.Content, ', CourseID: ', NEW.CourseID, ', StudentID: ', NEW.StudentID));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterUpdatePostsTrigger` AFTER UPDATE ON `Posts` FOR EACH ROW BEGIN
    INSERT INTO ChangeLog (TableName, Action, RecordID, ChangeDetails)
    VALUES ('Posts', 'UPDATE', NEW.PostID, CONCAT('Content: ', NEW.Content, ', CourseID: ', NEW.CourseID, ', StudentID: ', NEW.StudentID));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Students`
--

CREATE TABLE `Students` (
  `StudentID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `DepartmentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Students`
--

INSERT INTO `Students` (`StudentID`, `Username`, `Password`, `Email`, `DepartmentID`) VALUES
(1, 'milagrito', '$2y$10$sNsfmnK.Nmzwbp2qyAqgUuGTYjpOFT0QoJp6q/1SMZvvSLewxeZK6', 'jorge@gmail.com', 2),
(2, 'milagrito2', '$2y$10$reaLy0XSsaPJRNC9VZw5qufIN8TvmCTOL/Bb72MURXpG1iYm9kljK', 'test2@gmail.com', 1),
(3, 'milagrito3', '$2y$10$3BE8DxDzYZrPcQS3mALEkOEEdl0uGvvpuV8sWLizUIwUKTF1OfuW6', 'test3@gmail.com', 1),
(4, 'milagrito4', '$2y$10$gb040Z4Ft2VzGThKCZfX2OGQ65T.mOwMeNIMpQ6RrnfzI.2KhvOy6', 'test4@gmail.com', 1),
(5, 'milagrito5', '$2y$10$MUyUB7/rr1U1MbcbgvDpgOXzA5NzFmML.xBhdYPIkCntSFT.K7wy.', 'test5@gmail.com', 1),
(6, 'milagrito6', '$2y$10$K5vAZXX2qgYnanzs0E8qB.lFVzqE9URbOpjl4xEU7rbnlyWEPu6u2', 'test6@gmail.com', 1),
(7, 'milagrito19', '$2y$10$8KDWRae/k70.6JfqdhyIOela3za5.4t6TPdRmZLUp6f1XU.cC/ZZS', 'milagrito19@gmail.com', 2),
(8, 'desSoft', '$2y$10$vnYuqkICy.14gEC/gHFYiOuqgil35ax5JyfmJc/KxlTJfcstbYPRC', 'desSoft@gmail.com', 2),
(12, 'milagrito12', '$2y$10$VnoqR6iiJrjA5boZ16aiUeStWrWiJZt5ArgZz.3nto/bTRv8Pgcuq', '123@gmail.com', 1),
(13, 'Guillermo', '$2y$10$SCUT6FVJzdE2BrYlfg8R2.5iVnKRT6knmLBBTnu.Eacp/5Mbpupdm', 'guillermo@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(15, '123', '$2y$10$AVhNDucCpbkyt9N7LA.HtuUCLIBXNCH9QAO.LpJsazE6WifEKwVOG'),
(16, 'milagrito', '$2y$10$uuiUXNQhqHCNKM7UWDwjB.jkp6cuHfCLb4cHqBKKk/pY5NVYPHHTG'),
(17, 'user', '$2y$10$IkDUYcHfZ9S2eCsxYbZzp.60J2Cgtuq2T0HR7apA9BJZho52.pA.m');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ChangeLog`
--
ALTER TABLE `ChangeLog`
  ADD PRIMARY KEY (`LogID`);

--
-- Indexes for table `Courses`
--
ALTER TABLE `Courses`
  ADD PRIMARY KEY (`CourseID`),
  ADD KEY `DepartmentID` (`DepartmentID`);

--
-- Indexes for table `Departments`
--
ALTER TABLE `Departments`
  ADD PRIMARY KEY (`DepartmentID`);

--
-- Indexes for table `Enrollments`
--
ALTER TABLE `Enrollments`
  ADD PRIMARY KEY (`EnrollmentID`),
  ADD KEY `StudentID` (`StudentID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `Posts`
--
ALTER TABLE `Posts`
  ADD PRIMARY KEY (`PostID`),
  ADD KEY `StudentID` (`StudentID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `Students`
--
ALTER TABLE `Students`
  ADD PRIMARY KEY (`StudentID`),
  ADD KEY `DepartmentID` (`DepartmentID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ChangeLog`
--
ALTER TABLE `ChangeLog`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Courses`
--
ALTER TABLE `Courses`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Departments`
--
ALTER TABLE `Departments`
  MODIFY `DepartmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Enrollments`
--
ALTER TABLE `Enrollments`
  MODIFY `EnrollmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `Posts`
--
ALTER TABLE `Posts`
  MODIFY `PostID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `Students`
--
ALTER TABLE `Students`
  MODIFY `StudentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Courses`
--
ALTER TABLE `Courses`
  ADD CONSTRAINT `Courses_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`);

--
-- Constraints for table `Enrollments`
--
ALTER TABLE `Enrollments`
  ADD CONSTRAINT `Enrollments_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Students` (`StudentID`),
  ADD CONSTRAINT `Enrollments_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `Courses` (`CourseID`);

--
-- Constraints for table `Posts`
--
ALTER TABLE `Posts`
  ADD CONSTRAINT `Posts_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `Students` (`StudentID`),
  ADD CONSTRAINT `Posts_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `Courses` (`CourseID`);

--
-- Constraints for table `Students`
--
ALTER TABLE `Students`
  ADD CONSTRAINT `Students_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
