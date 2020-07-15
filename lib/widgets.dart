import 'package:flutter/material.dart';

import 'constants.dart';

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
