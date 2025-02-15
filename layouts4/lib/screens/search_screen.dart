import 'package:flutter/material.dart';
import 'dart:async';

import '../models/product.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState(); 
}

class _SearchScreenState extends State<SearchScreen> {
  
  // states
  late List<Product> _productsState;
  // values

  final List<Product> _products = [
    Product(id: 0, image: 'assets/img/guitar.jpg.auto.webp', name: 'Gibson SG 2024', description: "Lorem ipsum", price: 99.99, pType: ProductType.INSTRUMENT),
    Product(id: 1, image: 'assets/img/guitar.jpg.auto.webp', name: 'Gibson SG 1970', description: "Lorem ipsum", price: 199.99, pType: ProductType.INSTRUMENT),
    Product(id: 2, image: 'assets/img/pi.webp', name: 'Big muff Pi', description: "Lorem ipsum", price: 99.99, pType: ProductType.EFFECT),
    Product(id: 3, image: 'assets/img/ds1.jpg', name: 'Boss DS1', description: "Lorem ipsum", price: 199.99, pType: ProductType.EFFECT),
    Product(id: 4, image: 'assets/img/rockets.jpg', name: 'Rockets sockets kit', description: "Lorem ipsum", price: 79.99, pType: ProductType.MAINTENANCE),
    Product(id: 5, image: 'assets/img/pi.webp', name: 'BM Pi 1972', description: "Lorem ipsum", price: 299.99, pType: ProductType.EFFECT),
    Product(id: 6, image: 'assets/img/toolkit.jpg', name: 'Repair toolkit', description: "Lorem ipsum", price: 199.99, pType: ProductType.MAINTENANCE),
    Product(id: 7, image: 'assets/img/toolkit.jpg', name:'cheap toolkit', description: "Lorem ipsum", price: 20.99, pType: ProductType.MAINTENANCE),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setProduts(null);
  }

  void _setProduts(ProductType? pType) {
    List<Product> p;
    if (pType != null) {
      p = _products.where((pdt) => pdt.pType == pType).toList();
    } else {
      p = _products;
    }

    setState(() {
      _productsState = p;
    });

  }

  List<Widget> productsListTile () {
    List<Widget> pWidgetTile =[];
    for(final p in _productsState) {
      pWidgetTile.add(_ProductTile(product: p));
      pWidgetTile.add(Divider(height: 0,));
    }
    return pWidgetTile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Item"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                _setProduts(ProductType.INSTRUMENT);
              }, child: const Text("Instruments")),
              ElevatedButton(onPressed: () {
                _setProduts(ProductType.EFFECT);
              }, child: const Text("Effects")),
              ElevatedButton(onPressed: () {
                _setProduts(ProductType.MAINTENANCE);
              }, child: const Text("Maintenance")),
            ],
          ),
          Expanded(
            child: 
          ListView(
            children: [...productsListTile()],
          )
          ),
        ],
      ),
    );
  }
}

// stateless widget

class _ProductTile extends StatelessWidget {

  Product product;

  _ProductTile({
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: Image(image: AssetImage(product.image),
            width: 80,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
            title: Row(children: [
              Text(product.name),
              SizedBox(width: 5,),
              Text("\$ ${product.price}",
                style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold, ),
              ),
            ],),
            subtitle: Text(product.description),
            trailing: IconButton(onPressed: () {
              print("Delete item");
            }, icon: Icon(Icons.shopping_basket)),
          );
  }
}