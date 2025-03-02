import 'package:flutter/material.dart';
import 'dart:async';

import '../models/product.dart';
import '../adapters/dio_adapter.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState(); 
}

class _SearchScreenState extends State<SearchScreen> {
  
  // states
  late List<Product> _productsState;
  bool _hasLoaded = false;
  // values

  List<Product> _products = [];
  DioAdapter _dioAdapter = DioAdapter();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setProduts(null);
  }

  Future<void> _setProduts(ProductType? pType) async  {
    List<Product> p;
    setState(() {
      _hasLoaded = false;
    });
    if (pType != null) {
      p = _products.where((pdt) => pdt.pType == pType).toList();
    } else {
      dynamic response = await _dioAdapter.getRequest("https://firestore.googleapis.com/v1/projects/guitars-eae79/databases/(default)/documents/products");
      List<dynamic> documents = response["documents"];
      _products = documents.map((doc) => Product.fromJson(doc)).toList();
      p = _products;
    }

    setState(() {
      _productsState = p;
      _hasLoaded = true;
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
    if (!_hasLoaded) return _SearchLoading();
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

class _SearchLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text("Search Item"),
      ),
      body:
    Center(child: CircularProgressIndicator())
    );
  }
}

class _ProductTile extends StatelessWidget {

  final Product product;

  const _ProductTile({
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: Image.network(product.image,
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