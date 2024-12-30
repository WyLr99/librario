import 'package:flutter/material.dart';
import 'package:librario/modules/books.dart';
class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is book page"),
      ),
      body: Center(child: Text(currentBookPage.toString()),)
    );
  }
}
