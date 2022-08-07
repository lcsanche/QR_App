import 'package:flutter/material.dart';
import 'package:qrapp/src/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRApp',
      theme: ThemeData(
        primaryColor: Colors.cyan,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
        ),
      ),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomePage(),
      },
    );
  }
}
