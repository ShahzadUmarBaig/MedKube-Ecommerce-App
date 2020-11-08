import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final bool obscureText;
  final bool isPasswordValid;

  const CustomTextField({
    Key key,
    this.textEditingController,
    this.labelText,
    this.obscureText = false,
    this.isPasswordValid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextFormField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: labelText,
          alignLabelWithHint: true,
          //  hintText: "Username",
        ),
      ),
    );
  }
}
