import 'package:flutter/material.dart';
import 'package:product_options/home.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 247, 146, 207)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

