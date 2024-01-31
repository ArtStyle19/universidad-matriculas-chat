<?php
session_start();
require("conexion.php");

// Obtener el ID del curso desde la solicitud GET
$courseID = isset($_GET['courseID']) ? $_GET['courseID'] : null;

if ($courseID === null) {
    echo "Error: No se proporcionó el ID del curso.";
} else {
    // Consulta para obtener los posts del curso específico
    $getPostsQuery = "SELECT Posts.PostID, Posts.Content, Students.Username, Posts.Timestamp
                      FROM Posts
                      INNER JOIN Students ON Posts.StudentID = Students.StudentID
                      WHERE Posts.CourseID = ?
                      ORDER BY Posts.Timestamp ASC";

    $stmt = $conn->prepare($getPostsQuery);
    $stmt->bind_param("i", $courseID);
    $stmt->execute();
    $result = $stmt->get_result();

    // Mostrar los posts en formato HTML (puedes personalizar esto según tus necesidades)
while ($row = $result->fetch_assoc()) {
        echo "<div class='card mb-3' id='post_" . $row['PostID'] . "'>";
        echo "<div class='card-body'>";
        echo "<h5 class='card-title'>" . $row['Username'] . ":</h5>";

        // Content element
        echo "<p class='card-text'>" . $row['Content'] . "</p>";

        // Timestamp element
        echo "<small class='text-muted'>" . $row['Timestamp'] . "</small>";

        // Check if the post belongs to the current user
        if ($_SESSION['user'] == $row['Username']) {
            // Edit button
            echo "<button type='button' class='btn btn-primary edit-button' onclick='editPost(" . $row['PostID'] . ")'>Editar</button>";

            // Delete button
            echo "<button type='button' class='btn btn-danger delete-button' onclick='deletePost(" . $row['PostID'] . ")'>Eliminar</button>";
        }

        echo "</div></div>";
    }

    $stmt->close();
}

$conn->close();
?>
