import 'package:flutter/material.dart';
import 'package:quad/screen/HomePage.dart'; // Update with your correct path
import 'package:quad/screen/searchscreen.dart'; // Update with your correct path
import 'package:quad/screen/details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Update with your correct path

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List movies = [];
  int _currentIndex = 0; // Initialize your movies list

  // Method to simulate fetching movies
  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovies(); // Fetch movies when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    // Create the screens based on the current index
    final List<Widget> _screens = [
      HomeScreen(movies: movies), // Pass the movies to HomeScreen
      SearchScreen(),
    ];

    return Scaffold(
      //appBar: AppBar(title: const Text('Movies App')),
      body: _currentIndex == 0
          ? HomeScreen(movies: movies) // Display the HomeScreen
          : SearchScreen(), // Display the SearchScreen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
