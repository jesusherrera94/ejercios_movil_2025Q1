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
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Row(
        children: [
          Image(image: AssetImage('assets/img/guitar.jpg.auto.webp'),
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
              Text("Gibson SG",
                style: TextStyle( fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna.",
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Text("\$99.99",
                style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold, ),
              ),
              Center(
                child: ElevatedButton(onPressed: () {
                print("item added to cart");
              }, child: const Text("Add to cart"),
              ),
              )
            ],
          ))
        ],
      ),
    );
  }
  
}