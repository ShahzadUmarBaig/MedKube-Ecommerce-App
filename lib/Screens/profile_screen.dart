import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/constants.dart';

class ProfileScreen extends StatelessWidget {
  static const id = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.close,
      //         color: Colors.black45,
      //         size: 30,
      //       ),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       }),
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Hero(
                  tag: "ProfPic",
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/user.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  text: TextSpan(
                    style: kDefaultStyle,
                    children: [
                      TextSpan(text: 'Please '),
                      TextSpan(
                          text: 'login ',
                          style: kLinkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            }),
                      TextSpan(
                        text: 'to view your profile.',
                      )
                    ],
                  ),
                ),
              ),
              CustomButton(
                buttonColor: Colors.lightBlueAccent,
                buttonText: "Go Back",
                buttonTextColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
