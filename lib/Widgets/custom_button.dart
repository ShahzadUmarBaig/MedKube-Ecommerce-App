import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function onTap;

  const CustomButton(
      {Key key,
      this.buttonText,
      this.buttonColor,
      this.buttonTextColor,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
//      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: GoogleFonts.montserrat(color: buttonTextColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
