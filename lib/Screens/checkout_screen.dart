import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/cart_screen.dart';
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
                      value: "Delivery",
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Discount",
                      value: "Discount",
                      textStyle: kCheckOutTextStyle),
                  CheckOutText(
                      label: "Total",
                      value: "Total",
                      textStyle: kCheckOutTextStyle.copyWith(fontSize: 24.0)),
                  DiscountRow(
                      onTap: () {}, discountController: discountController),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: GridView.builder(
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              105, //allergies.length > 0 ? 105 : 10,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2.5),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemTag(
                          allergy: "5% OFF",
                          onPressed: () {},
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
