<?php
session_start();
require("conexion.php");

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['postID'])) {
    $postID = $_POST['postID'];

    // Delete post
    $deletePostQuery = "DELETE FROM Posts WHERE PostID = ?";
    $stmtDeletePost = $conn->prepare($deletePostQuery);
    $stmtDeletePost->bind_param("i", $postID);

    if ($stmtDeletePost->execute()) {
        echo "success";
    } else {
        echo "error";
    }

    $stmtDeletePost->close();
} else {
    echo "error";
}

$conn->close();
?>

