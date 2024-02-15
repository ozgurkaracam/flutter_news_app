import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Colors.pink,
        primarySwatch: Colors.pink,
        primaryIconTheme: IconThemeData(color: Colors.pink),
        primaryColorLight: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
