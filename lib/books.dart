import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
const String baseUrl = "http://192.168.1.106/libario_backend/getAllBooks.php";
class Book{

  final String title;
  final String genre;
  final String year;
  final String rating;
  final String authorName;

  Book(this.title,this.genre,this.year,this.rating,this.authorName);
  @override
  String toString(){
    return "Title: $title released in $year";
  }
}

  List<Book> allBooks = [];
  void updateBooks() async{
  final url = Uri.parse(baseUrl);
  final response = await http.get(url);
  allBooks.clear();
  if(response.statusCode == 200){
    final Json = converter.jsonDecode(response.body);
    for(var row in Json){
      Book b = Book(row['title'],
                    row['genre'],
                    row['release_year'],
                    row['rating'],
                    row['Full_name']);
      allBooks.add(b);
    }
  }
}
