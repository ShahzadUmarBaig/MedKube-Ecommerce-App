import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Services/Order_Code.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/cart_item_tile.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/prescription_item_tile.dart';
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
  CollectionReference _orders = FirebaseFirestore.instance.collection("Orders");
  bool orderTracked;
  String userUID = userInfo["UID"];
  Map<String, dynamic> trackedOrderDetails = {};

  getItemCount() async {
    itemCount = 0;
    await _orders.get().then((value) {
      value.docs.forEach((element) {
        if (element["UID"] == userUID) {
          setState(() {
            orders[element.id] = element.data();

            orderKeys.add(element.id);
          });
        } else {}
      });
    });
    itemCount = orders.keys.length;
    return itemCount;
  }

  double getHeight(BuildContext context) {
    if (orderTracked) {
      return MediaQuery.of(context).size.height * 0.45;
    } else {
      return MediaQuery.of(context).size.height * 0.60;
    }
  }

  @override
  void initState() {
    super.initState();
    itemCount = 0;
    orderTracked = false;
    print("Init Order Statte");
    if (userInfo.isNotEmpty) {
      getItemCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        orders.clear();
        orderKeys.clear();
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
                _orders.doc(trackOrderNo).get().then((value) {
                  if (value.exists) {
                    setState(() {
                      trackedOrderDetails.addAll(value.data());
                      orderTracked = true;
                      FocusScope.of(context).unfocus();
                    });
                  } else {
                    print("Not Found");
                  }
                });
              },
            ),
            orderTracked
                ? Container(
                    height: 80,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Card(
                      elevation: 4.0,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Order No",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.0, color: Colors.black54)),
                                SizedBox(height: 4.0),
                                Text(_orderNumberController.text,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.grey[300],
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(),
                                onPressed: () {},
                                elevation: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        trackedOrderDetails["OrderType"]
                                                .toString()
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            trackedOrderDetails["OrderType"]
                                                .toString()
                                                .substring(1),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.black54)),
                                    Text(trackedOrderDetails["Status"],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.black54)),
                                    Text("Click For Details",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.black54)),
                                  ],
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 70,
                            child: MaterialButton(
                              minWidth: 10,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                trackedOrderDetails.clear();
                                _orderNumberController.clear();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  orderTracked = false;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close),
                                  Text("Hide"),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Colors.grey[300],
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  "Past Orders",
                  style: kAlertBoxText,
                ),
              ),
            ),
            Divider(endIndent: 16.0, indent: 16.0),
            Container(
              height: getHeight(context),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  itemBuilder: (context, index) {
                    if (orders[orderKeys[index]]["OrderType"] == "cart") {
                      return CartItemTile(
                        orderDetails: orders[orderKeys[index]],
                      );
                    } else {
                      return PrescriptionItemTile(
                        orderDetails: orders[orderKeys[index]],
                      );
                    }
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
