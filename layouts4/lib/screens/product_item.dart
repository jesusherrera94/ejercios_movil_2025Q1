import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
      padding: const EdgeInsets.all(8),
    );
  }
  
}