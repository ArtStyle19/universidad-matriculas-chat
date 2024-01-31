
<?php
session_start();
require("conexion.php");

// Obtener el ID del departamento del estudiante actual
$username = $_SESSION['user'];
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

// Crear un array para almacenar la información de los cursos
$courses = [];

// Almacenar la información de los cursos en el array
while ($rowCourse = $resultCourses->fetch_assoc()) {
    $courses[] = [
        'id' => $rowCourse['CourseID'],
        'name' => $rowCourse['CourseName'],
    ];
}

// Convertir el array a formato JSON y enviarlo como respuesta
header('Content-Type: application/json');
echo json_encode($courses);

$stmtDept->close();
$stmtCourses->close();
$conn->close();
?>

