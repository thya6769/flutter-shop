import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get numberOfItems => items.length;

  double totalPrice() {
    var total = 0.0;

    _items.forEach((key, item) => {total += item.price});

    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, price: price, quantity: 1));
    }

    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id].quantity == 1) {
      _items.remove(id);
    } else {
      _items.update(
          id,
              (existing) =>
              CartItem(
                  id: existing.id,
                  title: existing.title,
                  price: existing.price,
                  quantity: existing.quantity - 1));
    }

    notifyListeners();
  }
}
