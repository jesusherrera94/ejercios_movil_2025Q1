import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home.dart';
import '../adapters/db.dart';
import '../adapters/local_storage.dart';



class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Db _db = Db();
   List<Map<String, dynamic>> _orders = [];
  LocalStorage _localStorage = LocalStorage();
  Map<String, dynamic> _user = {};
  int _notificationsCounter = 0;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    loadNotificationsConfigs();
    _db.setListenerToOrder(onOrderReceived: _addOrderToHistory);
  }


  void loadNotificationsConfigs() {
    const androidInitialize =  AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission : false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification({ required String title, required String body, String? subTitle}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channelId',
      'Local Notification',
      channelDescription: 'This is a channel for local notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      subtitle: subTitle,
      threadIdentifier: 'thread_id',
    );
    await flutterLocalNotificationsPlugin.show(
      _notificationsCounter++,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }


  void _loadUserInfo() async {
    final userString = await _localStorage.getUser();
    setState(() {
      _user = jsonDecode(userString);
    });
  }

  void _addOrderToHistory(Map<String, dynamic> order) {
    int index = _orders.indexWhere((existingOrder) => existingOrder['orderId'] == order['orderId']);
      if (index != -1) {
        _orders[index] = order;
        _showNotification(title: 'Order Updated', body: 'Order ${order['orderId']} has been updated');
      } else {
        _orders.add(order);
      }
    setState(() {
    });
  }

  double _calculateSubTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + item['price']);
  }

  Future<void> _placeOrder() async {
    double subTotal = _calculateSubTotal();
    Map<String, dynamic> order = {
      'date': DateTime.now().toString(),
      'total': subTotal,
      'status': 'Pending',
      'noOfItems': cartItems.length,
      'userId': _user['uid'],
    };
    dynamic orderResponse = await _db.saveOrder(order);
    _addOrderToHistory({
      'orderId': orderResponse.id,
      ...orderResponse.data(),
    });
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
                      onPressed: () async {
                        await _placeOrder();
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