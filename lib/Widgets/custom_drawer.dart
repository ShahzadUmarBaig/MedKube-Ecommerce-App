import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkube/Screens/cart_screen.dart';
import 'package:medkube/Screens/profile_screen.dart';
import 'package:medkube/Services/Cart.dart';
import 'package:medkube/Widgets/custom_listTiles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key, this.userData}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    print(userData);
    return Drawer(
      semanticLabel: "Drawer",
      elevation: 16.0,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text("Regular Customer", style: TextStyle(fontSize: 20.0)),
            accountEmail:
                Text(userData["Email"], style: TextStyle(fontSize: 16.0)),
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
              print(userData);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    completeData: userData,
                  ),
                ),
              );
            },
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, CartScreen.id),
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
                cartList.length.toString(),
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
            onTap: () {},
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
          CustomListTiles(
            title: "Contact Us",
            icon: Icons.call_outlined,
            onTap: () {},
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
          ),
        ],
      ),
    );
  }
}
