import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Order_Code.dart';
import 'package:medkube/Services/Promos.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/add_button.dart';
import 'package:medkube/Widgets/checkout_textfield.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/Widgets/item_tag.dart';
import 'package:medkube/Widgets/widgets.dart';
import 'package:medkube/constants.dart';
import 'package:medkube/extras.dart';

import 'home_screen.dart';

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
  CollectionReference _orders = FirebaseFirestore.instance.collection('Orders');
  double screenHeight;
  double screenWidth;
  CollectionReference promos = FirebaseFirestore.instance.collection('Promos');

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
    getPromos();
  }

  Future<void> getPromos() async {
    await promos.get().then(
          (value) => value.docs.forEach(
            (element) {
              if (element.data()['isActive'] == true) {
                promoAvailable[element.data()['promoTitle']] = element.data();
                print(promoAvailable);
              }
            },
          ),
        );
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

  double getFontSize() {
    if (screenHeight < 1280 && screenWidth < 720) {
      return 18;
    } else {
      return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
                        value: getDiscount().toStringAsFixed(2),
                        textStyle: kCheckOutTextStyle),
                    CheckOutText(
                        label: "Total",
                        value: (getTotal() + delivery - discountValue)
                            .toStringAsFixed(2),
                        textStyle: kCheckOutTextStyle.copyWith(fontSize: 24.0)),
                    DiscountRow(
                        validator: (value) {},
                        onTap: () {
                          if (promoAvailable.keys
                              .toList()
                              .contains(discountController.text) &&
                              !promoApplied.contains(discountController.text)) {
                            promoApplied.add(discountController.text);
                            discountController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {});
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                                customSnackBar('Promo Not Available', 2));
                          }
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
                            ["promoValue"],
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
                        controller: _phoneController,
                        text: "Phone",
                        textInputType: TextInputType.number),
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
                              await _orders.doc(orderNumber).set(
                                {
                                  "OrderType": "cart",
                                  "OrderNo": orderNumber,
                                  "Address": _addressController.text,
                                  "Apartment": _apartmentController.text,
                                  "City": _cityController.text,
                                  "Country": _countryController.text,
                                  "Phone": _phoneController.text,
                                  "firstName": _firstNameController.text,
                                  "lastName": _lastNameController.text,
                                  "items": cartListItems,
                                  "total":
                                  (getTotal() + delivery - discountValue)
                                      .toStringAsFixed(2),
                                  "discount": discountValue,
                                  "promoApplied": promoApplied,
                                  "delivery": delivery,
                                  "Status": "In Progress",
                                },
                              ).then(
                                (value) {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (BuildContext buildContext,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return Dialog(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          color: Colors.white,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  child: Container(
                                                      height: 10,
                                                      color: Colors.blue)),
                                              Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4.5,
                                                child: Text(
                                                  "Your Order No",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20.0,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SelectableText(
                                                  orderNumber,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 28.0,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                                child: Text(
                                                  "You'll Need This To Track Your Order",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.0,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 10,
                                                      color: Colors.blue)),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      cartListItems.clear();
                                      cartItemKeys.clear();

                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.id);
                                    },
                                  );
                                },
                              );
                            } else {
                              await _orders.doc(orderNumber).set({
                                "OrderType": "cart",
                                "OrderNo": orderNumber,
                                "UID": userInfo['UID'],
                                "Address": _addressController.text,
                                "Apartment": _apartmentController.text,
                                "City": _cityController.text,
                                "Country": _countryController.text,
                                "Phone": _phoneController.text,
                                "firstName": _firstNameController.text,
                                "lastName": _lastNameController.text,
                                "items": cartListItems,
                                "total": (getTotal() + delivery - discountValue)
                                    .toStringAsFixed(2),
                                "discount": discountValue,
                                "promoApplied": promoApplied,
                                "delivery": delivery,
                                "Status": "In Progress",
                              }).then(
                                (value) {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (BuildContext buildContext,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return Dialog(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          color: Colors.white,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  child: Container(
                                                      height: 10,
                                                      color: Colors.blue)),
                                              Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4.5,
                                                child: Text(
                                                  "Your Order No",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20.0,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SelectableText(
                                                  orderNumber,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 28.0,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                                child: Text(
                                                  "You'll Need This To Track Your Order",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.0,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 10,
                                                      color: Colors.blue)),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      cartListItems.clear();
                                      cartItemKeys.clear();

                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.id);
                                    },
                                  );
                                },
                              );
                            }
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
                            "Whatsapp For Online Payment",
                            style: kAlertBoxText.copyWith(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: getFontSize()),
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
  final Function validator;

  const DiscountRow(
      {Key key, this.onTap, this.discountController, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: TextFormField(
              validator: validator,
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
