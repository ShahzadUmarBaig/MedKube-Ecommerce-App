import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemTile extends StatelessWidget {
  final Map<String, dynamic> orderDetails;
  CartItemTile({Key key, this.orderDetails}) : super(key: key);

  getColor(orderStatus) {
    if (orderStatus == "Completed") {
      return Colors.green;
    } else if (orderStatus == "In Progress") {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(orderDetails);
    String orderStatus = orderDetails["Status"];
    String price = orderDetails["total"];
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
                width: 0),
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
                    Text(price.toString(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
