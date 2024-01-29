<?php
session_start();
require("conexion.php");

// Function to sanitize input data
function sanitize_input($data) {
  return htmlspecialchars(trim($data));
}

echo isset($_POST['login']);
echo $_SERVER["REQUEST_METHOD"] === "POST";
// Login User
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['login'])) {
  $username = sanitize_input($_POST['loginUsername']);
  $password = sanitize_input($_POST['loginPassword']);


  // Basic validation
  if (empty($username) || empty($password)) {
    echo "Please provide both username and password.";
  } else {
    // Check if username exists
    $check_username_query = "SELECT * FROM users WHERE username=?";
    $stmt = $conn->prepare($check_username_query);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
      // Verify password
      $row = $result->fetch_assoc();
      if (password_verify($password, $row['password'])) {
        $_SESSION['user'] = $username;
        echo "Login successful!";
      } else {
        echo "Incorrect password.";
      }
    } else {
      echo "User not found.";
    }

    $stmt->close();
  }
}

$conn->close();
?>

