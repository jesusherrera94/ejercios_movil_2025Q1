import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {

  final Product product;
  final Function(Product) addToCart;
  ProductItem({super.key, required this.product, required this.addToCart});

  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Row(
        children: [
          Image.network(product.image,
            width: 80,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
          const SizedBox(width: 8,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(product.name,
                style: TextStyle( fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(product.description,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Text("\$ ${product.price}",
                style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold, ),
              ),
              Center(
                child: ElevatedButton(onPressed: () => addToCart(product), child: const Text("Add to cart"),
              ),
              )
            ],
          ))
        ],
      ),
    );
  }
  
}