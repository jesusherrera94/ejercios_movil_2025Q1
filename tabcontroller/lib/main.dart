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
      home: DefaultTabController(length: 3, 
      child: Scaffold(
        body: const TabBarView(children: [
          Home(),
          Cart(),
          Profile(),
        ]),
        appBar: AppBar(
          title: const Text("Material 3 TabBar"),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.shopping_cart), text: "Cart"),
            Tab(icon: Icon(Icons.person), text: "Profile"),
          ])
        ),
      )),
    );
  }
}
