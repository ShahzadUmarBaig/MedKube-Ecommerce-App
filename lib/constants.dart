import 'package:flutter/material.dart';

const kElevationConstant = 5.00;

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
