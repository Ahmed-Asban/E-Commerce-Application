<?php
include('./connect.php'); // Database connection


header('Content-Type: application/json');


$username = $_POST['Username'];
$password = md5($_POST['Password']);
$email = $_POST['Email'];


$query = "INSERT INTO usser SET Username = '$username', Password = '$password', Email = '$email' ";

$result = mysqli_query($con, $query);

if($result)
{
    echo json_encode(array("success" => true, "message" => "Login successful."));
}
else
{
    echo json_encode(array("success" => false, "message" => "Invalid username or password."));
}

mysqli_close($con);





