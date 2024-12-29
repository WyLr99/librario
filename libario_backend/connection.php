<?php
$conn = mysqli_connect("localhost","root","","libario_db");
if($conn->connect_error){
    die("Couldnt connect to database");
}

