import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onPressed;

  const AddButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      child: RawMaterialButton(
        splashColor: Colors.blue[100],
        hoverColor: Colors.blue[100],
        focusColor: Colors.blue[100],
        highlightColor: Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(style: BorderStyle.solid, color: Colors.blue),
        ),
        constraints: BoxConstraints.expand(height: 48, width: 50),
        onPressed: onPressed,
        child: Text(
          "Apply",
          style: TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
