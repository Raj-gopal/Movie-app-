import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List movies = [];
  bool isLoading = false;

  Future<void> searchMovies(String query) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to search movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // Wrap with SingleChildScrollView
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search for a movie...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (query) {
                  searchMovies(query);
                },
              ),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : movies.isEmpty
                ? const Center(child: Text('No movies found'))
                : GridView.builder(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 0.7, // Control the aspect ratio of each grid item
              ),
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
              shrinkWrap: true, // Allow GridView to shrink
              itemBuilder: (context, index) {
                var movie = movies[index]['show'];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        movie['image'] != null
                            ? Image.network(
                          movie['image']['medium'],
                          fit: BoxFit.cover,
                        )
                            : const Icon(Icons.movie, size: 100),
                        // Optional movie name and summary
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     movie['name'],
                        //     style: const TextStyle(
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Text(
                        //     _stripHtmlTags(movie['summary'] ?? ''),
                        //     style: const TextStyle(fontSize: 12),
                        //     maxLines: 3,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
