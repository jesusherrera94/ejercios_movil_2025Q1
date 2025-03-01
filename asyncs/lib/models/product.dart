enum ProductType { INSTRUMENT, EFFECT, MAINTENANCE }

class Product {
  String id;
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
    required this.pType,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] as Map<String, dynamic>;
    // print('======================================> $fields');
    return Product(
      id: json['name'].split('/').last, // Extract ID from name
      image: fields['image']['stringValue'] as String,
      name: fields['name']['stringValue'] as String,
      description: fields['description']['stringValue'] as String,
      price: fields['price']['doubleValue'] as double,
      pType: ProductType.values[int.parse(fields['pType']['integerValue'] as String)],
    );
  }
}