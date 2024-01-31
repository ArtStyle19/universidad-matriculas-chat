<?php
session_start();

$response = array();

if (isset($_SESSION['user'])) {
    $response['loggedIn'] = true;
    $response['userDetails']['username'] = htmlspecialchars($_SESSION['user'], ENT_QUOTES, 'UTF-8'); // Sanitize user input
} else {
    $response['loggedIn'] = false;
}

header('Content-Type: application/json');
echo json_encode($response);
?>
