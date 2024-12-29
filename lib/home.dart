import 'package:flutter/material.dart';
import 'books.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateBooks();
    super.initState();
  }
  List<Book> temp = allBooks;
  void updateTemp(){
    updateBooks();
    setState(() {
      temp = allBooks;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {updateTemp();}, child: Icon(Icons.refresh)),
            Expanded(child:
            ListView.builder(itemCount: temp.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:Text(temp[index].toString(),),
                );
              },
            ),)
          ],
        )
      ),
    );

  }
}