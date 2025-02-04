import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/cart.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyMenuDrawer(),
    );
  }
}


// ================== drawer ================

class MyMenuDrawer extends StatefulWidget {
  const MyMenuDrawer({super.key});
  @override
  State<MyMenuDrawer> createState() => _MyMenuDrawer();
}

class _MyMenuDrawer extends State<MyMenuDrawer> {

// state
  int _selectedItem = 0;

  // pantallas
  List<Widget> _screens = [
    Home(),
    Cart(),
    Profile()
  ];

  List<String> _names = [
    'Home',
    'Cart',
    'Profile'
  ];

  void _selectScreen (int newScreenIndex) {
    setState(() {
      _selectedItem = newScreenIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedItem],

        appBar: AppBar(
          title:  Text(_names[_selectedItem]),
          leading: Builder(builder: (context) {
            return IconButton(onPressed: () {
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu));
          }),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
                child: Text("My super app"),
              ),
              ListTile(
                title: const Text("Home"),
                selected: _selectedItem == 0,
                onTap: () {
                  // TODO
                  _selectScreen(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Cart"),
                selected: _selectedItem == 1,
                onTap: () {
                  // TODO
                  _selectScreen(1);
                   Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Profile"),
                selected: _selectedItem == 2,
                onTap: () {
                  // TODO
                  _selectScreen(2);
                   Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
  }
  
}