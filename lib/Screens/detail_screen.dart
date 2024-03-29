import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Services/Cart.dart';

class DetailScreen extends StatefulWidget {
  static String id = "DetailScreen";
  final Map<String, dynamic> item;
  DetailScreen({this.item});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> item;
  bool favorite = false;
  bool stock = false;
  int quantity = 01;
  double totalPrice;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    totalPrice = item['price'];
  }

  increaseQuantity() {
    if (quantity < 6) {
      setState(() {
        quantity++;
        getPrice();
      });
    }
  }

  decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        getPrice();
      });
    }
  }

  double getPrice() {
    totalPrice = item['price'] * quantity;
    return totalPrice.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    print(item);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(item['imagePath']),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        item['productName'],
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        item['formula'],
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Text(
                          item['description'],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: increaseQuantity,
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 20,
                              ),
                              minWidth: 0,
                              color: Colors.white,
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: decreaseQuantity,
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              ),
                              minWidth: 0,
                              color: Colors.white,
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "PKR." + totalPrice.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 8),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.truckMoving,
                            color: Colors.grey[300],
                            size: 22,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Standard Delivery Charges Applied",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                favorite = !favorite;
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: favorite == false
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.blueAccent,
                                      size: 25,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.blueAccent,
                                      size: 25,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: RawMaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        fillColor: Colors.blueAccent,
                        onPressed: () {
                          if (cartListItems.containsKey(item['productName'])) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 4.0),
                                  child: Text(
                                    'Item Already Added',
                                    style:
                                        GoogleFonts.montserrat(fontSize: 20.0),
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 4.0),
                                  child: Text(
                                    'Item Added To Cart',
                                    style:
                                        GoogleFonts.montserrat(fontSize: 20.0),
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            setState(
                              () {
                                cartListItems[item['productName']] = {
                                  "quantity": quantity,
                                  "price": item['price'],
                                  "total": totalPrice,
                                };
                                print(cartListItems);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
