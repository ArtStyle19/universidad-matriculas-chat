<?php
session_start();
require("conexion.php");

// Obtener el ID del curso desde la solicitud GET
$courseID = isset($_GET['courseID']) ? $_GET['courseID'] : null;

if ($courseID === null) {
    echo "Error: No se proporcionó el ID del curso.";
} else {
    // Consulta para obtener los posts del curso específico
    $getPostsQuery = "SELECT Posts.Content, Students.Username, Posts.Timestamp
                      FROM Posts
                      INNER JOIN Students ON Posts.StudentID = Students.StudentID
                      WHERE Posts.CourseID = ?
                      ORDER BY Posts.Timestamp DESC";

    $stmt = $conn->prepare($getPostsQuery);
    $stmt->bind_param("i", $courseID);
    $stmt->execute();
    $result = $stmt->get_result();

    // Mostrar los posts en formato HTML (puedes personalizar esto según tus necesidades)
    while ($row = $result->fetch_assoc()) {
        echo "<div>";
        echo "<strong>" . $row['Username'] . ":</strong> " . $row['Content'];
        echo "<br>";
        echo "<small>" . $row['Timestamp'] . "</small>";
        echo "</div>";
    }

    $stmt->close();
}

$conn->close();
?>


