import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/add_button.dart';
import 'package:medkube/Widgets/item_tag.dart';
import 'package:medkube/constants.dart';
import 'package:medkube/extras.dart';

class CheckOutScreen extends StatefulWidget {
  static String id = "screen_id";

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController discountController = TextEditingController();
  double discountPercentage;
  double discountValue;
  double total;
  double delivery;
  List<String> cartItemKeys;
  List<String> promoApplied = [];

  @override
  void initState() {
    super.initState();
    discountPercentage = 0.0;
    delivery = 100.0;
    discountValue = 0.0;
    cartItemKeys = cartListItems.keys.toList();
    getTotal();
    getDiscount();
  }

  double getDiscount() {
    if (promoApplied.isEmpty) {
      discountPercentage = 0.0;
      discountValue = total * discountPercentage;
    } else {
      promoApplied.forEach((element) {
        discountPercentage = promoAvailable[element]["discount"];
      });

      discountValue = total * discountPercentage;
    }
    return discountValue;
  }

  double getTotal() {
    total = 0.0;
    cartItemKeys.forEach((element) {
      total = total + cartListItems[element]["price"];
    });
    total > 1000 ? delivery = 0.0 : delivery = 100.0;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, CartScreen.id);
        return true;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        "Payment Summary",
                        style: kAlertBoxText,
                      ),
                    ),
                  ),
                  CheckOutText(
                      label: "Delivery",
                      value: total > 1000 ? "0.0" : "100.0",
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Discount",
                      value: getDiscount().toString(),
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Total",
                      value: (getTotal() + delivery - discountValue).toString(),
                      textStyle: kCheckOutTextStyle.copyWith(fontSize: 24.0)),
                  DiscountRow(
                      onTap: () {
                        promoAvailable.forEach((key, value) {
                          if (discountController.text == key &&
                              !promoApplied.contains(key)) {
                            setState(() {
                              promoApplied.add(key);
                              discountController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          }
                        });
                      },
                      discountController: discountController),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: GridView.builder(
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: promoApplied.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              promoApplied.length > 0 ? 105 : 10,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2.5),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemTag(
                          promoTitle: promoAvailable[promoApplied[index]]
                              ["promoTitle"],
                          onPressed: () {
                            setState(() {
                              promoApplied.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Divider(color: Colors.grey, indent: 16.0, endIndent: 16.0),
                  Container(
                    child: Center(
                      child: Text(
                        "Delivery Details",
                        style: kAlertBoxText,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class CheckOutText extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle textStyle;

  CheckOutText({Key key, this.label, this.value, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            style: textStyle,
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(value, style: textStyle)
        ],
      ),
    );
  }
}

class DiscountRow extends StatelessWidget {
  final Function onTap;
  final TextEditingController discountController;
  const DiscountRow({Key key, this.onTap, this.discountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: TextField(
              controller: discountController,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
              decoration: kCheckOutTextFieldDecoration.copyWith(
                  hintText: "Discount Code", labelText: "Discount Code"),
            ),
          ),
          SizedBox(width: 4.0),
          AddButton(
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
