import 'package:flutter/material.dart';
import 'product_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      children: [
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
        ProductItem(),
      ],
    );
  }
  
}