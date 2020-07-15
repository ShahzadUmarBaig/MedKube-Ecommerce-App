import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Screens/products_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Product.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  TextEditingController _textEditingController = TextEditingController();
  List<Product> _list = List<Product>();

  double total = cartList.length == 0 ? 0 : 150;
  int delivery = cartList.length == 0 ? 0 : 150;
  bool isDisabled = true;

  Cart cart = Cart();

  double getTotalAmount() {
    for (var item in cartList) {
      total = total + item.total;
    }
    return total;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    cartList.length == 0 ? isDisabled = true : isDisabled = false;

    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue[600],
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(14),
                child: Badge(
                  badgeColor: Colors.white,
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  badgeContent: Text(
                    cartList.length.toString(),
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                  child: Icon(
                    Icons.list,
                    size: 30,
                  ),
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ProductScreen.id);
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Text(
                  "Cart Summary",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 400,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemExtent: 40,
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  var item = cartList[index];
                  return Stack(
                    alignment: Alignment.center,
                    fit: StackFit.loose,
                    children: [
                      Align(
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              cartList.remove(item);
                              total = total - item.price;
                              if (cartList.length == 0) {
                                delivery = 0;
                                total = 0;
                              }
                            });
                          },
                          disabledColor: Colors.white,
                          splashColor: Colors.blue[600],
                          highlightColor: Colors.blue[600],
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Positioned(
                        child: Text(
                          item.title,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        left: 45,
                      ),
                      Positioned(
                        child: Text(
                          item.price.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        right: 70,
                      ),
                      Positioned(
                        child: Text(
                          item.quantity.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        right: 50,
                      ),
                      Positioned(
                        child: Text(
                          item.total.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        right: 5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ), // The List View in Cart Screen
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue[700]),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              width: double.infinity,
              height: 130,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Delivery",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          delivery.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          total.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: RawMaterialButton(
                child: Text(
                  "Check Out",
                  style: TextStyle(
                      color: isDisabled ? Colors.black26 : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                elevation: 3.0,
                constraints: BoxConstraints.tightFor(
                  height: 60,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                fillColor: isDisabled ? Colors.grey : Color(0xFFECDF54),
                onPressed: isDisabled ? null : () {},
              ),
            ),
          ), // The Bottom Part with Button
        ],
      ),
    );
  }
}
