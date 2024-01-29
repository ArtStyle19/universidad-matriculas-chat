<?php
session_start();

$response = array();

if (isset($_SESSION['user'])) {
    $response['loggedIn'] = true;
    $response['userDetails']['username'] = $_SESSION['user'];
} else {
    $response['loggedIn'] = false;
}

header('Content-Type: application/json');
echo json_encode($response);
?>

