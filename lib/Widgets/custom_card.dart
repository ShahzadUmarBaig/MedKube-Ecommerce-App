import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final IconData cardIcon;
  final String title;
  final double fontSize;
  final AssetImage myImage;
  final Function onTap;
  const CustomCard(
      {Key key,
      this.onTap,
      this.myImage,
      this.fontSize,
      this.cardIcon,
      this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.0),
        height: 160,
        width: 130,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  child: myImage != null
                      ? Center(
                          child: Image(
                            image: myImage,
                            height: 64,
                            width: 64,
                          ),
                        )
                      : Center(
                          child: Icon(
                            cardIcon,
                            size: 40,
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                          color: Colors.black54, fontSize: fontSize),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
