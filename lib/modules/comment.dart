import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
import 'books.dart';
const String addCommentsbaseUrl = "http://ibrahimahmad.atwebpages.com/addComment.php";
const String getCommentsbaseUrl = "http://ibrahimahmad.atwebpages.com/getComments.php";

class Comment{
  final int comment_id;
  final String username;
  final String body;
  Comment(this.comment_id,this.username,this.body);
  @override
  String toString() {
    return "username: $username the comment: $body";
  }
}

Future<void> addComment(username,commentBody,bookId) async{
  final body = {
    'username': username,
    'Cbody':commentBody,
    'book_id':bookId.toString()
  };
  final url = Uri.parse(addCommentsbaseUrl);
    await http.post(url,body: body);
    await updateComments(bookId);
}
List<Comment> allComments = [];
Future<void> updateComments(bookId) async{
  final body = {'bookId':bookId.toString()};
  final url = Uri.parse(getCommentsbaseUrl);
  final response = await http.post(url,body: body);
  allComments.clear();
  if(response.statusCode == 200){
    final result = converter.jsonDecode(response.body);
    for(var row in result){
      Comment c = Comment(int.parse(row['comment_id']),
                          row['username'],
                          row['body']);
      allComments.add(c);
    }
  }
}