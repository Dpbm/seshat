import 'package:flutter/material.dart';
import 'package:seshat/home.dart';

void main() {
  runApp(const Wrapper());
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seshat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 242, 220, 187),
            primary: const Color.fromARGB(255, 242, 220, 187),
            secondary: const Color.fromARGB(255, 54, 78, 95),
            shadow: const Color.fromARGB(153, 0, 0, 0)),
      ),
      color: Theme.of(context).primaryColor,
      home: const Home(),
    );
  }
}
