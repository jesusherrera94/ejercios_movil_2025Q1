import 'package:flutter/material.dart';
import 'product_item.dart';
import '../adapters/dio_adapter.dart';
import '../models/product.dart';


List<Map<String, dynamic>> cartItems = [];

class Home extends StatefulWidget {
  const Home({super.key});

  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Product> _products = [];
  bool _hasLoaded = false;

  // instancia de dio
  DioAdapter _dioAdapter = DioAdapter();
  

  @override
  void initState() {
    _getProducts();
    super.initState();
  }


  Future<void> _getProducts() async {
    dynamic response = await _dioAdapter.getRequest('https://firestore.googleapis.com/v1/projects/guitars-eae79/databases/(default)/documents/products');
    List<dynamic> documents = response['documents'];
     _products = documents.map((doc) => Product.fromJson(doc)).toList();
    setState(() {
      _hasLoaded = true;
    });
  }

  void _addToCart(Product product){
    setState((){
      cartItems.add({
        'title': product.name,
        'subtitle': product.description,
        'price': product.price,
        'image': product.image,
      });
    });
  }

List<Widget> _renderProduct() {
  List<Widget> productWidget = [];
  for(final p in _products) {
    productWidget.add(ProductItem(product: p, addToCart: _addToCart));
  }
  return productWidget;
}

  @override
  Widget build(BuildContext context) {

    if(!_hasLoaded) return Center(child: CircularProgressIndicator(),);

    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2,
      children: [
        ..._renderProduct(),
      ],
    );
  }
  
}
