import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Screens/hospital_screen.dart';
import 'package:medkube/Screens/medical_screen.dart';
import 'package:medkube/Screens/prescription_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/custom_card.dart';
import 'package:medkube/Widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn;
  String userName;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference allUsers = FirebaseFirestore.instance.collection('users');
  User currentUser;
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      getData();
    } else {
      signInMethod();
    }
  }

  void signInMethod() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> getData() async {
    print("Testing Login System");
    await allUsers.doc(currentUser.uid).get().then((value) {
      userInfo.addAll(value.data());
    });
    setState(() {
      isLoaded = true;
    });
  }

  getLabel() {
    if (userInfo.isNotEmpty) {
      userName = "${userInfo["firstName"]} ${userInfo["lastName"]}";
    } else {
      userName = "New Customer";
    }
  }

  getMethod(BuildContext context) async {
    if (userInfo.isEmpty) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      await FirebaseAuth.instance.signOut();
      userInfo.clear();
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                child: Text(
                  'Logged Out Successfully',
                  style: GoogleFonts.montserrat(fontSize: 20.0),
                ),
              ),
              duration: Duration(seconds: 1)))
          .closed
          .then(
            (value) => setState(
              () {
                print("User has Successfully Logged Out");
              },
            ),
          );
    }
  }

  IconData getIcon(BuildContext context) {
    if (userInfo.isEmpty) {
      return Icons.login;
    } else {
      return Icons.logout;
    }
  }

  @override
  Widget build(BuildContext context) {
    getLabel();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        userName: userInfo.isEmpty
            ? "New Customer"
            : userInfo["firstName"] + " " + userInfo["lastName"],
        userEmail: userInfo.isEmpty ? "Please Login" : userInfo["Email"],
      ),
      body: Container(
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
                    child: IconButton(
                      icon: Icon(
                        Icons.list_sharp,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
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
                        getIcon(context),
                        color: Colors.white,
                      ),
                      onPressed: () => getMethod(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  myImage: AssetImage("images/grocery2.png"),
                  title: "General",
                  fontSize: 22,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          categoryCondition: "general",
                        ),
                      ),
                    );
                  },
                ),
                CustomCard(
                  myImage: AssetImage("images/camera2.png"),
                  title: "    Upload \nPrescription",
                  fontSize: 20,
                  onTap: () {
                    Navigator.pushNamed(context, PrescriptionScreen.id);
                  },
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
                      builder: (context) => ProductScreen(
                        categoryCondition: null,
                      ),
                    ),
                  ),
                ),
                CustomCard(
                  myImage: AssetImage("images/hospital.png"),
                  title: "Hospitals",
                  fontSize: 20,
                  onTap: () {
                    Navigator.pushNamed(context, HospitalScreen.id);
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Row(
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
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(text: 'Med'),
                          TextSpan(
                            text: 'Kube',
                            style: TextStyle(color: Colors.red[600]),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "WHERE HEALTH COMES FIRST",
                      style: TextStyle(fontSize: 11.5, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
