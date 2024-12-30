<?php
include("connection.php");

    $sql = "SELECT * FROM author";
    $result = $conn->query($sql);
    $authors = array();
    while($row = $result->fetch_assoc()){
        array_push($authors,$row);
    }
    echo json_encode($authors);
