import 'package:medkube/Services/Product.dart';

List<Cart> cartList = List<Cart>();

List<Product> cartListChecker = List<Product>();

class Cart {
  String title;
  double price;
  int quantity;
  double total;

  Cart({this.title, this.total, this.price, this.quantity});
}
