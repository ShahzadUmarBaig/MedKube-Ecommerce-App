import 'package:medkube/Services/Product.dart';

List<Cart> cartList = List<Cart>();

Map<String, dynamic> cartListItems = {
  // "Burnol": {
  //   "quantity": 1,
  //   "price": 32.5,
  //   "total": 32.5,
  // },
};

List<Product> cartListChecker = List<Product>();

class Cart {
  String title;
  double price;
  int quantity;
  double total;

  Cart({this.title, this.total, this.price, this.quantity});
}
