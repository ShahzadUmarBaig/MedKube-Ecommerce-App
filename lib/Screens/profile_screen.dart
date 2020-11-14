import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/profile_textfield.dart';
import 'package:medkube/constants.dart';

class ProfileScreen extends StatelessWidget {
  static const id = "ProfileScreen";
  final userData = FirebaseAuth.instance.currentUser;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();

  getUserName(BuildContext context) {
    if (userData.displayName == null) {
      return "Regular Customer";
    } else {
      return userData.displayName;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
    _userName.text = getUserName(context);
    _email.text = userData.email;
    return Scaffold(
      body: userData != null ? profileBody(context) : loginBody(context),
    );
  }

  loginBody(BuildContext context) {
    return SafeArea(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                buttonColor: Colors.lightBlueAccent,
                buttonText: "Go Back",
                buttonTextColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileBody(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 8),
          children: [
            CircleAvatar(
              radius: 72,
              child: CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage("images/customer1.png"),
              ),
            ),
            SizedBox(
              height: 48.0,
              child: Center(
                  child: Text(
                "Customize Profile",
                style: GoogleFonts.montserrat(
                    fontSize: 28.0, color: Colors.black54),
              )),
            ),
            ProfileTextField(
              controller: _userName,
              hint: "Display Name",
            ),
            ProfileTextField(
              controller: _email,
              hint: "User Email",
            ),
            Text(userData.email.toString()),
            Text(userData.emailVerified.toString()),
            Text(userData.displayName.toString()),
            Text(userData.uid.toString()),
            Text(userData.phoneNumber.toString()),
            Text(userData.tenantId.toString()),
            Text(userData.refreshToken),
          ],
        ),
      ),
    );
  }
}
