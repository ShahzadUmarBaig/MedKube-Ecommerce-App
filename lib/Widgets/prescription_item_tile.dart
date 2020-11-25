import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/pres_order_detail_screen.dart';

class PrescriptionItemTile extends StatelessWidget {
  final Map<String, dynamic> orderDetails;
  PrescriptionItemTile({Key key, this.orderDetails}) : super(key: key);

  getColor(String status) {
    if (status == "In Progress") {
      return Colors.orange;
    } else if (status == "Completed") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  getPrice(price) {
    if (price == null) {
      return "N/A";
    } else {
      return price.toString();
    }
  }

  getPriceColor(price) {
    if (price == null) {
      return Colors.green;
    } else {
      return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(orderDetails);
    final String orderStatus = orderDetails["Status"];
    return Container(
      height: 80,
      child: Card(
        elevation: 4.0,
        child: Row(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Status",
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: Colors.black54)),
                  SizedBox(height: 4.0),
                  Text(orderStatus,
                      style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        color: getColor(orderStatus),
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      color: Colors.grey[300], style: BorderStyle.solid),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrescriptionDetailScreen(
                          orderDetails: orderDetails,
                        ),
                      ),
                    );
                  },
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          orderDetails["OrderType"]
                                  .toString()
                                  .substring(0, 1)
                                  .toUpperCase() +
                              orderDetails["OrderType"].toString().substring(1),
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0, color: Colors.black54)),
                      Text(orderDetails["OrderNo"],
                          style: GoogleFonts.montserrat(
                            fontSize: 14.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("Click For Details",
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0, color: Colors.black54)),
                    ],
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            VerticalDivider(
              endIndent: 12,
              indent: 12,
              color: Colors.black54,
              thickness: 0,
              width: 0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total",
                        style: GoogleFonts.montserrat(
                            fontSize: 14.0, color: Colors.black54)),
                    SizedBox(height: 2.0),
                    Text(getPrice(orderDetails['total']),
                        style: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            color: getPriceColor(orderDetails['total']),
                            fontWeight: FontWeight.w500)),
                    Text("PKR",
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          color: Colors.black54,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
