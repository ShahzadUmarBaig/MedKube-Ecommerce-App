import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTiles extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomListTiles({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 36.0,
      ),
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontSize: 20.0),
      ),
    );
  }
}
