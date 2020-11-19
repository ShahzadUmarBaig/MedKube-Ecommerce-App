import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  CollectionReference prescriptionOrders =
      FirebaseFirestore.instance.collection('PrescriptionOrders');
  bool isLoading;

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
                              fontSize: 24, color: Colors.black54),
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
                                Reference ref = FirebaseStorage.instance
                                    .ref()
                                    .child('PrescriptionOrders/')
                                    .child('AnonymousOrders/')
                                    .child(orderNumber);
                                await ref.putFile(_image);

                                String imagePath = await ref.getDownloadURL();
                                //  print(imagePath);

                                await prescriptionOrders.doc(orderNumber).set({
                                  'Note': _duration.text,
                                  'Phone': _phoneNumber.text,
                                  'Address': _address.text,
                                  'Status': "In Progress",
                                  'PicPath': imagePath,
                                  "OrderNo": orderNumber,
                                }).then((value) => null);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                print("This is all escaped");
                                Reference ref = FirebaseStorage.instance
                                    .ref()
                                    .child('PrescriptionOrders/')
                                    .child('${userInfo['UID']}/')
                                    .child(orderNumber);
                                await ref.putFile(_image);

                                String imagePath = await ref.getDownloadURL();
                                //  print(imagePath);

                                await prescriptionOrders.doc(orderNumber).set({
                                  'Note': _duration.text,
                                  'Phone': _phoneNumber.text,
                                  'Address': _address.text,
                                  'Status': "In Progress",
                                  'PicPath': imagePath,
                                  "OrderBy": userInfo['UID'],
                                }).then((value) {});
                              }
                            } catch (e) {
                              print(e);
                            }

                            setState(() {
                              isLoading = false;
                              _duration.clear();
                              _image = null;
                              _address.clear();
                              _phoneNumber.clear();
                            });
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
                                "Delivery Charges Will Be Applied",
                                style: kAlertBoxText.copyWith(
                                    color: Colors.grey[300], fontSize: 20.0),
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
