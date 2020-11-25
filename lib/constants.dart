import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kElevationConstant = 5.00;

final kBlueColor = 0xff42a5ff;

final TextStyle kCheckOutTextStyle =
    GoogleFonts.montserrat(fontSize: 18.0, color: Colors.black54);

TextStyle kAlertBoxText =
    GoogleFonts.montserrat(fontSize: 24.0, color: Colors.black54);

InputDecoration kInputValidDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  alignLabelWithHint: true,
  //  hintText: "Username",
);

InputDecoration kInputInvalidDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.red),
  ),
  alignLabelWithHint: true,

  //  hintText: "Username",
);

TextStyle kDefaultStyle =
    GoogleFonts.montserrat(color: Colors.black54, fontSize: 16);
TextStyle kLinkStyle = GoogleFonts.montserrat(color: Colors.blue, fontSize: 16);

const kSearchFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none),
  prefixIcon: Icon(
    Icons.search,
  ),
  hintText: 'Search Item',
);

const kSectionHeaderStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, wordSpacing: 3);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

InputDecoration kProfileTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(8.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(color: Color(kBlueColor)),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  fillColor: Colors.white70,
);

InputDecoration kCartOrderBilling = InputDecoration(
  labelStyle: TextStyle(color: Colors.white),
  hintStyle: TextStyle(color: Colors.white),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: const BorderRadius.all(
      const Radius.circular(8.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(color: Colors.white),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide(color: Colors.white),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  fillColor: Colors.white70,
);

TextStyle kProfileTextDecoration = TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

InputDecoration kCheckOutTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.blue[500]),
  labelStyle: TextStyle(color: Colors.blue[500]),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: const BorderRadius.all(
      const Radius.circular(5.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: const BorderRadius.all(
      const Radius.circular(5.0),
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: const BorderRadius.all(
      const Radius.circular(5.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    borderSide: BorderSide(color: Color(kBlueColor)),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  fillColor: Colors.white70,
);
