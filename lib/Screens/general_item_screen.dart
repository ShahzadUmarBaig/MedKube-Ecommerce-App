import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Screens/detail_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Product.dart';
import 'package:medkube/Services/user_info.dart';
import 'package:medkube/Widgets/shop_card.dart';
import 'package:medkube/extras.dart';

import '../Widgets/widgets.dart';

class GeneralItemScreen extends StatefulWidget {
  static const id = "GeneralScreen";
  final categoryCondition;

  const GeneralItemScreen({Key key, this.categoryCondition}) : super(key: key);

  @override
  _GeneralItemScreenState createState() => _GeneralItemScreenState();
}

class _GeneralItemScreenState extends State<GeneralItemScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");
  bool isLoaded;
  int cartCount = 0;
  String userName;

  void populateList() async {
    await products.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if (element["category"] == "general") {
            generalProductList[element.id] = element.data();

            generalProductKeys.add(element.id);
          }
        });
      });
    });
  }

  String getLabel() {
    if (userInfo.isNotEmpty) {
      userName = userInfo["firstName"] + " " + userInfo["lastName"];
      return userName;
    } else {
      userName = "New Customer";
      return userName;
    }
  }

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    populateList();
  }

  void openDetailScreen(context, item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailScreen(
            item: item,
          );
        },
      ),
    );
  }

  Widget snackBarContent(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Text(
        text,
        style: GoogleFonts.montserrat(fontSize: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.grey[50],
                leading: Container(
                  padding: EdgeInsets.all(8),
                  child: Hero(
                    tag: "ProfPic",
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProfileScreen.id);
                        },
                      ),
                      backgroundImage: AssetImage("images/user.png"),
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    children: [
                      TextSpan(text: 'Hi, '),
                      TextSpan(
                        text: getLabel(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Badge(
                      animationType: BadgeAnimationType.fade,
                      badgeContent: Text(
                        cartListItems.keys.toList().length.toString(),
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      padding: EdgeInsets.all(6),
                      badgeColor: Colors.white,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: ProductSearch(),
                      ).then((value) {
                        generalProductList.forEach((key, keyValue) {
                          if (keyValue['productName'] == value.productName) {
                            openDetailScreen(context, generalProductList[key]);
                          }
                        });
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Search For Medicine",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeading(heading: "Popular"),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.filter_list),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var element = generalProductList[generalProductKeys[index]];

                    return GestureDetector(
                      onTap: () {
                        openDetailScreen(context, element);
                      },
                      child: ShopCard(
                        imagePath: element["imagePath"],
                        price: element["price"].toString(),
                        productName: element["productName"],
                        onPressed: () {
                          if (cartListItems
                              .containsKey(element["productName"])) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                content: snackBarContent('Item Already Added'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                content: snackBarContent("Item Added To Cart"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            setState(
                              () {
                                cartListItems[element["productName"]] = {
                                  "productName": element["productName"],
                                  "quantity": 1,
                                  "price": element["price"],
                                  "total": element["price"] * 1,
                                };
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                  childCount: generalProductList.keys.toList().length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductSearch extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> products = List<Product>();

    generalProductList.values.forEach((element) {
      products.add(Product(
        productName: element['productName'],
        price: element['price'],
      ));
    });

    final productSearch = products.where((element) =>
        element.productName.toLowerCase().contains(query.toLowerCase()));

    return ListView(
      children: query != ""
          ? productSearch
              .map<Widget>(
                (e) => ListTile(
                  title: Text(
                    e.productName,
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                  trailing: Text('PKR.' + e.price.toString(),
                      style: GoogleFonts.montserrat(fontSize: 18)),
                  onTap: () {
                    close(context, e);
                  },
                ),
              )
              .toList()
          : [],
    );
  }
}
