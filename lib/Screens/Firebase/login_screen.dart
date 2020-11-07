import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/custom_textfield.dart';
import 'package:medkube/constants.dart';

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
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Column(
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
                  TextSpan(text: 'Not a regular user? '),
                  TextSpan(
                    text: 'Register!',
                    style: kLinkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
