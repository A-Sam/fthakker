import 'package:flutter/material.dart';
import 'package:fthakker/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fthakker',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey)),
        primaryColor: Colors.white,
        accentColor: Colors.amber,
        fontFamily: 'Expo',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      // themeMode: ThemeMode.dark,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
