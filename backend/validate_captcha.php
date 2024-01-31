<?php
session_start();

if (isset($_POST['captcha'])) {
  $enteredCaptcha = strtoupper($_POST['captcha']);
  $actualCaptcha = strtoupper($_SESSION['captcha_code']);

  if ($enteredCaptcha === $actualCaptcha) {
    echo 'success';
  } else {
    echo 'error';
  }
} else {
  echo 'error';
}
?>
