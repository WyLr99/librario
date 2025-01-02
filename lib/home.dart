import 'package:flutter/material.dart';
import 'modules/books.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> temp = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  final List<Color> cardColors = [
    Colors.blueGrey[800]!,
    Colors.indigo[900]!,
    Colors.teal[800]!,
    Colors.brown[800]!,
    Colors.deepPurple[800]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.orange[800]!,
    Colors.red[900]!,
    Colors.pink[800]!,
  ];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() async {
    await updateBooks();
    setState(() {
      temp = allBooks;
      isLoading = false;
    });
  }

  void navigateToBook(int bookId) {
    selectBook(bookId);
    Navigator.pushNamed(context, '/bookPage');
  }

  void searchBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        temp = allBooks;
      } else {
        temp = allBooks
            .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }


  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('A to Z'),
                onTap: () {
                  Navigator.pop(context);//this to close the modal after choosing
                  setState(() {
                    temp.sort((a,b)=> a.title.compareTo(b.title));
                  });
                },
              ),
              ListTile(
                title: const Text('Year of Publish'),
                onTap: () {
                  Navigator.pop(context);//this to close the modal after choosing
                  setState(() {
                    temp.sort((a,b)=> b.year.compareTo(a.year));
                  });
                },
              ),
              ListTile(
                title: const Text('Author Name'),
                onTap: () {
                  Navigator.pop(context);//this to close the modal after choosing
                  setState(() {
                    temp.sort((a,b)=> a.authorName.compareTo(b.authorName));
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Librario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadBooks,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: showFilterOptions,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Books...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: searchBooks,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : temp.isEmpty
              ? const Center(
                  child: Text(
                    "Book not found.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: temp.length,
                  itemBuilder: (context, index) {
                    final book = temp[index];
                    final color = cardColors[index % cardColors.length];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            right: 15,
                            child: Material(
                              color: color,
                              child: InkWell(
                                onTap: () => navigateToBook(book.bookId),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      Text("By: ${book.authorName}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text("Published: ${book.year}",                                
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            width: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(-2, 0),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: List.generate(
                                  20,
                                  (index) => Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 1),
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
