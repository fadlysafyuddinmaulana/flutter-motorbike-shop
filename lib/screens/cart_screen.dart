import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorbike_shop/providers/cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    double totalPrice = cartProvider.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                var item = cartProvider.items[index];
                double itemTotalPrice = item.price * item.quantity;
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.decrementItem(item.name);
                            },
                          ),
                          Text('Quantity: ${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartProvider.incrementItem(item.name);
                            },
                          ),
                        ],
                      ),
                      Text(
                          'Total Price: Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(itemTotalPrice)}'),
                      SizedBox(height: 4),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeItem(item.name);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Total Price: Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(totalPrice)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    _launchWhatsApp(totalPrice);
                  },
                  child: Text('Share via WhatsApp'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp(double totalPrice) async {
    String phoneNumber = '6285326762048'; // Replace with your phone number
    String message =
        'Hello, I would like to buy ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(totalPrice)}';

    String encodedMessage = Uri.encodeComponent(message);
    String whatsappUrl = 'https://wa.me/$phoneNumber?text=$encodedMessage';

    await launch(whatsappUrl);
  }
}
