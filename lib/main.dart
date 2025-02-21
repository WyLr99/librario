import 'package:flutter/material.dart';
import 'home.dart';
import 'pages/book.page.dart';
import 'pages/author.page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const Home(),
      routes: {'/bookPage':(context)=>BookPage(),
               '/authorPage': (context)=>AuthorPage()}
    );
  }
}
