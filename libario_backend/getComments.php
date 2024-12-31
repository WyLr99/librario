<?php
if(isset($_POST['bookId'])){
    include("connection.php");
    $book_id = $_POST['bookId'];
    $sql = "SELECT * FROM comments where Cbook_id = $book_id";
    $comments = array();
    $result = $conn->query($sql);
    while($row = $result->fetch_assoc()){
        array_push($comments,$row);
    }
    echo json_encode($comments);
}