import 'package:flutter/material.dart';
import 'model_product.dart';
class CartListItem with ChangeNotifier {
  List<ProductShared> cartList;

  CartListItem(this.cartList);

  List<ProductShared> getCart() => cartList;

  setNewCartItem(
      int id,
      String name,
      String subDescription,
      double price,
      int count,
      String image,
      String currency,
      String unitInfoName,
      String unitInfoValue) async {
    if (cartList == null) {
      cartList = [];
    }
    ProductShared map = ProductShared(
        id: id,
        name: name,
        subDescription: subDescription,
        price: price,
        count: count,
        image: image,
        currency: currency,
        unitInfoName: unitInfoName,
        unitInfoValue: unitInfoValue);
    cartList.insert(0, map);
    notifyListeners();
  }
}
