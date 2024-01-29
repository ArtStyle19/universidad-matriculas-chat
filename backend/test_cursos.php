<?php
session_start();
require("conexion.php");

// Obtener el ID del departamento del estudiante actual
$username = $_SESSION['user']; // Asumiendo que 'user' almacena el nombre de usuario del estudiante
$departmentQuery = "SELECT DepartmentID FROM Students WHERE Username = ?";
$stmtDept = $conn->prepare($departmentQuery);
$stmtDept->bind_param("s", $username);
$stmtDept->execute();
$resultDept = $stmtDept->get_result();
$rowDept = $resultDept->fetch_assoc();
$departmentID = $rowDept['DepartmentID'];

// Obtener cursos disponibles para el departamento del estudiante
$availableCoursesQuery = "SELECT * FROM Courses WHERE DepartmentID = ?";
$stmtCourses = $conn->prepare($availableCoursesQuery);
$stmtCourses->bind_param("i", $departmentID);
$stmtCourses->execute();
$resultCourses = $stmtCourses->get_result();

// Construir opciones de cursos para la respuesta AJAX
$options = "";
while ($rowCourse = $resultCourses->fetch_assoc()) {
    $options .= '<option value="' . $rowCourse['CourseID'] . '">' . $rowCourse['CourseName'] . '</option>';
}

$stmtDept->close();
$stmtCourses->close();
$conn->close();

echo $options;
?>

