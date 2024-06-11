import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorbike_shop/providers/cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final double price;
  final String specsification_1;
  final String specsification_2;
  final String specsification_3;
  final String specsification_4;
  final String specsification_5;
  final String specsification_6;
  final String specsification_7;
  final String specsification_8;
  final String specsification_9;
  final String specsification_10;
  final String specsification_11;
  final String specsification_12;
  final String specsification_13;
  final String specsification_14;
  final String specsification_15;
  final String specsification_16;
  final String specsification_17;
  final String specsification_18;
  final String specsification_19;
  final String specsification_20;
  final String specsification_21;
  final String specsification_22;
  final String specsification_23;
  final String specsification_24;
  final String specsification_25;
  final String specsification_26;
  final String specsification_27;
  final String specsification_28;
  final String specsification_29;
  final String specsification_30;

  ProductDetailScreen({
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.specsification_1,
    required this.specsification_2,
    required this.specsification_3,
    required this.specsification_4,
    required this.specsification_5,
    required this.specsification_6,
    required this.specsification_7,
    required this.specsification_8,
    required this.specsification_9,
    required this.specsification_10,
    required this.specsification_11,
    required this.specsification_12,
    required this.specsification_13,
    required this.specsification_14,
    required this.specsification_15,
    required this.specsification_16,
    required this.specsification_17,
    required this.specsification_18,
    required this.specsification_19,
    required this.specsification_20,
    required this.specsification_21,
    required this.specsification_22,
    required this.specsification_23,
    required this.specsification_24,
    required this.specsification_25,
    required this.specsification_26,
    required this.specsification_27,
    required this.specsification_28,
    required this.specsification_29,
    required this.specsification_30,
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

  void _buyNow() async {
    String message = 'Hello, I would like to buy ${widget.productName}.';
    String url =
        'https://wa.me/whatsappphonenumber/?text=${Uri.encodeFull(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_2, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_3, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_4, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_5, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_6, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_7, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(
                'Body:', // Text for "mesin"
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
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_8, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_9, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_10, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_11, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_12, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_13, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(
                'Rangka dan Kaki-Kaki:', // Text for "mesin"
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
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_14, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_15, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_16, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_17, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_18, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_19, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to top-left
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget
                          .specsification_20, // Replace with your mesin description
                      textAlign: TextAlign.left, // Align text to left
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 80), // Add extra spacing to avoid FAB covering text
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _showAddToCartModal(context);
            },
            label: Text('Add to Cart'),
            icon: Icon(Icons.add_shopping_cart),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _buyNow();
            },
            label: Text('Buy Now'),
            icon: Icon(Icons.shopping_basket),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
