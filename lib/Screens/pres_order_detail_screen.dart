import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/checkout_screen.dart';
import 'package:medkube/Services/Font_Size.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/extras.dart';
import 'package:photo_view/photo_view.dart';

import '../constants.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  static String id = "PrescriptionDetailScreen";
  final orderDetails;

  const PrescriptionDetailScreen({Key key, this.orderDetails})
      : super(key: key);

  @override
  _PrescriptionDetailScreenState createState() =>
      _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  FontSizeObserver fontSizeObserver = FontSizeObserver();
  Map<String, dynamic> productsDetails;
  TextEditingController _durationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _durationController.text = widget.orderDetails["Note"];
    _phoneController.text = widget.orderDetails["Phone"];
    _addressController.text = widget.orderDetails["Address"];
  }

  getValue(value) {
    if (value == null) {
      return "Not Decided";
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderDetails['total']);
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 36.0),
                child: Center(
                  child: Text(
                    "Prescription",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
                indent: 16,
                endIndent: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.80,
                margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                child: Center(
                  child:
                      imageContainer(context, widget.orderDetails['PicPath']),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
            ), // The Li
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "Order Details",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
                indent: 16,
                endIndent: 16,
              ),
            ), // st View in Cart Screen
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue[700]),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckOutText(
                      label: "Delivery",
                      value: getValue(widget.orderDetails['delivery']),
                      textStyle:
                          kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Discount",
                      value: getValue(widget.orderDetails['discount']),
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Total",
                      value: getValue(widget.orderDetails['total']),
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Order Date",
                      value: widget.orderDetails['Date'],
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Order Time",
                      value: widget.orderDetails['Time'],
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Order Status",
                      value: widget.orderDetails['Status'],
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Order No",
                      value: widget.orderDetails['OrderNo'],
                      textStyle:
                      kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    "Billing Information",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Colors.white,
                indent: 16,
                endIndent: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OrderDetailTextField(
                      controller: _addressController,
                      text: "Address",
                    ),
                    OrderDetailTextField(
                      controller: _durationController,
                      text: "Apartment",
                    ),
                    OrderDetailTextField(
                      controller: _phoneController,
                      text: "Phone",
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonColor: Colors.yellow,
                buttonText: "Go Back",
                buttonTextColor: Colors.black,
                marginHorizontal: 16.0,
                marginVertical: 8.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageContainer(BuildContext context, imageURL) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ImageScreen(
            url: imageURL,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageURL),
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String url;

  const ImageScreen({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          ),
        ),
      ),
    );
  }
}

class OrderDetailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const OrderDetailTextField({Key key, this.controller, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              enabled: false,
              controller: controller,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              decoration:
                  kCartOrderBilling.copyWith(hintText: text, labelText: text),
            ),
          ),
        ],
      ),
    );
  }
}
