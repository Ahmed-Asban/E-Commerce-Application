<?php
include('./connect.php');
$id = $_POST['id'];
$name = $_POST['name'];
$email = $_POST['email'];
$password = md5($_POST['password']); // Encrypt the password

if(empty($name) || empty($email) || empty($password)) {
    echo json_encode('error');
} else {
    $sql = "UPDATE usser SET Username = '$name', Email = '$email', Password = '$password' WHERE id = '$id'";
    $result = $con->query($sql);

    if($result) {
        header('Content-Type: application/json');
        echo json_encode('done!');
    }
}
?>
