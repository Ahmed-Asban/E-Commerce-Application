<?php
// Database connection
include './connect.php';

// Check connection

// Prepare the SQL statement to delete all items from the cart
$sql = "DELETE FROM cart"; // Command to delete all items

if ($con->query($sql) === TRUE) {
    echo json_encode(["success" => true, "message" => "All items removed from cart"]);
} else {
    echo json_encode(["success" => false, "message" => "Error removing items: "]);
}

$con->close();
?>