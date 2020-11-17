import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Screens/Firebase/register_screen.dart';
import 'package:medkube/Screens/checkout_screen.dart';
import 'package:medkube/Screens/detail_screen.dart';
import 'package:medkube/Screens/home_screen.dart';
import 'package:medkube/Screens/medical_screen.dart';
import 'package:medkube/Screens/order_screen.dart';
import 'package:medkube/Screens/prescription_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Screens/welcome_screen.dart';

import 'Screens/cart_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [DismissKeyboardNavigationObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.white),
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        OrderScreen.id: (context) => OrderScreen(),
        CheckOutScreen.id: (context) => CheckOutScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PrescriptionScreen.id: (context) => PrescriptionScreen(),
        LoginScreen.id: (context) => LoginScreen(),
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

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.didStartUserGesture(route, previousRoute);
  }
}
