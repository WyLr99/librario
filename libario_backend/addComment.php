<?php
if($_SERVER['REQUEST_METHOD'] === 'POST'){
    extract($_POST); 
    include("connection.php");
    $sql = "INSERT INTO comments(`username`, `body`, `Cbook_id`) VALUES ('$username','$Cbody',
    '$book_id')";
    if(!$conn->query($sql)){
        echo"statement failed";
    }
    else{
        echo"inserted";
    }

}
else{
    echo "didnt get the post";
}