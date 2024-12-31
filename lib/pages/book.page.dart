import 'package:flutter/material.dart';
import 'package:librario/modules/books.dart';
import 'package:librario/modules/comment.dart';
class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  TextEditingController username = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentBookPage.bookId.toString()),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: username,),
          TextField(controller: body,),
          ElevatedButton(onPressed: () {addComment(username.text,body.text,currentBookPage.bookId);},
              child: Text("add comment")),
          ElevatedButton(onPressed: () {updateComments(currentBookPage.bookId);},
              child: Text("Get comments"))
        ],
      )
      ),
    );
  }
}
