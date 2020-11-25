import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/checkout_screen.dart';
import 'package:medkube/Services/Font_Size.dart';
import 'package:medkube/Widgets/custom_button.dart';
import 'package:medkube/extras.dart';

import '../constants.dart';

class OrderDetailScreen extends StatefulWidget {
  static String id = "OrderDetailScreen";
  final orderDetails;

  const OrderDetailScreen({Key key, this.orderDetails}) : super(key: key);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  FontSizeObserver fontSizeObserver = FontSizeObserver();
  Map<String, dynamic> productsDetails;
  List<String> productKeys = List<String>();

  @override
  void initState() {
    super.initState();
    productsDetails = widget.orderDetails['items'];
    productKeys = productsDetails.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Order Items",
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.5,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: productsDetails.keys.toList().length,
                  itemBuilder: (context, index) {
                    var element = productsDetails[productKeys[index]];
                    return Card(
                      child: Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  element['productName'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontSizeObserver.getFontSize(
                                        context, "OrderDetailProduct"),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'x' + element['quantity'].toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontSizeObserver.getFontSize(
                                        context, "OrderDetailProduct"),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  element['total'].toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontSizeObserver.getFontSize(
                                        context, "OrderDetailProduct"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                      value: widget.orderDetails['delivery'].toString(),
                      textStyle:
                          kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Discount",
                      value: widget.orderDetails['discount'].toString(),
                      textStyle:
                          kCheckOutTextStyle.copyWith(color: Colors.white),
                    ),
                    CheckOutText(
                      label: "Total",
                      value: widget.orderDetails['total'].toString(),
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
                      value: "In Progress",
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
            ), ////
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomNameRow(),
                    Text(widget.orderDetails['Address'],
                        style:
                        kCheckOutTextStyle.copyWith(color: Colors.white)),
                    Text(
                        widget.orderDetails['Apartment'] == ""
                            ? "Apartment"
                            : widget.orderDetails['Apartment'],
                        style:
                        kCheckOutTextStyle.copyWith(color: Colors.white)),
                    Text(widget.orderDetails['Country'],
                        style:
                        kCheckOutTextStyle.copyWith(color: Colors.white)),
                    Text(widget.orderDetails['City'],
                        style:
                        kCheckOutTextStyle.copyWith(color: Colors.white)),
                    Text(widget.orderDetails['Phone'],
                        style:
                        kCheckOutTextStyle.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomButton(
                onTap: () {},
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
}

class CustomNameRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: false,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              decoration: kCartOrderBilling.copyWith(
                hintText: "First Name",
                labelText: "First Name",
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              enabled: false,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              decoration: kCartOrderBilling.copyWith(
                  hintText: "Last Name", labelText: "Last Name"),
            ),
          ),
        ],
      ),
    );
  }
}
