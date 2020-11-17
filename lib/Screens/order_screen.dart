import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/order_item_tile.dart';
import 'package:medkube/Widgets/profile_textfield.dart';
import 'package:medkube/constants.dart';
import 'package:medkube/extras.dart';

class OrderScreen extends StatefulWidget {
  static String id = "order_screen";
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController _orderNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userInfo.isEmpty ? anonymousUserOrders() : normalUserOrders(),
    );
  }

  Widget anonymousUserOrders() {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Track Your Order",
              style: kAlertBoxText,
            ),
          ),
          ProfileTextField(
              controller: _orderNumberController, hint: "Track Order"),
          CustomButton(
            buttonColor: Colors.blue,
            marginVertical: 4.0,
            marginHorizontal: 24.0,
            buttonTextColor: Colors.white,
            buttonText: "Track Your Order",
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Orders",
              style: kAlertBoxText,
            ),
          ),
          Divider(endIndent: 16.0, indent: 16.0),
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                itemBuilder: (context, index) {
                  return OrderItemTile();
                },
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget normalUserOrders() {
    return Container();
  }
}
