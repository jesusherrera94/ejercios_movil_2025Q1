import 'package:flutter/material.dart';
import 'home.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Map<String, dynamic>> _orders = [
    {
      'orderId': 1,
      'date': '2022-10-10',
      'total': 100.0,
      'status': 'Delivered',
      'noOfItems': 2,
    }
  ];

  double _calculateSubTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    double subTotal = _calculateSubTotal();
    double total = subTotal; // Add any additional fees or taxes here if needed

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Total Items: ${cartItems.length}'),
                const SizedBox(height: 8.0),
                Text('Sub-Total: \$${subTotal.toStringAsFixed(2)}'),
                const SizedBox(height: 8.0),
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Placing order...');
                      },
                      child: const Text('Place Order'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(height: 0),
        ...cartItems.map((item) => Card(
          child: ListTile(
            leading: item['image'] != null
                ? Image.network(
                    item['image'],
                    width: 80,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  )
                : CircleAvatar(child: Text(item['title'][0])),
            title: Text(item['title']),
            subtitle: Text(item['subtitle']),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  cartItems.remove(item);
                });
              },
              icon: Icon(Icons.delete),
            ),
          ),
        )),
        Divider(height: 0),
        const SizedBox(height: 8.0),
        Text('Order History', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ..._orders.map((order) => Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ${order['orderId']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Date: ${order['date']}'),
                const SizedBox(height: 4.0),
                Text('Total: \$${order['total']}'),
                const SizedBox(height: 4.0),
                Text(
                  'Status: ${order['status']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: order['status'] == 'Delivered' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text('No. of Items: ${order['noOfItems']}'),
              ],
            ),
          ),
        )),
      ],
    );
  }
}