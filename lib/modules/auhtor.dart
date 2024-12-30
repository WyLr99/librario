import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
import 'books.dart';
const String AuthorbaseUrl = "http://192.168.1.106/libario_backend/getAuthor.php";
class Author{
  final int authorId;
  final String authorName;
  final String gender;
  final String bornIn;
  final String authorAbout;
  Author(this.authorId,this.authorName,this.gender,this.bornIn,this.authorAbout);

    @override
      String toString(){
      return "Author name: $authorName born in $bornIn";
    }
}
List<Author> authors = [];
void updateAuthors() async{
  final url = Uri.parse(AuthorbaseUrl);
  final response = await http.get(url);
  if(response.statusCode == 200){
    authors.clear();
    final result = converter.jsonDecode(response.body);
    for(var row in result){
      Author a = Author(int.parse(row['id']),
                        row['Full_name'],
                        row['Gender'],
                        row['Year_of_birth'] ,
                        row['Info']);
      authors.add(a);
    }
  }
}
Author? currentAuthor;
void selectAuthor(authorId){
  currentAuthor = authors.firstWhere((auhtor)=>auhtor.authorId == authorId);
  print(currentAuthor);
}
List<Book> currentAuthorBooks = [];
void getAuthorBooks(authorId) async{
  final url = Uri.parse(BooksbaseUrl+"?q=$authorId");
  final response = await http.get(url);
  if(response.statusCode == 200){
    currentAuthorBooks.clear();
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
     currentAuthorBooks.add(b);
    }
  }
}
