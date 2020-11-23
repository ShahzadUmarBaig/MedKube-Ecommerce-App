import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Services/Font_Size.dart';

class LogoWidget extends StatelessWidget {

  final FontSizeObserver fontSizeObserver = FontSizeObserver();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width/4,
            child: Image(
              width: 50,
              height: 50,
              image: AssetImage("images/logo.png"),
            ),
          ),
          Positioned(
            bottom: 24,
            left: MediaQuery.of(context).size.width/2.5,

            child: RichText(
              text: TextSpan(
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: fontSizeObserver.getFontSize(context, "Logo"),
                    fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: 'Med'),
                  TextSpan(
                    text: 'Kube',
                    style: TextStyle(color: Colors.red[600]),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: MediaQuery.of(context).size.width/2.5,
            child:  Text(
              "WHERE HEALTH COMES FIRST",
              style: GoogleFonts.montserrat(fontSize: fontSizeObserver.getFontSize(context, "Tagline") , color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: 50,
            height: 50,
            image: AssetImage("images/logo.png"),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(text: 'Med'),
                    TextSpan(
                      text: 'Kube',
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
              Text(
                "WHERE HEALTH COMES FIRST",
                style: TextStyle(fontSize: 11.5, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    )
 */
