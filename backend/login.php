<?php
session_start();
require("conexion.php");

// Function to sanitize input data
function sanitize_input($data) {
  return htmlspecialchars(trim($data));
}

// Login User
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['login'])) {
  $email = sanitize_input($_POST['loginEmail']);
  $password = sanitize_input($_POST['loginPassword']);

  // Basic validation
  if (empty($email) || empty($password)) {
    echo "Please provide both email and password.";
  } else {
    // Check if email exists
    $check_email_query = "SELECT * FROM Students WHERE Email=?";
    $stmt = $conn->prepare($check_email_query);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
      // Verify password
      $row = $result->fetch_assoc();
      if (password_verify($password, $row['Password'])) {
        $_SESSION['user'] = $row['Username']; // Use the username or any other identifier
        echo "Login successful!";
      } else {
        echo "Incorrect password.";
      }
    } else {
      echo "Email not found.";
    }

    $stmt->close();
  }
}

$conn->close();
?>
