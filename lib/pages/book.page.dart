import 'package:flutter/material.dart';
import 'package:librario/modules/books.dart';
import 'package:librario/modules/comment.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<Comment> comments = [];

  TextEditingController usernameController = TextEditingController();
  TextEditingController commentBodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }


  void _fetchComments() {
    updateComments(currentBookPage.bookId);
    setState(() {
      comments = allComments;
    });
  }

 void _addCommentDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add a Comment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(hintText: "Enter your username"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: commentBodyController,
              decoration: const InputDecoration(hintText: "Enter your comment"),
              maxLines: 3,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              usernameController.clear();
              commentBodyController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (usernameController.text.isNotEmpty &&
                  commentBodyController.text.isNotEmpty) {
                addComment(
                  usernameController.text,
                  commentBodyController.text,
                  currentBookPage.bookId,
                );

                // Clear the text fields
                usernameController.clear();
                commentBodyController.clear();

                // Fetch the updated comments
                _fetchComments();

                // Close the dialog
                Navigator.of(context).pop();
              } else {
                // Show an alert if fields are empty
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please fill in all fields.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentBookPage.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookHeader(),
            _buildBookInfo(),
            _buildAboutSection(),
            _buildCommentsSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCommentDialog,
        child: const Icon(Icons.add_comment),
        tooltip: 'Add Comment',
      ),
    );
  }

  Widget _buildBookHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentBookPage.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/authorPage');
              },
              child: Text(
                'by ${currentBookPage.authorName}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.category, 'Genre', currentBookPage.genre),
          _buildInfoRow(Icons.book, 'Volume', currentBookPage.volumeNum),
          _buildInfoRow(Icons.calendar_today, 'Year', currentBookPage.year),
          _buildInfoRow(Icons.pages, 'Pages', currentBookPage.pages),
          _buildInfoRow(Icons.star, 'Rating', currentBookPage.rating),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.indigo),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(currentBookPage.about),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (comments.isEmpty)
            const Text('No comments yet for this book!')
          else
            ...comments.map((comment) => _buildCommentCard(comment)),
        ],
      ),
    );
  }

  Widget _buildCommentCard(Comment comment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  comment.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              comment.body,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
