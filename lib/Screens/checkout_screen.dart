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
  final subTotal;

  const CheckOutScreen({Key key, this.subTotal}) : super(key: key);
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController discountController = TextEditingController();
  double discount;
  double total;
  double delivery;

  @override
  void initState() {
    super.initState();
    discount = 1.0;
  }

  String getDiscount() {
    if (discount == 1) {
      return "0.0";
    } else {
      return (discount * widget.subTotal).toString();
    }
  }

  String getTotal() {
    if (widget.subTotal > 1000) {
      delivery = 0;
      return {widget.subTotal * discount}.toString();
    } else {
      delivery = 100;
      return (widget.subTotal * (1 - discount) + delivery).toString();
    }
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
                      value: widget.subTotal > 1000 ? "0.0" : "100.0",
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Discount",
                      value: getDiscount(),
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Total",
                      value: getTotal(),
                      textStyle: kCheckOutTextStyle.copyWith(fontSize: 24.0)),
                  DiscountRow(
                      onTap: () {
                        promoAvailable.addAll({
                          "Independence": {
                            "promoTitle": "5% OFF",
                            "discount": 0.05,
                            "isActive": true,
                          },
                        });

                        var allPromo = promoAvailable.keys.toList();
                        setState(() {
                          discount = promoAvailable[allPromo[0]]["discount"];
                        });
                      },
                      discountController: discountController),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: GridView.builder(
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: promoAvailable.keys.toList().length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              promoAvailable.keys.toList().length > 0
                                  ? 105
                                  : 10,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2.5),
                      itemBuilder: (BuildContext context, int index) {
                        var promos = promoAvailable.keys.toList();
                        return ItemTag(
                          promoTitle: promoAvailable[promos[index]]
                              ["promoTitle"],
                          onPressed: () {
                            setState(() {
                              promoAvailable.clear();
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
