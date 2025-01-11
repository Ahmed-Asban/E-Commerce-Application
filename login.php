<?php
error_reporting(0);
include ("./connect.php");

$email = $_POST['email'];
$pass = md5($_POST['password']);

// Prepare the SQL statement
$stmt = $con->prepare("SELECT Username, Email FROM user WHERE Email = ? AND Password = ?");
$stmt->bind_param("ss", $email, $pass);

// Execute the query
$stmt->execute();

// Get the result
$result = $stmt->get_result();

// Count the number of rows
$count = $result->num_rows;

if ($count > 0) {
    // Fetch user data
    $user = $result->fetch_assoc();
    echo json_encode(array("status" => "success", "message" => "تم تسجيل الدخول بنجاح.", "data" => $user));
} else {
    // No user found, return failure
    echo json_encode(array("status" => "fail", "message" => "اسم المستخدم أو كلمة المرور غير صحيحة."));
}

// Close the statement and the connection
$stmt->close();
$con->close();
?>
