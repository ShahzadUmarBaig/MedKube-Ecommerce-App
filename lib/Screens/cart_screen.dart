import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  static String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isDisabled = true;
  int selectedItem = 0;
  Cart cart = Cart();
  List cartItemNames;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartList.length == 0 ? isDisabled = true : isDisabled = false;
    // print(Cart().cartListItems.entries);
    cartItemNames = cartListItems.keys.toList();
    print(cartListItems);
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue[600],
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text(
              "Cart Summary",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            centerTitle: true,
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.75,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: cartItemNames.length,
                itemBuilder: (context, index) {
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
                                onPressed: () {
                                  setState(() {
                                    cartListItems.remove(cartItemNames[index]);
                                  });
                                },
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
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 3.0, right: 3.0),
                              width: 170,
                              height: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    cartItemNames[index],
                                    style:
                                        GoogleFonts.montserrat(fontSize: 18.0),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Price Rs.${cartListItems[cartItemNames[index]]["price"]}",
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: Colors.grey[200],
                                elevation: 2,
                                underline: Container(),
                                value: cartListItems[cartItemNames[index]]
                                        ["quantity"] -
                                    1,
                                items: List.generate(
                                  6,
                                  (index) => DropdownMenuItem(
                                    child: Text((index + 1).toString()),
                                    value: index,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    cartListItems[cartItemNames[index]]
                                        ["quantity"] = value + 1;

                                    cartListItems[cartItemNames[index]]
                                            ["total"] =
                                        cartListItems[cartItemNames[index]]
                                                ["quantity"] *
                                            cartListItems[cartItemNames[index]]
                                                ["price"];
                                  });
                                },
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
                                      style: BorderStyle.solid,
                                      color: Colors.grey[200]),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cartListItems[cartItemNames[index]]["total"]
                                        .toString(),
                                    style:
                                        GoogleFonts.montserrat(fontSize: 18.0),
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
                },
              ),
            ),
          ), // The List View in Cart Screen
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue[700]),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
              width: double.infinity,
              height: 80,
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
                          "100",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          "100 RS",
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
              marginHorizontal: 12.0,
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
