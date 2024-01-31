<?php
session_start();

// Function to generate a random string for CAPTCHA
function generateRandomString($length = 5) {
    $characters = '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

// Generate CAPTCHA
$captchaString = generateRandomString();

// Store CAPTCHA in session
$_SESSION['captcha_code'] = $captchaString;

// Path to the background image on your server
$backgroundImagePath = './captcha.jpg';

// Load the background image
$backgroundImage = imagecreatefromjpeg($backgroundImagePath);

// Create a GD image of the same size as the background image
$image = imagecreatetruecolor(imagesx($backgroundImage), imagesy($backgroundImage));

// Copy the background image to the new image
imagecopy($image, $backgroundImage, 0, 0, 0, 0, imagesx($backgroundImage), imagesy($backgroundImage));

// Define colors
$textColor = imagecolorallocate($image, 0, 0, 0); // Text in black

// Draw lines and dots for additional distortion
for ($i = 0; $i < 5; $i++) {
    imageline($image, mt_rand(0, imagesx($image)), mt_rand(0, imagesy($image)), mt_rand(0, imagesx($image)), mt_rand(0, imagesy($image)), $textColor);
    imagesetpixel($image, mt_rand(0, imagesx($image)), mt_rand(0, imagesy($image)), $textColor);
}

// Path to the TTF font on your server
$fontPath = './fuentexd.ttf';

// Draw CAPTCHA text on the image with some distortion
$fontSize = 17;
$angle = mt_rand(-10, 10); // Random angle
$x = 13;
$y = 22;

// Draw text using TTF font
imagettftext($image, $fontSize, $angle, $x, $y, $textColor, $fontPath, $captchaString);

// Set the content type of the image
header('Content-type: image/png');

// Display the PNG image
imagepng($image);

// Free up memory
imagedestroy($image);
?>
