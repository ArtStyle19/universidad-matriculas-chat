<?php
session_start();
require("conexion.php");

// Obtener el ID del estudiante actual
$username = $_SESSION['user'];
$getStudentIDQuery = "SELECT StudentID FROM Students WHERE Username = ?";
$stmtStudentID = $conn->prepare($getStudentIDQuery);
$stmtStudentID->bind_param("s", $username);
$stmtStudentID->execute();
$resultStudentID = $stmtStudentID->get_result();
$rowStudentID = $resultStudentID->fetch_assoc();
$studentID = $rowStudentID['StudentID'];

// Obtener cursos a los que está inscrito el estudiante
$enrolledCoursesQuery = "SELECT c.CourseID, c.CourseName FROM Courses c 
                        INNER JOIN Enrollments e ON c.CourseID = e.CourseID
                        WHERE e.StudentID = ?";
$stmtEnrolledCourses = $conn->prepare($enrolledCoursesQuery);
$stmtEnrolledCourses->bind_param("i", $studentID);
$stmtEnrolledCourses->execute();
$resultEnrolledCourses = $stmtEnrolledCourses->get_result();

// Construir opciones de cursos para la respuesta AJAX
$options = "";
while ($rowEnrolledCourse = $resultEnrolledCourses->fetch_assoc()) {
    $options .= '<option value="' . $rowEnrolledCourse['CourseID'] . '">' . $rowEnrolledCourse['CourseName'] . '</option>';
}

$stmtStudentID->close();
$stmtEnrolledCourses->close();
$conn->close();

echo $options;
?>
