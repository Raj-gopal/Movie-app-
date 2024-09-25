import 'package:flutter/material.dart';
import 'details_screen.dart'; // Ensure you import the DetailsScreen

class HomeScreen extends StatelessWidget {
  final List movies; // Declare movies as a final list

  HomeScreen({required this.movies}); // Accept movies as a required parameter

  // Utility method to strip HTML tags from the summary
  String _stripHtmlTags(String html) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return html.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(title: const Text('Movies App')),
      body:GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Show 2 items per row
        childAspectRatio: 0.7, // Adjust aspect ratio as needed
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index]['show'];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(movie: movie), // Navigate to DetailsScreen
              ),
            );
          },
          child: Card(
            elevation: 4, // Add shadow for better visual appeal
            margin: const EdgeInsets.all(8), // Add margin around the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
              children: [
                movie['image'] != null
                    ? Image.network(movie['image']['medium'], fit: BoxFit.cover) // Display movie image
                    : const Icon(Icons.movie, size: 100), // Fallback icon if no image
                // Padding(
                //   padding: const EdgeInsets.all(8.0), // Padding for the text
                //   child: Text(
                //     movie['name'],
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     maxLines: 2, // Limit lines for long titles
                //     overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0), // Horizontal padding for summary
                //   child: Text(
                //     _stripHtmlTags(movie['summary'] ?? ''), // Strip HTML tags from summary
                //     maxLines: 3, // Limit lines for summary
                //     overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                //     style: TextStyle(fontSize: 14), // Style for summary text
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
      ));

  }
}
