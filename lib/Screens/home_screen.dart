import 'package:flutter/material.dart';
import 'package:medkube/Screens/Firebase/login_screen.dart';
import 'package:medkube/Screens/medical_screen.dart';
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
                CustomCard(
                  myImage: AssetImage("images/grocery.png"),
                  title: "General",
                  fontSize: 20,
                ),
                CustomCard(
                  myImage: AssetImage("images/camera.png"),
                  title: "    Upload \nPrescription",
                  fontSize: 16,
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(),
                    ),
                  ),
                ),
                CustomCard(
                  myImage: AssetImage("images/login.png"),
                  title: "Login",
                  fontSize: 20,
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
