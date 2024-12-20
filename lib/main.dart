import 'package:flutter/material.dart';
import 'package:pla_todo_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
