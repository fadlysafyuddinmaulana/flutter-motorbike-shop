import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorbike_shop/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final double price;
  final String specsification_1; // Add specification parameter

  ProductDetailScreen({
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.specsification_1, // Add specification parameter
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

  void _showAddToCartModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                        widget.imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.productName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '\$${widget.price}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setModalState(() {
                                      if (_quantity > 1) _quantity--;
                                    });
                                  },
                                ),
                                Text(
                                  _quantity.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setModalState(() {
                                      _quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Stretch the button to full width
                    child: ElevatedButton(
                      onPressed: () {
                        for (int i = 0; i < _quantity; i++) {
                          Provider.of<CartProvider>(context, listen: false)
                              .addItem(
                            widget.productName,
                            widget.imageUrl,
                            widget.price, // Pass the price
                          );
                        }
                        Navigator.pop(context); // Close the modal
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart')),
                        );
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to left
            children: <Widget>[
              Image.network(
                widget.imageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                widget.productName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '\$${widget.price}', // Display price below the title
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.description,
                textAlign: TextAlign.left, // Align text to left
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10), // Add spacing
              Text(
                'Mesin:', // Text for "mesin"
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  Text(
                    'Tipe:', // Text for "mesin"
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_1, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddToCartModal(context);
        },
        label: Text('Add to Cart'),
        icon: Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
