import 'package:flutter/material.dart';
import 'package:fthakker/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mothakker',
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey)),
          primaryColor: Colors.white,
          accentColor: Colors.amber[500],
          fontFamily: 'Expo'),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
