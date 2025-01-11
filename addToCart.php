<?php
include './connect.php';

$product_id = $_POST['product_id'];

$sql = "INSERT INTO cart (product_id) VALUES ('$product_id')";
if (mysqli_query($con, $sql)) {
    echo json_encode(["message" => "Product added to cart"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Failed to add product"]);
}
?>