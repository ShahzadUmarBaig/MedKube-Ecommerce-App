import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const ProfileTextField({Key key, this.hint, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
              decoration: kProfileTextFieldDecoration.copyWith(
                  hintText: hint, labelText: hint),
            ),
          )
        ],
      ),
    );
  }
}
