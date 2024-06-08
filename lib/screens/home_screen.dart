import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:motorbike_shop/screens/product_detail_screen.dart';
import 'package:motorbike_shop/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Motorbike 1',
      'image': 'https://via.placeholder.com/600x400',
      'description':
          'This is the description for Motorbike 1. It is a high-performance motorbike suitable for all terrains.',
      'price': 15000.0,
      'rating': 4.5,
      'isFavorite': false,
      'brand': 'Brand 1',
    },
    {
      'name': 'Motorbike 2',
      'image': 'https://via.placeholder.com/600x400',
      'description':
          'This is the description for Motorbike 2. It is a reliable motorbike with great features.',
      'price': 12000.0,
      'rating': 4.0,
      'isFavorite': false,
      'brand': 'Brand 2',
    },
    {
      'name': 'Motorbike 3',
      'image': 'https://via.placeholder.com/600x400',
      'description':
          'This is the description for Motorbike 3. A top choice for city commuting.',
      'price': 10000.0,
      'rating': 4.2,
      'isFavorite': false,
      'brand': 'Brand 3',
    },
    {
      'name': 'Motorbike 4',
      'image': 'https://via.placeholder.com/600x400',
      'description':
          'This is the description for Motorbike 4. A top choice for city commuting.',
      'price': 11000.0,
      'rating': 4.1,
      'isFavorite': false,
      'brand': 'Brand 4',
    },
  ];

  void toggleFavorite(int index) {
    setState(() {
      products[index]['isFavorite'] = !products[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motorbike Shop'),
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
        ],
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
          buildBrandSection('Brand 1'),
          buildBrandSection('Brand 2'),
          buildBrandSection('Brand 3'),
          buildBrandSection('Brand 4'),
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
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4, // Adjusted aspect ratio
            crossAxisSpacing: 8.0, // Added spacing between grid items
            mainAxisSpacing: 8.0, // Added spacing between grid items
          ),
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
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 200, // Adjust the height as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            product['image']!,
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                product['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                toggleFavorite(index);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(product['name']!),
                      Text('\$${product['price']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text('${product['rating']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
