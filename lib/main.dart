import 'package:flutter/material.dart';
import 'package:medkube/Screens/detail_screen.dart';
import 'package:medkube/Screens/home_screen.dart';
import 'package:medkube/Screens/products_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Screens/register_screen.dart';
import 'package:medkube/Screens/welcome_screen.dart';

import 'Screens/cart_screen.dart';

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

        HomeScreen.id: (context) => HomeScreen(),
        CartScreen.id: (context) => CartScreen(),
        DetailScreen.id: (context) => DetailScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ProductScreen.id: (context) => ProductScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
