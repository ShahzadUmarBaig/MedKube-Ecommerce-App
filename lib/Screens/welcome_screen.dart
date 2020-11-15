import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.easeIn;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(
    //   Duration(seconds: 2),
    //   () {
    //     Navigator.of(context).push(
    //       _createRoute(),
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget loadingBody() {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Align(
            alignment: Alignment.center,
            child: SpinKitWave(
              type: SpinKitWaveType.start,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: 50,
                    height: 50,
                    image: AssetImage("images/logo.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: 'Med'),
                        TextSpan(
                          text: 'Kube',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.red[900],
            child: Center(
              child: Card(
                elevation: 8.0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Restart The Application",
                        style: GoogleFonts.montserrat(
                            fontSize: 24.0, color: Colors.black54),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "Application could not load Properly",
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, streamSnapshot) {
              if (streamSnapshot.hasData) {
                return HomeScreen();
              } else {
                return HomeScreen();
              }
            },
          );
        }

        return loadingBody();
      },
    );
  }
}

/*

 */
