import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Screens/order_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Services/Product.dart';
import 'package:medkube/Widgets/custom_listTiles.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key, this.userName, this.userEmail, this.onTap})
      : super(key: key);

  final String userName;
  final String userEmail;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    print(generalProductList);
    return Drawer(
      semanticLabel: "Drawer",
      elevation: 16.0,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName, style: TextStyle(fontSize: 20.0)),
            accountEmail: Text(userEmail, style: TextStyle(fontSize: 16.0)),
            currentAccountPicture: CircleAvatar(
              radius: 36.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 34.0,
                  backgroundImage: AssetImage("images/customer1.png")),
            ),
          ),
          CustomListTiles(
            title: "Profile",
            icon: Icons.person_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CartScreen.id);
            },
            leading: Icon(Icons.shopping_cart, size: 34.0),
            title: Text("Cart", style: GoogleFonts.montserrat(fontSize: 20.0)),
            trailing: Container(
              margin: EdgeInsets.only(right: 10),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.grey[200], shape: BoxShape.circle),
              child: Center(
                  child: Text(
                cartListItems.isNotEmpty
                    ? cartListItems.keys.toList().length.toString()
                    : "0",
                style: GoogleFonts.montserrat(fontSize: 16.0),
              )),
            ),
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          CustomListTiles(
            title: "Orders",
            icon: Icons.bookmark_border,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, OrderScreen.id);
            },
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          CustomListTiles(
            title: "Contact Us",
            icon: Icons.call_outlined,
            onTap: () {
              showDialogMenu(context);
            },
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDialogMenu(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          var whatsappUrl =
                              "whatsapp://send?phone=+923125423390";
                          await UrlLauncher.canLaunch(whatsappUrl)
                              ? UrlLauncher.launch(whatsappUrl)
                              : print("Do Something");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.whatsapp, size: 36.0),
                            SizedBox(height: 8.0),
                            Text("Whatsapp",
                                style: GoogleFonts.montserrat(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .devicePixelRatio >
                                        2.0
                                        ? 19.0
                                        : 24.0,
                                    color: Colors.black54))
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      indent: 16,
                      endIndent: 16,
                      color: Colors.black54,
                    ),
                    Expanded(
                      child: MaterialButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          UrlLauncher.launch("tel://+923162821544");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call, size: 36.0),
                            SizedBox(height: 8.0),
                            Text("Phone",
                                style: GoogleFonts.montserrat(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .devicePixelRatio >
                                        2.0
                                        ? 20.0
                                        : 24.0,
                                    color: Colors.black54))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/*
Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,

                  color: Colors.red,
                  onPressed: () async {
                    var whatsappUrl = "whatsapp://send?phone=+923125423390";
                    await UrlLauncher.canLaunch(whatsappUrl)
                        ? UrlLauncher.launch(whatsappUrl)
                        : print("Do Something");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Icon(FontAwesomeIcons.whatsapp, size: 36.0)),
                      Expanded(
                          flex: 3,
                          child: Text("Call On Whatsapp", style: kAlertBoxText))
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    UrlLauncher.launch("tel://+923162821544");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Icon(Icons.call, size: 36.0)),
                      Expanded(
                          flex: 3,
                          child: Text("Call On Phone", style: kAlertBoxText))
                    ],
                  ),
                )
              ],
            )
 */
