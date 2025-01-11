<?php 
include './connect.php';
$sql = "SELECT * FROM categories";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    $categories = array();
    while ($row = $result->fetch_assoc()) {
        $categories[] = $row;
    }
    // Send the categories as JSON
    echo json_encode($categories);
} else {
    echo json_encode(array("message" => "No categories found"));
}

?>