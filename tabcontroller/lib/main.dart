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
      home: MyTabController()
    );
  }
}


// ================= tab controller widget =======================================================

class MyTabController extends StatefulWidget {

  @override
  State<MyTabController> createState() =>  _MyTabController();

}


class _MyTabController extends State<MyTabController> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, 
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(tabs: 
        [
          Tab(icon: Icon(Icons.home), text: "Home"),
          Tab(icon: Icon(Icons.shopping_cart), text: "Cart"),
          Tab(icon: Icon(Icons.person), text: "Profile"),
        ]),
      ),
      body: TabBarView(children: [
        Home(),
        Cart(),
        Profile()
      ]),
    ));
  }
  
}