import 'dart:convert';

class ProductShared {
  final int id;
  final String name;
  final String subDescription;
  final double price;
  int count;
  final String image;
  final String currency;
  final String unitInfoName;
  final String unitInfoValue;

  ProductShared(
      {this.id,
        this.name,
        this.subDescription,
        this.price,
        this.count,
        this.image,
        this.currency,
        this.unitInfoName,
        this.unitInfoValue});

  factory ProductShared.fromJson(Map<String, dynamic> jsonData) {
    return ProductShared(
      id: jsonData['id'],
      name: jsonData['name'],
      subDescription: jsonData['subDescription'],
      price: jsonData['price'],
      count: jsonData['count'],
      image: jsonData['image'],
      currency: jsonData['currency'],
      unitInfoName: jsonData['unitInfoName'],
      unitInfoValue: jsonData['unitInfoValue'],
    );
  }

  static Map<String, dynamic> toMap(ProductShared product) => {
    'id': product.id,
    'name': product.name,
    'subDescription': product.subDescription,
    'price': product.price,
    'count': product.count,
    'image': product.image,
    'currency': product.currency,
    'unitInfoName': product.unitInfoName,
    'unitInfoValue': product.unitInfoValue
  };

  static String encode(List<ProductShared> product) => json.encode(
    product
        .map<Map<String, dynamic>>(
            (product) => ProductShared.toMap(product))
        .toList(),
  );

  static List<ProductShared> decode(String product) =>
      (json.decode(product) as List<dynamic>)
          .map<ProductShared>((item) => ProductShared.fromJson(item))
          .toList();
}
