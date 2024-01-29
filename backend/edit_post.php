<?php
session_start();
require("conexion.php");

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['postID']) && isset($_POST['content'])) {
    $postID = $_POST['postID'];
    $newContent = $_POST['content'];

    // Update post content
    $editPostQuery = "UPDATE Posts SET Content = ? WHERE PostID = ?";
    $stmtEditPost = $conn->prepare($editPostQuery);
    $stmtEditPost->bind_param("si", $newContent, $postID);

    if ($stmtEditPost->execute()) {
        echo "success";
    } else {
        echo "error";
    }

    $stmtEditPost->close();
} else {
    echo "error";
}

$conn->close();
?>
