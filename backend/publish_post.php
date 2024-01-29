<?php
session_start();
require("conexion.php");

// Obtener el ID del departamento del estudiante actual

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['content']) && isset($_POST['courseID'])) {
  $content = $_POST['content'];
  $courseID = $_POST['courseID'];



  $username = $_SESSION['user'];
  $departmentQuery = "SELECT StudentID FROM Students WHERE Username = ?";
  $stmtDept = $conn->prepare($departmentQuery);
$stmtDept->bind_param("s", $username);
$stmtDept->execute();
$resultDept = $stmtDept->get_result();
$rowDept = $resultDept->fetch_assoc();
$studentID = $rowDept['StudentID'];

    // $studentID = $_SESSION['studentID']; // Ya estás obteniendo el StudentID del usuario actual arriba

    $publishPostQuery = "INSERT INTO Posts (StudentID, CourseID, Content) VALUES (?, ?, ?)";
    $stmtPublishPost = $conn->prepare($publishPostQuery);
    $stmtPublishPost->bind_param("iis", $studentID, $courseID, $content);

    if ($stmtPublishPost->execute()) {
        echo "success";
    } else {
        echo "error";
    }

    $stmtPublishPost->close();
} else {
    echo "error";
}

$conn->close();
?>
