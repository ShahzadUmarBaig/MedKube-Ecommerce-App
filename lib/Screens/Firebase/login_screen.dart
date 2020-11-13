import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonColor: Colors.red[600],
                            buttonText: "Go Back",
                            buttonTextColor: Colors.white,
                            onTap: () => Navigator.pop(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
