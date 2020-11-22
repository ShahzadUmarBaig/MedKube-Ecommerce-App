import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
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
            bottom: 25,
            left: MediaQuery.of(context).size.width/2.5,

            child: RichText(
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
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width/2.5,
            child:  Text(
              "WHERE HEALTH COMES FIRST",
              style: TextStyle(fontSize: 11.5, color: Colors.white),
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
