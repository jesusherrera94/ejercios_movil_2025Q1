
enum ProductType {
  INSTRUMENT, EFFECT, MAINTENANCE
}

class Product {
  int id;
  String image;
  String name;
  String description;
  double price;
  ProductType pType;
  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.pType
  });
}