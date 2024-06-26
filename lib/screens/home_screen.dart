import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:motorbike_shop/screens/product_detail_screen.dart';
import 'package:motorbike_shop/screens/cart_screen.dart';
import 'package:motorbike_shop/screens/product_list.dart';
import 'package:motorbike_shop/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> slide = [
    {
      'image':
          'https://awsimages.detik.net.id/community/media/visual/2023/04/26/kembaran-yamaha-soul-gt-meluncur-di-brazil-1.png?w=1200'
    },
    {
      'image':
          'https://imgcdn.oto.com/large/gallery/exterior/84/2720/yamaha-grand-filano-hybrid-connected-slant-front-view-full-image-247658.jpg'
    },
    {
      'image':
          'https://images.tokopedia.net/img/cache/700/OJWluG/2022/8/2/3056ca82-72ae-485b-8bec-a7726752878d.jpg?ect=4g'
    },
    // Add more image URLs as needed
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
            items: slide
                .map((slideItem) => Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            slideItem['image']!,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ),
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
          buildBrandSection('Honda'),
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
                        price: product['price'],
                        specsification_1: product['specsification_1'],
                        specsification_2: product['specsification_2'],
                        specsification_3: product['specsification_3'],
                        specsification_4: product['specsification_4'],
                        specsification_5: product['specsification_5'],
                        specsification_6: product['specsification_6'],
                        specsification_7: product['specsification_7'],
                        specsification_8: product['specsification_8'],
                        specsification_9: product['specsification_9'],
                        specsification_10: product['specsification_10'],
                        specsification_11: product['specsification_11'],
                        specsification_12: product['specsification_12'],
                        specsification_13: product['specsification_13'],
                        specsification_14: product['specsification_14'],
                        specsification_15: product['specsification_15'],
                        specsification_16: product['specsification_16'],
                        specsification_17: product['specsification_17'],
                        specsification_18: product['specsification_18'],
                        specsification_19: product['specsification_19'],
                        specsification_20: product['specsification_20'],
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
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.network(
                            product['image']!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
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
                                formatCurrency(product['price']
                                    .toDouble()), // Convert price to double
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

  String formatCurrency(double amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(amount);
  }
}
