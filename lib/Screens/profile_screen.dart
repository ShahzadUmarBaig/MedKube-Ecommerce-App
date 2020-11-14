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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final Map<String, dynamic> completeData;

  ProfileScreen({Key key, this.completeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height / 8,
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
                buttonColor: Colors.red[800],
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
    _userNameController.text = completeData["Username"];
    _emailController.text = completeData["Email"];
    _addressController.text = completeData["Address"];
    _phoneController.text = completeData["Phone"];

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 12),
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
              controller: _userNameController,
              hint: "Display Name",
            ),
            ProfileTextField(
              controller: _emailController,
              hint: "User Email",
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _addressController,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: kProfileTextFieldDecoration.copyWith(
                          hintText: "Address", labelText: "Address"),
                    ),
                  )
                ],
              ),
            ),
            ProfileTextField(
              controller: _phoneController,
              hint: "Phone Number",
            ),
            CustomButton(
                marginHorizontal: 24.0,
                marginVertical: 4.0,
                onTap: () => Navigator.pop(context),
                buttonColor: Colors.red[800],
                buttonText: "Go Back",
                buttonTextColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
