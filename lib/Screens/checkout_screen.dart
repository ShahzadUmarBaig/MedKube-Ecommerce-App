import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Order_Code.dart';
import 'package:medkube/Services/Promos.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/add_button.dart';
import 'package:medkube/Widgets/checkout_textfield.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/item_tag.dart';
import 'package:medkube/constants.dart';
import 'package:medkube/extras.dart';

class CheckOutScreen extends StatefulWidget {
  static String id = "screen_id";

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController discountController = TextEditingController();
  double discountPercentage;
  double discountValue;
  double total;
  double delivery;
  List<String> cartItemKeys;
  List<String> promoApplied = [];
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  CollectionReference cartOrders =
      FirebaseFirestore.instance.collection('CartOrders');

  @override
  void initState() {
    super.initState();
    _firstNameController.text = userInfo["firstName"];
    _lastNameController.text = userInfo["lastName"];
    _apartmentController.text = userInfo["Apartment"];
    _phoneController.text = userInfo["Phone"];
    _countryController.text = userInfo["Country"];
    _cityController.text = userInfo["City"];
    _addressController.text = userInfo["Address"];
    discountPercentage = 0.0;
    delivery = 100.0;
    discountValue = 0.0;
    cartItemKeys = cartListItems.keys.toList();
    _countryController.text = "Pakistan";
    _cityController.text = "Karachi";
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
      total = total + cartListItems[element]["total"];
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
        key: _scaffoldKey,
        body: Container(
          height: double.infinity,
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Form(
                key: _formKey,
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
                        value: (getTotal() + delivery - discountValue)
                            .toStringAsFixed(2),
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
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          "Delivery Details",
                          style: kAlertBoxText,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter First Name";
                                }
                                return null;
                              },
                              controller: _firstNameController,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: kCheckOutTextFieldDecoration.copyWith(
                                  hintText: "First Name",
                                  labelText: "First Name"),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter Last Name";
                                }
                                return null;
                              },
                              controller: _lastNameController,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: kCheckOutTextFieldDecoration.copyWith(
                                  hintText: "Last Name",
                                  labelText: "Last Name"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextFormField(
                              controller: _apartmentController,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: kCheckOutTextFieldDecoration.copyWith(
                                  hintText: "Apartment No (Optional)",
                                  labelText: "Apartment No (Optional)"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CheckoutTextField(
                        controller: _phoneController, text: "Phone"),
                    CheckoutTextField(
                        controller: _countryController, text: "Country"),
                    CheckoutTextField(
                        controller: _cityController, text: "City"),
                    CheckoutTextField(
                        controller: _addressController, text: "Address"),
                    CustomButton(
                      buttonColor: Colors.blue,
                      buttonText: "Order",
                      buttonTextColor: Colors.white,
                      marginHorizontal: 16.0,
                      marginVertical: 4.0,
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          String orderNumber =
                              OrderNumberGenerator().getRandomString(10);
                          try {
                            if (userInfo.isEmpty) {
                              await cartOrders.doc(orderNumber).set({
                                // 'Note': _duration.text,
                                // 'Phone': _phoneNumber.text,
                                // 'Address': _address.text,
                                // 'Status': "In Progress",
                                // 'PicPath': imagePath,
                              }).then((value) => null);
                            } else {}
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.black.withOpacity(0.4),
                            size: 24.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "For Online Payment Contact On Whatsapp",
                            style: kAlertBoxText.copyWith(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 17.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
