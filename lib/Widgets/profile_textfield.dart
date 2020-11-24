import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool enabled;

  const ProfileTextField({Key key, this.hint, this.controller, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              enabled: enabled,
              controller: controller,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
              decoration: kProfileTextFieldDecoration.copyWith(
                  hintText: hint, labelText: hint),
            ),
          )
        ],
      ),
    );
  }
}
