import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medkube/Services/Font_Size.dart';
import 'package:medkube/Services/Order_Code.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/custom_button.dart';

import '../constants.dart';

class PrescriptionScreen extends StatefulWidget {
  static String id = "prescription";
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _address;
  TextEditingController _phoneNumber;
  TextEditingController _duration;
  CollectionReference _orders = FirebaseFirestore.instance.collection('Orders');
  bool isLoading;
  int day;
  int month;
  int year;
  int hour;
  int minute;

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _duration = TextEditingController();
    _address = TextEditingController();
    _phoneNumber = TextEditingController();
    isLoading = false;
  }

  String getDate() {
    day = DateTime.now().day;
    month = DateTime.now().month;
    year = DateTime.now().year;
    return '$day/$month/$year';
  }

  String getTime() {
    hour = DateTime.now().hour;
    minute = DateTime.now().minute;
    if (hour > 12) {
      hour = hour - 12;
      return "$hour:$minute PM";
    } else {
      return "$hour:$minute AM";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        body: isLoading
            ? Container(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SpinKitWave(
                        type: SpinKitWaveType.start,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 8,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Your Order Is Being Placed",
                          style: GoogleFonts.montserrat(
                              fontSize: FontSizeObserver()
                                  .getFontSize(context, "WaitingScreen"),
                              color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: double.infinity,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width * 0.80,
                        margin: EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 24.0, bottom: 8.0),
                        child: Center(
                          child: _image != null
                              ? imageContainer(context)
                              : Center(
                                  child: CustomButton(
                                    buttonColor: Colors.grey[200],
                                    buttonText: "Upload Picture",
                                    buttonTextColor: Colors.black54,
                                    marginHorizontal: 24.0,
                                    onTap: () {
                                      getImage();
                                    },
                                  ),
                                ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 4.0),
                        child: TextFormField(
                          controller: _address,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Address";
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: kProfileTextFieldDecoration.copyWith(
                              hintText: "Address", labelText: "Address"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 4.0),
                        child: TextFormField(
                          controller: _duration,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: kProfileTextFieldDecoration.copyWith(
                              hintText: "Kitnay Din Ki Dawai?",
                              labelText: "Days of medicine"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 4.0),
                        child: TextFormField(
                          controller: _phoneNumber,
                          validator: (value) {
                            if (value.length < 11) {
                              return "Input Correct Number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: kProfileTextFieldDecoration.copyWith(
                              hintText: "03XXXXXXXXX",
                              labelText: "Phone Number"),
                        ),
                      ),
                      CustomButton(
                        onTap: () async {
                          if (_formKey.currentState.validate() &&
                              _image != null) {
                            String orderNumber =
                            OrderNumberGenerator().getRandomString(10);
                            FocusScope.of(context).unfocus();
                            try {
                              if (userInfo.isEmpty) {
                                placeOrderIfUserNotExists(orderNumber);
                              } else {
                                placeOrderIfUserExists(orderNumber);
                              }
                            } catch (e) {
                              print(e);
                            }

                            // String baseName = basename(_image.path);
                            // print(baseName);
                          }
                        },
                        buttonColor: Colors.blueAccent,
                        buttonText: "Place Order",
                        buttonTextColor: Colors.white,
                        marginVertical: 8.0,
                        marginHorizontal: 24.0,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delivery_dining,
                                size: 32.0,
                                color: Colors.grey[300],
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Terms And Conditions Applied",
                                style: kAlertBoxText.copyWith(
                                    color: Colors.grey[300],
                                    fontSize: FontSizeObserver().getFontSize(
                                        context, "PrescriptionLabel")),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> placeOrderIfUserNotExists(orderNumber) async {
    setState(() {
      isLoading = true;
    });
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('PrescriptionOrders/')
        .child('AnonymousOrders/')
        .child(orderNumber);
    await ref.putFile(_image);

    String imagePath = await ref.getDownloadURL();
    //  print(imagePath);

    await _orders.doc(orderNumber).set({
      'OrderType': "prescription",
      'Note': _duration.text,
      'Phone': _phoneNumber.text,
      'Address': _address.text,
      'Status': "In Progress",
      'PicPath': imagePath,
      "OrderNo": orderNumber,
      "UID": FirebaseAuth.instance.currentUser.uid,
      "total": null,
      "discount": null,
      "delivery": null,
      "Date": getDate(),
      "Time": getTime(),
    }).then(
          (value) {
        setState(() {
          isLoading = false;
        });
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
          MaterialLocalizations
              .of(context)
              .modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Dialog(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 10, color: Colors.blue),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Order No",
                            style: GoogleFonts.montserrat(
                                fontSize: FontSizeObserver()
                                    .getFontSize(context, "OrderTicket"),
                                color: Colors.black54),
                          ),
                          SelectableText(
                            orderNumber,
                            style: GoogleFonts.montserrat(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          Text(
                            "You'll Need This To Track Your Order",
                            style: GoogleFonts.montserrat(
                                fontSize: FontSizeObserver()
                                    .getFontSize(context, "OrderTicketInfo"),
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10, color: Colors.blue),
                  ],
                ),
              ),
            );
          },
        ).then(
              (value) {
            setState(() {
              _duration.clear();
              _image = null;
              _address.clear();
              _phoneNumber.clear();
            });
          },
        );
      },
    );
  }

  Future<void> placeOrderIfUserExists(orderNumber) async {
    setState(() {
      isLoading = true;
    });
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('PrescriptionOrders/')
        .child('${userInfo['UID']}/')
        .child(orderNumber);
    await ref.putFile(_image);

    String imagePath = await ref.getDownloadURL();
    //  print(imagePath);

    await _orders.doc(orderNumber).set({
      'OrderType': "prescription",
      'Note': _duration.text,
      'Phone': _phoneNumber.text,
      'Address': _address.text,
      'Status': "In Progress",
      'PicPath': imagePath,
      "OrderNo": orderNumber,
      "UID": userInfo['UID'],
      "total": null,
      "discount": null,
      "delivery": null,
      "Date": getDate(),
      "Time": getTime(),
    }).then(
          (value) {
        setState(() {
          isLoading = false;
        });
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
          MaterialLocalizations
              .of(context)
              .modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Dialog(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 10, color: Colors.blue),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Order No",
                            style: GoogleFonts.montserrat(
                                fontSize: FontSizeObserver()
                                    .getFontSize(context, "OrderTicket"),
                                color: Colors.black54),
                          ),
                          SelectableText(
                            orderNumber,
                            style: GoogleFonts.montserrat(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          Text(
                            "You'll Need This To Track Your Order",
                            style: GoogleFonts.montserrat(
                                fontSize: FontSizeObserver()
                                    .getFontSize(context, "OrderTicketInfo"),
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10, color: Colors.blue),
                  ],
                ),
              ),
            );
          },
        ).then(
              (value) {
            setState(() {
              _duration.clear();
              _image = null;
              _address.clear();
              _phoneNumber.clear();
            });
          },
        );
      },
    );
  }

  Widget imageContainer(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.7), shape: BoxShape.circle),
          child: RawMaterialButton(
            shape: CircleBorder(),
            constraints: BoxConstraints.tightFor(height: 70, width: 70),
            onPressed: () {
              setState(() {
                _image = null;
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        image: DecorationImage(fit: BoxFit.cover, image: FileImage(_image)),
      ),
    );
  }
}
