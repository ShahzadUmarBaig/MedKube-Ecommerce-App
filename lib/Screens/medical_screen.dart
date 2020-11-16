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
import 'package:medkube/extras.dart';

import '../Widgets/widgets.dart';

class ProductScreen extends StatefulWidget {
  static const id = "/";
  final customerName;
  final categoryCondition;

  const ProductScreen({Key key, this.customerName, this.categoryCondition})
      : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> _productList = List<Product>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");
  bool isLoaded;

  int cartCount = 0;
  String user = "Customer";

  void populateList() async {
    await products.get().then((value) {
      value.docs.forEach((element) {
        if (widget.categoryCondition == null) {
          _productList.add(Product(
            category: element["category"],
            company: element["company"],
            description: element["description"],
            formula: element["formula"],
            imagePath: element["imagePath"],
            inStock: element["inStock"],
            otc: element["otc"],
            price: element["price"],
            productName: element["productName"],
            type: element["type"],
          ));
        } else if (element["category"] == widget.categoryCondition) {
          _productList.add(Product(
            category: element["category"],
            company: element["company"],
            description: element["description"],
            formula: element["formula"],
            imagePath: element["imagePath"],
            inStock: element["inStock"],
            otc: element["otc"],
            price: element["price"],
            productName: element["productName"],
            type: element["type"],
          ));
        }
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    populateList();
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
                        text: '${widget.customerName}!',
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
                      );
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
                    var item = _productList[index];
                    return GestureDetector(
                      onTap: () {
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
                      },
                      child: Card(
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
                                    item.imagePath,
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
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.productName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      "RS " + item.price.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
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
                                  onPressed: () {
                                    if (cartListItems
                                        .containsKey(item.productName)) {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 4.0),
                                            child: Text(
                                              'Item Already Added',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20.0),
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
                                                vertical: 10.0,
                                                horizontal: 4.0),
                                            child: Text(
                                              'Item Added To Cart',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                      setState(
                                        () {
                                          cartListItems[item.productName] = {
                                            "quantity": 1,
                                            "price": item.price,
                                            "total": item.price * 1,
                                          };
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _productList.length,
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
    // TODO: implement buildSuggestions
    return ListView(
      children: [
        Text(query),
        Text(query),
        Text(query),
      ],
    );
  }
}
