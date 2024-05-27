import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seshat/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Wrapper());
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final double heightMarginTop = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height - heightMarginTop;
    final double width = MediaQuery.of(context).size.width;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Seshat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 242, 220, 187),
            primary: const Color.fromARGB(255, 242, 220, 187),
            secondary: const Color.fromARGB(255, 54, 78, 95),
            shadow: const Color.fromARGB(153, 0, 0, 0),
            error: const Color.fromARGB(255, 244, 67, 54)),
      ),
      color: Theme.of(context).primaryColor,
      home: Home(width: width, height: height),
    );
  }
}
