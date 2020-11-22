import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/checkout_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/cart_card.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/extras.dart';

import '../constants.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isDisabled = true;
  int selectedItem = 0;
  List cartItemNames;
  double discount;
  double total;
  double screenHeight;
  double screenWidth;

  @override
  void initState() {
    super.initState();
    getTotal();
  }

  double getTotal() {
    total = 0.0;
    cartListItems.forEach((key, value) {
      total = total + value["total"];
    });

    return total;
  }

  double getFontSize(){
    if(screenHeight < 720 && screenWidth < 360){
      return 18;
    } else {
      return 16;
    }
  }

  double getItemScrollHeight(){
    if(MediaQuery.of(context).size.height < 720){
      return 1.75;
    } else if (MediaQuery.of(context).size.height < 1440) {
      return 1.5;

    } else {
      return 1.4;
    }
  }

  @override
  Widget build(BuildContext context) {
    cartItemNames = cartListItems.keys.toList();
    cartListItems.keys.toList().length == 0
        ? isDisabled = true
        : isDisabled = false;

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.blue[600],
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              title: Text(
                "Cart Summary",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.all(14),
                  child: Badge(
                    badgeColor: Colors.white,
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    badgeContent: Text(
                      cartListItems.keys.toList().length.toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: Icon(
                      Icons.list,
                      size: 30,
                    ),
                  ),
                )
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / getItemScrollHeight(),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: cartListItems.length,
                  itemBuilder: (context, index) {
                    var item = cartItemNames[index];
                    return CartCard(
                      deleteFunction: () {
                        setState(() {
                          cartListItems.remove(item);
                          getTotal();
                        });
                      },
                      price: (cartListItems[item]["price"]).toString(),
                      productName: item,
                      fontSize: 16,
                      indexValue: cartListItems[item]["quantity"] - 1,
                      onChanged: (value) {
                        setState(
                          () {
                            cartListItems[item]["quantity"] = value + 1;

                            cartListItems[item]["total"] = cartListItems[item]
                                    ["quantity"] *
                                cartListItems[item]["price"];
                            getTotal();
                          },
                        );
                      },
                      subTotal: cartListItems[cartItemNames[index]]["total"]
                          .toString(),
                    );
                  },
                ),
              ),
            ), // The List View in Cart Screen
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue[700]),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                width: double.infinity,
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Sub Total",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "PKR." + total.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ]),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delivery_dining,
                      color: Colors.black.withOpacity(0.4)),
                  SizedBox(width: 8.0),
                  Text(
                    "delivery will be calculated on next screen",
                    style: kAlertBoxText.copyWith(
                        color: Colors.black.withOpacity(0.4), fontSize: getFontSize()),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: CustomButton(
                marginVertical: 10,
                marginHorizontal: 12.0,
                buttonColor: isDisabled ? Colors.grey : Color(0xFFECDF54),
                buttonText: "Check Out",
                onTap: isDisabled
                    ? null
                    : () => Navigator.pushReplacementNamed(
                        context, CheckOutScreen.id),
                buttonTextColor: isDisabled ? Colors.black26 : Colors.black,
              ),
            ),
            // The Bottom Part with Button
          ],
        ),
      ),
    );
  }
}
