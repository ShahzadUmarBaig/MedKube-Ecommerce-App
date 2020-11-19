import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatelessWidget {
  final Function deleteFunction;
  final String price;
  final String productName;
  final int indexValue;
  final Function onChanged;
  final String subTotal;

  const CartCard(
      {Key key,
      this.deleteFunction,
      this.price,
      this.productName,
      this.indexValue,
      this.onChanged,
      this.subTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Container(
        height: 60,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 50,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                ),
                child: RawMaterialButton(
                  onPressed: deleteFunction,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 50,
              child: Container(
                padding: EdgeInsets.only(left: 8.0, top: 3.0, right: 3.0),
                width: 170,
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      productName,
                      style: GoogleFonts.montserrat(fontSize: 18.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Price Rs.$price",
                      style: GoogleFonts.montserrat(
                          color: Colors.black54, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 70,
              top: 15,
              child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 4.0),
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.grey[200],
                  elevation: 2,
                  underline: Container(),
                  value: indexValue,
                  items: List.generate(
                    6,
                    (index) => DropdownMenuItem(
                      child: Text((index + 1).toString()),
                      value: index,
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 50,
                width: 65,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey[200]),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      subTotal,
                      style: GoogleFonts.montserrat(fontSize: 18.0),
                    ),
                    Text("PKR"),
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
