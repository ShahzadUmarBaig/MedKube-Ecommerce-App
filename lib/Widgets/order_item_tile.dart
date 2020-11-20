import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderItemTile extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  const OrderItemTile({Key key, this.orderDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        elevation: 4.0,
        child: Row(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Status",
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: Colors.black54)),
                  SizedBox(height: 4.0),
                  Text("Completed",
                      style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        color: Colors.green,
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
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(),
                  onPressed: () {},
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
                      Text(orderDetails["Status"],
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0, color: Colors.black54)),
                      Text("Click For Details",
                          style: GoogleFonts.montserrat(
                              fontSize: 14.0, color: Colors.black54)),
                    ],
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total",
                      style: GoogleFonts.montserrat(
                          fontSize: 14.0, color: Colors.black54)),
                  SizedBox(height: 2.0),
                  Text("100.00",
                      style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500)),
                  Text("PKR",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: Colors.grey[300], style: BorderStyle.solid),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
