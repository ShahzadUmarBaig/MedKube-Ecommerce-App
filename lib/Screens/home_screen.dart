import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Screens/general_item_screen.dart';
import 'package:medkube/Screens/hospital_screen.dart';
import 'package:medkube/Screens/medical_screen.dart';
import 'package:medkube/Screens/prescription_screen.dart';
import 'package:medkube/Services/Font_Size.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/custom_drawer.dart';
import 'package:medkube/Widgets/home_screen_card.dart';
import 'package:medkube/Widgets/logo_widget.dart';
import 'package:medkube/Widgets/widgets.dart';

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
  FontSizeObserver fontSizeObserver = FontSizeObserver();

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
    try {
      await allUsers.doc(currentUser.uid).get().then((value) {
        userInfo.addAll(value.data());
      });
    } catch (e) {
      print(e);
    }
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
      await FirebaseAuth.instance.signInAnonymously();
      _scaffoldKey.currentState
          .showSnackBar(
            customSnackBar("Logged Out Successfully", 1),
          )
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
      resizeToAvoidBottomInset: false,
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
              height: MediaQuery.of(context).size.height * 0.15,
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
                HomeScreenCard(
                  myImage: AssetImage("images/grocery2.png"),
                  title: "General",
                  fontSize: fontSizeObserver.getFontSize(context, "HomeCard"),
                  onTap: () =>
                      Navigator.pushNamed(context, GeneralItemScreen.id),
                ),
                HomeScreenCard(
                  myImage: AssetImage("images/camera2.png"),
                  title: "Upload \nPrescription",
                  fontSize: fontSizeObserver.getFontSize(context, "HomeCard"),
                  onTap: () {
                    Navigator.pushNamed(context, PrescriptionScreen.id);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeScreenCard(
                  title: "Medical \nEquipment",
                  fontSize: fontSizeObserver.getFontSize(context, "HomeCard"),
                  myImage: AssetImage("images/syring.png"),
                  onTap: () =>
                      Navigator.pushNamed(context, MedicalItemScreen.id),
                ),
                HomeScreenCard(
                  myImage: AssetImage("images/hospital.png"),
                  title: "Hospitals",
                  fontSize: fontSizeObserver.getFontSize(context, "HomeCard"),
                  onTap: () {
                    Navigator.pushNamed(context, HospitalScreen.id);
                  },
                ),
              ],
            ),
            Expanded(
              child: LogoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
