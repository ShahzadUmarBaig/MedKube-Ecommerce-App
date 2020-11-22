import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final Function onPressed;
  final String imagePath;
  final String productName;
  final String price;

  const ShopCard(
      {Key key, this.onPressed, this.imagePath, this.productName, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Align(
            child: Container(
              child: AspectRatio(
                aspectRatio: 18 / 12,
                child: Image.network(
                  imagePath,
                  scale: 2,
                ),
              ),
              margin: EdgeInsets.only(top: 16),
            ),
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 15,
                left: 15,
                right: 30
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "RS " + price,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 12,
              ),
              child: RawMaterialButton(
                child: Icon(
                  Icons.add,
                  size: 15,
                ),
                elevation: 3.0,
                constraints: BoxConstraints.tightFor(
                  width: 55,
                  height: 38,
                ),
                shape: CircleBorder(
                  side: BorderSide(style: BorderStyle.solid),
                ),
                //    fillColor: Colors.blueAccent,
                onPressed: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
