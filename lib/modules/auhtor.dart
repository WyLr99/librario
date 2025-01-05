import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import 'package:flutter/material.dart';
import 'books.dart';
const String AuthorbaseUrl = "http://ibrahimahmad.atwebpages.com/getAuthor.php?q=";

class Author{
  final int authorId;
  final String authorName;
  final String bornIn;
  final String authorAbout;
  Author(this.authorId,this.authorName,this.bornIn,this.authorAbout);

    @override
      String toString(){
      return "Author name: $authorName born in $bornIn";
    }

}
Author currentAuthor = Author(1, '1', '1' ,'1');
Future<void> updateAuthor(bookId) async{
  final url = Uri.parse(AuthorbaseUrl+"$bookId");
  final response = await http.get(url);
  if(response.statusCode == 200){
    final result = converter.jsonDecode(response.body);
    var row = result;
      Author a = Author(int.parse(row['id']),
                        row['Full_name'],
                        row['Year_of_birth'] ,
                        row['info']);
      currentAuthor = a;
  }
}

List<Book> currentAuthorBooks = [];
Future<void> getAuthorBooks(autId) async{
  final url = Uri.parse(BooksbaseUrl+"?q=$autId");
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


