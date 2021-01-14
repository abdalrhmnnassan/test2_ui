import 'package:flutter/material.dart';
import 'package:test_ui/screen2.dart';
import 'package:test_ui/main_screen.dart';
import 'package:test_ui/screen3.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white)
      ),
      home: Details(),
     // home: MainScreen(),
    );
  }
}

