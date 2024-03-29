import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenCard extends StatelessWidget {
  final IconData cardIcon;
  final String title;
  final double fontSize;
  final AssetImage myImage;
  final Function onTap;
  const HomeScreenCard(
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
        height: MediaQuery.of(context).size.height/4,
        width: MediaQuery.of(context).size.width/2.5,
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
                            height: MediaQuery.of(context).devicePixelRatio > 2.0 ? 80 : 64,
                            width: MediaQuery.of(context).devicePixelRatio > 2.0 ? 80 : 64,
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
                    textAlign: TextAlign.center,),
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
