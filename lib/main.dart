import 'package:book__share/views/homepage.dart';
import 'package:book__share/views/ippage.dart';
import 'package:book__share/views/login.dart';
import 'package:flutter/material.dart';

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
      title: 'Book share',
    
      home: PreferanceHomePage()
    );
  }
}
