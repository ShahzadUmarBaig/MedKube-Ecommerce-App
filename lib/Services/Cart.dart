List<Cart> cartList = List<Cart>();

class Cart {
  String title;
  double price;
  int quantity;
  double total;

  Cart({this.title, this.total, this.price, this.quantity});
}
