<?php
session_start();
require("conexion.php");

// Function to sanitize input data
function sanitize_input($data) {
    return htmlspecialchars(trim($data));
}

// Register User
echo isset($_POST['register']);
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['register'])) {
    $username = sanitize_input($_POST['username']);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    // Basic validation
    if (empty($username) || empty($_POST['password'])) {
        echo "Please provide both username and password.";
    } else {
        // Check if username already exists
        $check_username_query = "SELECT * FROM users WHERE username=?";
        $stmt = $conn->prepare($check_username_query);
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "Username already exists. Please choose a different username.";
        } else {
            // Register the user
            $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
            $stmt->bind_param("ss", $username, $password);

            if ($stmt->execute()) {
                $_SESSION['user'] = $username;
        echo "Registration successful!";

            } else {
                echo "Error: " . $stmt->error;
            }

            $stmt->close();
        }
    }
}

$conn->close();
?>

