<?php
include('./connect.php'); // Database connection

header('Content-Type: application/json');

$username = $_POST['Username'];
$email = $_POST['Email'];
$password = md5($_POST['Password']);

// Check if the username or email already exists
$checkQuery = "SELECT * FROM user WHERE Username = '$username' OR Email = '$email'";
$checkResult = mysqli_query($con, $checkQuery);

if (mysqli_num_rows($checkResult) > 0) {
    echo json_encode(array("success" => false, "message" => "الحساب بالفعل موجود حاول مرة اخرى"));
} else {
    //If no account exists, proceed with the signup
    $query = "INSERT INTO user (Username, Email, Password) VALUES ('$username', '$email', '$password')";
    $result = mysqli_query($con, $query);

    if ($result) {
        echo json_encode(array("status" => "success", "message" => "تم تسجيل الدخول بنجاح."));
    } else {
        echo json_encode(array("status" => "fail", "message" => "فشل تسجيل الدخول: " . mysqli_error($con)));
    }
}

mysqli_close($con);
?>