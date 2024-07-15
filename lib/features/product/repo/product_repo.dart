import 'dart:convert';

import 'package:fake_api_app/core/network/app_url.dart';
import 'package:fake_api_app/core/network/http_wrapper.dart';
import 'package:fake_api_app/features/product/model/product_model.dart';

class ProductRepo {
  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> productsList = [];
    try {
      final res =
          await HttpWrapper.getRequest("https://fakestoreapi.com/products");

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var product in data) {
          productsList.add(ProductModel.fromMap(product));
        }
        return productsList;
      }
    } catch (e) {
      print(e.toString());
    }
    return productsList;
  }
}
