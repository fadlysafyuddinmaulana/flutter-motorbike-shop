import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(String name, String imageUrl, double price) {
    final existingItemIndex = _items.indexWhere((item) => item.name == name);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(CartItem(name: name, imageUrl: imageUrl, price: price));
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void incrementItem(String name) {
    final existingItemIndex = _items.indexWhere((item) => item.name == name);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity++;
      notifyListeners();
    }
  }

  void decrementItem(String name) {
    final existingItemIndex = _items.indexWhere((item) => item.name == name);
    if (existingItemIndex >= 0) {
      if (_items[existingItemIndex].quantity > 1) {
        _items[existingItemIndex].quantity--;
        notifyListeners();
      } else {
        removeItem(name);
      }
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in _items) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }
}
