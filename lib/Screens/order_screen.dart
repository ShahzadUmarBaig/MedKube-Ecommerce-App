import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Services/Order_Code.dart';
import 'package:medkube/Services/user_info.dart';
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
  int itemCount;
  CollectionReference _cartOrders =
      FirebaseFirestore.instance.collection("CartOrders");

  CollectionReference _prescriptionOrders =
      FirebaseFirestore.instance.collection("PrescriptionOrders");

  getItemCount() async {
    itemCount = 0;
    // print("GetItemCount Method");
    // await _cartOrders.get().then((value) {
    //   value.docs.forEach((element) {
    //     setState(() {
    //       cartOrders[element.id] = element.data();
    //     });
    //   });
    // });
    //
    // await _prescriptionOrders.get().then((value) {
    //   value.docs.forEach((element) {
    //     setState(() {
    //       prescriptionOrders[element.id] = element.data();
    //     });
    //   });
    // });

    itemCount = prescriptionOrders.keys.length + cartOrders.keys.length;

    return itemCount;
  }

  @override
  void initState() {
    super.initState();
    itemCount = 0;
    if (userInfo.isNotEmpty) {
      getItemCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        prescriptionOrders.clear();
        cartOrders.clear();
        return true;
      },
      child: Scaffold(
        body: orderScreen(),
      ),
    );
  }

  Widget orderScreen() {
    return Container(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  "Track Your Order",
                  style: kAlertBoxText,
                ),
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
              onTap: () {
                String trackOrderNo = _orderNumberController.text;
                _cartOrders.doc(trackOrderNo).get().then((value) {
                  if (value.exists) {
                    setState(() {
                      cartOrders.clear();
                      prescriptionOrders.clear();
                      cartOrders[value.id] = value.data();
                      getItemCount();
                    });
                  }
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  "Orders",
                  style: kAlertBoxText,
                ),
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
                  itemCount: itemCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget normalUserOrders() {
    return Container();
  }
}
