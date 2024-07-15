import 'package:fake_api_app/features/product/model/product_model.dart';
import 'package:fake_api_app/features/product/repo/product_repo.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> products = [];
  bool isLoading = false;
  Future<List<ProductModel>> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await ProductRepo().getProducts();
    setState(() {
      isLoading = false;
    });
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        fetchProducts();
      }),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder<List<ProductModel>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return Card(
                          child: Row(
                        children: [
                          Image.network(
                            product.image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title),
                                Text(product.category),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('price ' + product.price.toString()),
                                Text('ratings ' +
                                    product.rating.count.toString()),
                                Text('stars ' + product.rating.rate.toString()),
                              ],
                            ),
                          ),
                        ],
                      ));
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}
