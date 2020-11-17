import 'package:flutter/material.dart';
import 'package:medkube/Services/Cart.dart';

class OrderScreen extends StatefulWidget {
  static String id = "order_screen";
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userInfo.isEmpty ? anonymousUserOrders() : normalUserOrders(),
    );
  }

  Widget anonymousUserOrders() {
    return Container();
  }

  Widget normalUserOrders() {
    return Container();
  }
}
