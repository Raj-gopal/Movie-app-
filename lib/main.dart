import 'package:flutter/material.dart';
import 'package:quad/screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  SplashScreen(),  // Start with the SplashScreen
    );
  }
}
