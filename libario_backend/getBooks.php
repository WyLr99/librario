<?php
include("connection.php");
if(isset($_GET['q'])){
    $id = $_GET['q'];
    $sql = "SELECT Book_id,title,genre,volume_number,release_year,pages,rating,about,Full_name FROM `books`,`author` WHERE Book_id = $id AND author_id = id";
    $result = $conn->query($sql);
    $books = array();
    while($row = $result->fetch_assoc()){
    array_push($books ,$row);
}
echo json_encode($books);
}
else {
    $sql = "SELECT Book_id,title,genre,volume_number,release_year,pages,rating,about,Full_name FROM `books`,`author` WHERE author_id = id";
    $result = $conn->query($sql);
    $books = array();
    while($row = $result->fetch_assoc()){
    array_push($books ,$row);
}
echo json_encode($books);
}