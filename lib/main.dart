import 'package:flutter/material.dart';
import 'package:medkube/Screens/detail_screen.dart';
import 'package:medkube/Screens/products_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.white),
        primaryIconTheme: IconThemeData(color: Colors.white),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        //CartScreen.id: (context) => CartScreen(),
        DetailScreen.id: (context) => DetailScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ProductScreen.id: (context) => ProductScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
