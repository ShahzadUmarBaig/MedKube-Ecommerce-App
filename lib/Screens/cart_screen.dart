import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Product.dart';
import 'package:medkube/Widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  TextEditingController _textEditingController = TextEditingController();
  List<Product> _list = List<Product>();

  double itemTotal = cartList.length == 0 ? 0 : 150;
  int delivery = cartList.length == 0 ? 0 : 150;
  bool isDisabled = true;

  Cart cart = Cart();

  String getTotal() {
    itemTotal = 0.00;
    for (var item in cartList) {
      itemTotal = item.total + itemTotal;
    }
    return itemTotal.toString();
  }

  @override
  void initState() {
    super.initState();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    cartList.length == 0 ? isDisabled = true : isDisabled = false;
    getTotal();
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
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 400,

              //TODO Cart Item Card Starts Here
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  var item = cartList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              child: Center(
                                  child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        //   IconButton(
                        //     icon: Icon(
                        //       Icons.remove_circle,
                        //       color: Colors.red,
                        //     ),
                        //     onPressed: () {
                        //       setState(() {
                        //         cartList.remove(item);
                        //         itemTotal = itemTotal - item.total;
                        //         if (cartList.length == 0) {
                        //           delivery = 0;
                        //           itemTotal = 0;
                        //         }
                        //       });
                        //     },
                        //   ),
                        // ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              item.title,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                item.quantity++;
                                item.total = item.quantity * item.price;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Text(
                            item.quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              if (item.quantity != 1) {
                                setState(() {
                                  item.quantity--;
                                  item.total = item.quantity * item.price;
                                });
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (item.price * item.quantity).toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
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
                          "Sub Total",
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
                          getTotal(),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          SliverToBoxAdapter(
            child: CustomButton(
              marginVertical: 10,
              marginHorizontal: 30,
              buttonColor: isDisabled ? Colors.grey : Color(0xFFECDF54),
              buttonText: "Check Out",
              onTap: isDisabled ? null : () {},
              buttonTextColor: isDisabled ? Colors.black26 : Colors.black,
            ),
          ), // The Bottom Part with Button
        ],
      ),
    );
  }
}
