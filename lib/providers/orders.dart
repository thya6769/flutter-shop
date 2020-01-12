import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';

class OrderItem {
  final double amount;
  final List<CartItem> items;
  final DateTime dateTime;

  OrderItem({this.amount, this.items, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  void addOrders(List<CartItem> cartItems, double total) {
    _items.insert(0,
        OrderItem(amount: total, items: cartItems, dateTime: DateTime.now()));

    notifyListeners();
  }

  int get orderCount => _items.length;
}
