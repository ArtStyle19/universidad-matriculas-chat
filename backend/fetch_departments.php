<?php
// fetch_departments.php

// Include the database connection file
include_once("conexion.php");

// Validate input (optional, depending on the context)
// You may want to further validate or sanitize the input depending on your use case.
// For example, if this endpoint is accessed by an AJAX request, you might want to
// check the CSRF token.

// Fetch departments from the database using a prepared statement
$query = "SELECT * FROM Departments";
$stmt = mysqli_prepare($conn, $query);

// Check for errors in preparing the statement
if (!$stmt) {
    die('Error preparing statement');
}

// Execute the statement
mysqli_stmt_execute($stmt);

// Get result set
$result = mysqli_stmt_get_result($stmt);

// Check for errors
if (!$result) {
    die('Error fetching departments');
}

// Fetch the data into an associative array
$departments = array();
while ($row = mysqli_fetch_assoc($result)) {
    $departments[] = $row;
}

// Return the data as JSON
header('Content-Type: application/json');
echo json_encode($departments);

// Close the statement and database connection
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>
