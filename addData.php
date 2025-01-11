<?php
include('./connect.php');
$name = $_POST['name'];
$email = $_POST['email'];
$password = md5($_POST['password']); // Encrypt the password

if(empty($name) || empty($email) || empty($password)){
    echo json_encode('null!');
} else {
    $sql = "INSERT INTO usser (Username, Email, Password) VALUES ('$name', '$email', '$password')";
    $result = $con->query($sql);

    if($result) {
        header('Content-Type: application/json');
        echo json_encode('done!');
    }
}
?>
