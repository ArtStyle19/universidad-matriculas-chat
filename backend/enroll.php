<?php
session_start();
require("conexion.php");

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['enroll'])) {
    $username = $_SESSION['user'];
    $selectedCourses = isset($_POST['courses']) ? $_POST['courses'] : [];

    // Obtener el ID del estudiante
    $getStudentIDQuery = "SELECT StudentID FROM Students WHERE Username = ?";
    $stmtStudentID = $conn->prepare($getStudentIDQuery);
    $stmtStudentID->bind_param("s", $username);
    $stmtStudentID->execute();
    $resultStudentID = $stmtStudentID->get_result();
    $rowStudentID = $resultStudentID->fetch_assoc();
    $studentID = $rowStudentID['StudentID'];

    // Eliminar inscripciones anteriores del estudiante para los cursos seleccionados
    $deleteEnrollmentsQuery = "DELETE FROM Enrollments WHERE StudentID = ? AND CourseID = ?";
    $stmtDelete = $conn->prepare($deleteEnrollmentsQuery);
    $stmtDelete->bind_param("ii", $studentID, $courseID);

    foreach ($selectedCourses as $courseID) {
        $stmtDelete->execute();
    }

    $stmtDelete->close();

    // Inscribir al estudiante en los cursos seleccionados
    $enrollQuery = "INSERT INTO Enrollments (StudentID, CourseID) VALUES (?, ?)";
    $stmtEnroll = $conn->prepare($enrollQuery);
    $stmtEnroll->bind_param("ii", $studentID, $courseID);

    foreach ($selectedCourses as $courseID) {
        $stmtEnroll->execute();
    }

    $stmtEnroll->close();
    $conn->close();

    echo "success";
    exit();
}

echo "error";
exit();
?>
