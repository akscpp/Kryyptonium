import 'package:flutter/material.dart';

//import 'price.dart';
//import 'news.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
