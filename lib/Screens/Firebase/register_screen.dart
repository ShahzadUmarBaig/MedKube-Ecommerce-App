import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Widgets/custom_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isPasswordValid;
  TextEditingController userName;
  TextEditingController password;
  TextEditingController confirmPassword;
  TextEditingController address;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    address = TextEditingController();
  }

  void validator() {
    if (password.text != null &&
        confirmPassword.text != null &&
        address.text != null &&
        userName.text != null) {
      if (password.text != confirmPassword.text) {
        registerUser();
      } else {
        isPasswordValid = false;
      }
    }
  }

  Future registerUser() async {}

  String validateField(String value) {
    print(value);
    return value;
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: userName,
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
                  controller: address,
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
              CustomButton(
                buttonText: "Register",
                buttonTextColor: Colors.white,
                buttonColor: Colors.blueAccent,
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _showToast(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
