import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/profile_textfield.dart';
import 'package:medkube/constants.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "ProfileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  CollectionReference allUsers = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userInfo.isNotEmpty ? profileBody(context) : loginBody(context),
    );
  }

  getWaitingKit(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueAccent,
      child: SpinKitWave(
        type: SpinKitWaveType.start,
        color: Colors.white,
        size: 40.0,
      ),
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
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: MediaQuery.of(context).devicePixelRatio > 2.0
                          ? 19
                          : 16),
                  children: [
                    TextSpan(text: 'Please '),
                    TextSpan(
                        text: 'login ',
                        style: GoogleFonts.montserrat(
                            color: Colors.blue,
                            fontSize:
                                MediaQuery.of(context).devicePixelRatio > 2.0
                                    ? 19
                                    : 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.id);
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
    _firstNameController.text = userInfo["firstName"];
    _lastNameController.text = userInfo["lastName"];
    _apartmentController.text = userInfo["Apartment"];
    _phoneController.text = userInfo["Phone"];
    _countryController.text = userInfo["Country"];
    _cityController.text = userInfo["City"];
    _addressController.text = userInfo["Address"];
    _emailController.text = userInfo["Email"];

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
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter First Name";
                        }
                        return null;
                      },
                      controller: _firstNameController,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                      decoration: kProfileTextFieldDecoration.copyWith(
                        hintText: "First Name",
                        labelText: "First Name",
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Last Name";
                        }
                        return null;
                      },
                      controller: _lastNameController,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                      decoration: kProfileTextFieldDecoration.copyWith(
                          hintText: "Last Name", labelText: "Last Name"),
                    ),
                  ),
                ],
              ),
            ),
            ProfileTextField(
              enabled: false,
              controller: _emailController,
              hint: "Email",
            ),
            ProfileTextField(
              enabled: false,
              controller: _apartmentController,
              hint: "Apartment No (Optional)",
            ),
            ProfileTextField(
              enabled: false,
              controller: _phoneController,
              hint: "Phone Number",
            ),
            ProfileTextField(
              enabled: false,
              controller: _countryController,
              hint: "Country",
            ),
            ProfileTextField(
              enabled: false,
              controller: _cityController,
              hint: "City",
            ),
            ProfileTextField(
              enabled: false,
              controller: _addressController,
              hint: "Address",
            ),
            CustomButton(
              marginHorizontal: 24.0,
              marginVertical: 4.0,
              onTap: () => Navigator.pop(context),
              buttonColor: Colors.red[800],
              buttonText: "Go Back",
              buttonTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
