import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/register_screen.dart';
import 'package:medkube/Screens/home_screen.dart';
import 'package:medkube/Services/Font_Size.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/custom_textfield.dart';
import 'package:medkube/Widgets/widgets.dart';

import '../../extras.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email;
  TextEditingController password;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FontSizeObserver fontSizeObserver = FontSizeObserver();
  bool isLoading;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SpinKitWave(
                      type: SpinKitWaveType.start,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 8,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "We Are Logging You In!",
                        style: GoogleFonts.montserrat(
                            fontSize: fontSizeObserver.getFontSize(
                                context, "WaitingScreen"),
                            color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: double.infinity,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    children: [
                      Container(
                        height: 200,
                        child: Image(
                          image: AssetImage('images/icons8_login_200px_1.png'),
                        ),
                      ),
                      CustomTextField(
                        labelText: "Username",
                        textEditingController: email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Email";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "Password",
                        textEditingController: password,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                buttonColor: Colors.red[600],
                                buttonText: "Go Back",
                                buttonTextColor: Colors.white,
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, HomeScreen.id),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: CustomButton(
                                buttonColor: Colors.lightBlueAccent,
                                buttonText: "Login",
                                buttonTextColor: Colors.white,
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      await FirebaseAuth.instance.signOut();

                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text);
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.id);
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      _scaffoldKey.currentState.showSnackBar(
                                          customSnackBar(e.code, 2));
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                  color: Colors.black54,
                                  fontSize: fontSizeObserver.getFontSize(
                                      context, "Become")),
                              children: [
                                TextSpan(text: 'Not a regular customer? '),
                                TextSpan(
                                  text: 'Become one!',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.blue,
                                      fontSize: fontSizeObserver.getFontSize(
                                          context, "Become")),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.id);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
