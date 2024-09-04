import 'package:flutter/material.dart';
import 'package:product_options/home.dart';
import 'package:product_options/state/options_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<OptionState>.value(value: OptionState(),)],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 247, 146, 207)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
