import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['name'])),
      body: SingleChildScrollView( // Wrap in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              movie['image'] != null
                  ? Image.network(movie['image']['original']) // Display original image
                  : const Icon(Icons.movie, size: 200), // Fallback icon
              const SizedBox(height: 16),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow_rounded, color: Colors.black),
                    const SizedBox(width: 8), // Optional spacing between icon and text
                    Text('Play', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _stripHtmlTags(movie['summary'] ?? ''),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility method to strip HTML tags from the summary
  String _stripHtmlTags(String html) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return html.replaceAll(exp, '');
  }
}
