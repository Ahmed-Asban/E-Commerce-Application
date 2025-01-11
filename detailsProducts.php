<?php
include './connect.php';

// Get the product_id from the request
$product_id = $_POST['product_id'];

$sql = "SELECT * FROM productss WHERE id = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("i", $product_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode($row);
} else {
    echo json_encode(["error" => "Product not found"]);
}

?>