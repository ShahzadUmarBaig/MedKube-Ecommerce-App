import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Screens/medical_screen.dart';
import 'package:medkube/Widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn;
  String userName;
  FirebaseAuth auth = FirebaseAuth.instance;
  User loggedUser;

  @override
  void initState() {
    super.initState();
    userName = "Anonymous Customer";
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        isLoggedIn = false;
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        return {userName = "Regular Customer", loggedUser = user};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue[600],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text("$userName",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  myImage: AssetImage("images/grocery2.png"),
                  title: "General",
                  fontSize: 22,
                ),
                CustomCard(
                  myImage: AssetImage("images/camera2.png"),
                  title: "    Upload \nPrescription",
                  fontSize: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  title: "   Medical \nEquipment",
                  fontSize: 20,
                  myImage: AssetImage("images/syring.png"),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(),
                    ),
                  ),
                ),
                CustomCard(
                  myImage: AssetImage("images/doctor.png"),
                  title: "Find Doctor",
                  fontSize: 20,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
