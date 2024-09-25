import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quad/screen/MainScreen.dart'; // Update with your correct path

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Start a timer to navigate to MainScreen after a delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or image
            Image.asset(
              'assets/images/Logo.png', // Update with your logo path
              width: 100, // Adjust width as needed
            ),
            const SizedBox(height: 20),
            // Welcome message
            Text(
              'Welcome to Movies App',
              style: TextStyle(
                fontSize: 24, // Adjust font size as needed
                color: Colors.white, // Set text color
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54, // Set a subtle color for loading text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
