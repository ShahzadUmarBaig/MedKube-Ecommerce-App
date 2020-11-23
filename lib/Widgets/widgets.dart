import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SectionHeading extends StatelessWidget {
  SectionHeading({this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        heading,
        style: kSectionHeaderStyle,
      ),
    );
  }
}


SnackBar customSnackBar(String snackBarText){
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Text(
        snackBarText,
        style: GoogleFonts.montserrat(fontSize: 20.0),
      ),
    ),
    duration: Duration(seconds: 1),
  );
}


