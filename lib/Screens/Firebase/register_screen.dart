import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/home_screen.dart';
import 'package:medkube/Widgets/custom_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordValid;
  TextEditingController email;
  TextEditingController password;
  TextEditingController confirmPassword;
  TextEditingController address;
  TextEditingController phoneNumber;
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    address = TextEditingController();
    phoneNumber = TextEditingController();
  }

  Future registerUser() async {}

  String validateField(String value) {
    print(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 12,
            ),
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Become a Customer!",
                    style: GoogleFonts.montserrat(
                        color: Colors.black54, fontSize: 32),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Hero(
                    tag: "ProfPic",
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("images/user.png")),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  controller: email,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Email",
                    alignLabelWithHint: true,
                    //  hintText: "Username",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  controller: password,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Password",
                    alignLabelWithHint: true,
                    //  hintText: "Username",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Confirm Password";
                    } else if (value != password.text) {
                      return "Password Doesn't Match";
                    }
                    return null;
                  },
                  controller: confirmPassword,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Confirm Password",
                    alignLabelWithHint: true,
                    //  hintText: "Username",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Address";
                    }
                    return null;
                  },
                  controller: address,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Address",
                    alignLabelWithHint: true,
                    //  hintText: "Username",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Phone Number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: phoneNumber,
                  textAlign: TextAlign.center,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: "Phone Number",
                    alignLabelWithHint: true,
                    //  hintText: "Username",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  buttonText: "Register",
                  buttonTextColor: Colors.white,
                  buttonColor: Colors.blueAccent,
                  onTap: () async {
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('users');

                    if (_formKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email.text, password: password.text);
                        String userUID = FirebaseAuth.instance.currentUser.uid;
                        await users.doc(userUID).set({
                          'UID': FirebaseAuth.instance.currentUser.uid,
                          'Address': address.text,
                          'Email': email.text,
                          'Phone': phoneNumber.text,
                          'firstName': "Regular",
                          'lastName': "Customer",
                          'Apartment': "",
                          'Country': "Pakistan",
                          'City': "Karachi",
                        });
                        _scaffoldKey.currentState
                            .showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 4.0),
                                  child: Text(
                                    'Registered Successfully',
                                    style:
                                        GoogleFonts.montserrat(fontSize: 20.0),
                                  ),
                                ),
                                duration: Duration(seconds: 3)))
                            .closed
                            .then((value) => Navigator.pushReplacementNamed(
                                context, HomeScreen.id));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  buttonText: "Go Back",
                  buttonTextColor: Colors.white,
                  buttonColor: Colors.red[800],
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
