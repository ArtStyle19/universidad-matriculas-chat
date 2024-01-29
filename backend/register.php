<?php
session_start();
require("conexion.php");

// Function to sanitize input data
function sanitize_input($data) {
    return htmlspecialchars(trim($data));
}

// Register User
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['register'])) {
    $username = sanitize_input($_POST['username']);
    $email = sanitize_input($_POST['email']);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $departmentID = intval($_POST['department']); // Assuming 'department' is the name attribute in the form

    // Basic validation
    if (empty($username) || empty($email) || empty($_POST['password']) || empty($departmentID)) {
        echo "Please provide all required information.";
    } else {
        // Check if username or email already exists
        $check_user_query = "SELECT * FROM Students WHERE Username=?";
        $check_email_query = "SELECT * FROM Students WHERE Email=?";
        
        $stmt_user = $conn->prepare($check_user_query);
        $stmt_user->bind_param("s", $username);
        $stmt_user->execute();
        $result_user = $stmt_user->get_result();

        $stmt_email = $conn->prepare($check_email_query);
        $stmt_email->bind_param("s", $email);
        $stmt_email->execute();
        $result_email = $stmt_email->get_result();

        if ($result_user->num_rows > 0) {
            echo "Username already exists. Please choose a different username.";
        } elseif ($result_email->num_rows > 0) {
            echo "Email already exists. Please use a different email address.";
        } else {
            // Register the user
            $stmt_insert = $conn->prepare("INSERT INTO Students (Username, Password, Email, DepartmentID) VALUES (?, ?, ?, ?)");
            $stmt_insert->bind_param("sssi", $username, $password, $email, $departmentID);

            if ($stmt_insert->execute()) {
                $_SESSION['user'] = $username;
                echo "Registration successful!";
            } else {
                echo "Error: " . $stmt_insert->error;
            }

            $stmt_insert->close();
        }

        $stmt_user->close();
        $stmt_email->close();
    }
}

$conn->close();
?>
