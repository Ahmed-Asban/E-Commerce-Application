<?php 
include ('./connect.php');

$data = array();

$sql = "SELECT * FROM category";

$result = $con->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

if (!empty($data)) {
    header('Content-Type: application/json');
    echo json_encode($data);
} else {
    echo json_encode([]);
}
?>
