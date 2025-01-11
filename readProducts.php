<?php 
include './connect.php';

// Get the category_id from the request
$category_id = $_POST['category_id'];

$sql = "SELECT id, title, image_path, description, price FROM productss WHERE category_id = ?";
$stmt = $con->prepare($sql);
$stmt->bind_param("i", $category_id);
$stmt->execute();
$result = $stmt->get_result();

$products = [];
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}

echo json_encode($products);




?>