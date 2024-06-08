import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorbike_shop/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final double price; // Add price parameter

  ProductDetailScreen({
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price, // Add price parameter
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              widget.imageUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              widget.productName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                ),
                Text(
                  _quantity.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementQuantity,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                for (int i = 0; i < _quantity; i++) {
                  Provider.of<CartProvider>(context, listen: false).addItem(
                    widget.productName,
                    widget.imageUrl,
                    widget.price, // Pass the price
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to cart')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
