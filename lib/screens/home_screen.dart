import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:motorbike_shop/screens/product_detail_screen.dart';
import 'package:motorbike_shop/screens/cart_screen.dart';
import 'package:motorbike_shop/screens/product_list.dart'; // Correctly import the product list
import 'package:motorbike_shop/screens/profile_screen.dart'; // Import the profile screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void toggleFavorite(int index) {
    setState(() {
      products[index]['isFavorite'] = !products[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set the app bar background color
        title: Text(
          'Motorbike Shop',
          style: TextStyle(color: Colors.white), // Set the app bar text color
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          IconButton(
            // Add the profile icon
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen()), // Navigate to the profile screen
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: products
                .map((product) => Container(
                      child: Center(
                          child: Image.network(product['image']!,
                              fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          // Album Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Our Bikes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          // Brand Sections
          buildBrandSection('Yamaha'),
          buildBrandSection('Kawasaki'),
          buildBrandSection('Honda'),
          buildBrandSection('Suzuki'),
        ],
      ),
    );
  }

  Widget buildBrandSection(String brand) {
    final brandProducts =
        products.where((product) => product['brand'] == brand).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            brand,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 300, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brandProducts.length,
            itemBuilder: (context, index) {
              final product = brandProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        productName: product['name']!,
                        imageUrl: product['image']!,
                        description: product['description']!,
                        price: product['price'], // Pass the price
                        specsification_1: product['specsification_1'],
                        specsification_2: product['specsification_2'],
                        specsification_3: product['specsification_3'],
                        specsification_4: product['specsification_4'],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8.0),
                  child: Container(
                    width: 200, // Adjust width as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product['image']!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                    '${product['rating']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
