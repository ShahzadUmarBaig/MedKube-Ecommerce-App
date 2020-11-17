import 'package:flutter/material.dart';

import '../constants.dart';

class CheckoutTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const CheckoutTextField({Key key, this.controller, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter $text";
                }
                return null;
              },
              controller: controller,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
              decoration: kCheckOutTextFieldDecoration.copyWith(
                  hintText: text, labelText: text),
            ),
          ),
        ],
      ),
    );
  }
}
