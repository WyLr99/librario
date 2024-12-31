import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
import 'books.dart';
const String BooksbaseUrl = "http://192.168.1.106/libario_backend/getComments.php";

class Comment{
  final int comment_id;
  final String username;
  final String body;
  Comment(this.comment_id,this.username,this.body);
}

void addComment(username,commentBody,bookId){
  final body = {
    'username': '$username',
    'body':'$commentBody',
    'book_id':'$bookId'
  };
}