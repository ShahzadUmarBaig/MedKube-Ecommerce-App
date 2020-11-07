import 'package:flutter/material.dart';
import 'package:medkube/Widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  static String id = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue[600],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Image(
                    image: AssetImage("images/logo.png"),
                    height: 64,
                    width: 64,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  myImage: AssetImage("images/grocery.png"),
                  title: "General",
                  fontSize: 20,
                ),
                CustomCard(
                  myImage: AssetImage("images/medicine.png"),
                  title: "Medicines",
                  fontSize: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  title: "   Medical \nEquipment",
                  fontSize: 16,
                  myImage: AssetImage("images/Equipment.png"),
                ),
                CustomCard(
                  myImage: AssetImage("images/login.png"),
                  title: "Login",
                  fontSize: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
