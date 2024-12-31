import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
const String BooksbaseUrl = "http://192.168.1.106/libario_backend/getBooks.php";
class Book{
  final int bookId;
  final String title;
  final String genre;
  final String volumeNum;
  final String year;
  final String pages;
  final String rating;
  final String about;
  final String authorName;

  Book(this.bookId,this.title,this.genre,this.volumeNum,this.year,this.pages,this.rating,this.about,this.authorName);
  @override
  String toString(){
    return "Title: $title released in $year";
  }
}

  List<Book> allBooks = [];
  Future <void> updateBooks() async{
  final url = Uri.parse(BooksbaseUrl);
  final response = await http.get(url);
  allBooks.clear();
  if(response.statusCode == 200){
    final result = converter.jsonDecode(response.body);
    for(var row in result){
      Book b = Book(int.parse(row['Book_id']),
                    row['title'],
                    row['genre'],
                    row['volume_number'],
                    row['release_year'],
                    row['pages'],
                    row['rating'],
                    row['about'],
                    row['Full_name']);
      allBooks.add(b);
    }
  }
}
 Book currentBookPage = allBooks[0];
void selectBook(bookId){
  currentBookPage = allBooks.firstWhere((book)=>book.bookId == bookId);
  print(currentBookPage);
}


