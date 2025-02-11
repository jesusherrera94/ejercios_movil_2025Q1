import 'package:flutter/material.dart';
import 'home.dart';
import 'cart.dart';
import 'profile.dart';

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
        automaticallyImplyLeading: false,
      ),
      
      body: TabBarView(children: [
        Home(),
        Cart(),
        Profile()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("=========================================> Click on add");
        },
        child: Icon(Icons.add),
        ),
    ));
  }
  
}