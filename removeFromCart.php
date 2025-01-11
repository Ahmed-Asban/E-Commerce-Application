<?php
error_reporting(error_level: 0);
include'./connect.php';
$id = $_POST['id'];
$sql= "DELETE FROM cart WHERE id = '$id'"; 
$result =$con->query($sql);
if($result)
{
    header('content-type: application/json');
    print json_encode('done!');

}
?>