import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'home.dart';
import 'cart.dart';
import 'profile.dart';


class MyBottomNavigationBar extends StatefulWidget {

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBar();

}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {
  // state
  int _selectedItem = 0;
  int _notificationsCounter = 0;


late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // widges
  final List<Widget> _screens = [
    Home(),
    Cart(),
    Profile()
  ];


@override
  void initState() {
    super.initState();
    loadNotificationsConfigs();
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



  void _selectedScreen (int newSelectedItem) {
    setState(() {
      _selectedItem = newSelectedItem;
    });
  }

  Widget? _conditionalFloatingButton() {
    if (_selectedItem == 0) {
      return FloatingActionButton(
        onPressed: () {
          _showNotification(title: 'New product', body: 'Check out our new products', subTitle: 'New products available');
        },
        child: Icon(Icons.add),
        );
    }
    return null;
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.pushNamed(context, 'search');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab app"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {
            _navigateToSearch(context);
          }, icon: Icon(Icons.search))
        ],
      ),
      body: _screens[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(items: 
        [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: _selectedItem,
        selectedItemColor: Colors.amber[800],
        onTap: _selectedScreen,
      ),
      floatingActionButton: _conditionalFloatingButton(),
    );
  }
  
}
