<?php
include("connection.php");
if(isset($_GET['q'])){
    $id = $_GET['q'];
    $sql = "SELECT 
    author.id,
    author.Full_name,
    author.Gender,
    author.Year_of_birth,
    GROUP_CONCAT(books.title SEPARATOR ',') AS titles
FROM 
    author
JOIN 
    books 
ON 
    author.id = books.author_id
WHERE 
    author.id = $id
GROUP BY 
    author.id, author.Full_name, author.Gender, author.Year_of_birth";
    $result = $conn->query($sql);
    $authors = array();
    while($row = $result->fetch_assoc()){
        array_push($authors,$row);
    }
    $rr = explode(",",$authors[0]['titles']);
    echo json_encode($rr);

}
else{
    $sql = "SELECT * FROM author";
    $result = $conn->query($sql);
    $authors = array();
    while($row = $result->fetch_assoc()){
        array_push($authors,$row);
    }
    echo json_encode($authors);
}