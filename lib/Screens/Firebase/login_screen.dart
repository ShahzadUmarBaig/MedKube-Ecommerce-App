import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/Firebase/register_screen.dart';
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
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/icons8_login_200px_1.png'),
                  ),
                  CustomTextField(
                    labelText: "Username",
                    textEditingController: usernameController,
                  ),
                  CustomTextField(
                      labelText: "Password",
                      textEditingController: passwordController,
                      obscureText: true),
                  CustomButton(
                    buttonColor: Colors.lightBlueAccent,
                    buttonText: "Login",
                    buttonTextColor: Colors.white,
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
