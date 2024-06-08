import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package

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

  double get totalPrice => _items.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      );

  void addItem(String name, String imageUrl, double price) {
    final existingItemIndex = _items.indexWhere((item) => item.name == name);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(CartItem(name: name, imageUrl: imageUrl, price: price));
    }
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

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter Cart')),
          body: CartScreen(),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProvider.items.length,
            itemBuilder: (context, index) {
              final item = cartProvider.items[index];
              return ListTile(
                leading: Image.network(item.imageUrl),
                title: Text(item.name),
                subtitle:
                    Text('Price: \$${item.price} \nQuantity: ${item.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => cartProvider.decrementItem(item.name),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => cartProvider.incrementItem(item.name),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Total Price: \$${cartProvider.totalPrice}'),
        ),
        ElevatedButton(
          onPressed: () {
            cartProvider.addItem(
              'Motorbike',
              'https://example.com/motorbike.jpg',
              15000.0,
            );
          },
          child: Text('Add Motorbike'),
        ),
      ],
    );
  }
}
