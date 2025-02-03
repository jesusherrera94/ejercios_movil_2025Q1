import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/cart.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Menu()
    );
  }
}

// ================================== Menu =====================================

class Menu extends StatefulWidget {
  const Menu({super.key});

  
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  int _selectedIndex = 1;

  final  List<Widget> _screens = [
   const Home(),
    const Cart(),
    const Profile()
  ];

  void _selectItem (int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My super app!'),
          leading: Builder(builder: (context) {
          return IconButton(onPressed: () {
            // abre el drawer
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.menu));
        }),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text("Menu header"),
                decoration: BoxDecoration( color: Colors.blue),
              ),
              ListTile(
                title: const Text("Home"),
                selected: _selectedIndex == 1,
                onTap: () {
                  // TODO: actualizar estado
                  _selectItem(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Cart"),
                selected: _selectedIndex == 2,
                onTap: () {
                  // TODO: actualizar estado
                  _selectItem(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Profile"),
                selected: _selectedIndex == 3,
                onTap: () {
                  // TODO: actualizar estado
                  _selectItem(3);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: _screens[_selectedIndex - 1],
      );
  }
  
}
