import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medkube/Screens/Firebase/register_screen.dart';
import 'package:medkube/Screens/home_screen.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/custom_textfield.dart';
import 'package:medkube/constants.dart';

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

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 7),
                  Image(
                    image: AssetImage('images/icons8_login_200px_1.png'),
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
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.id);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  RichText(
                    text: TextSpan(
                      style: kDefaultStyle,
                      children: [
                        TextSpan(text: 'Not a regular customer? '),
                        TextSpan(
                          text: 'Become one!',
                          style: kLinkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
