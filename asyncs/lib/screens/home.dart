import 'package:flutter/material.dart';
import 'product_item.dart';
import '../adapters/dio_adapter.dart';
import '../models/product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Product> _products = [];
  bool _hasLoaded = false;

  DioAdapter _dioAdapter = DioAdapter();

  @override
  void initState() {
    _getProducts();
    super.initState();
  }


  Future<void> _getProducts() async {
    dynamic response = await _dioAdapter.getRequest("https://firestore.googleapis.com/v1/projects/guitars-eae79/databases/(default)/documents/products");
    List<dynamic> documents = response["documents"];
    _products = documents.map((doc) => Product.fromJson(doc)).toList();
    setState(() {
      _hasLoaded = true;
    });
  }

  List<Widget> _renderProducts() {
    List<Widget> productWidgets = [];
    for(final p in _products) {
      productWidgets.add(ProductItem(product: p));
    }
    return productWidgets;
  }

  @override
  Widget build(BuildContext context) {

    if (!_hasLoaded) return _HomeLoading();
    
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      children: [
        ..._renderProducts()
      ],
    );
  }
  
}

class _HomeLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}