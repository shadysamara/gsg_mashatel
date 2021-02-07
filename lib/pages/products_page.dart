import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/models/product.dart';
import 'package:gsg_mashatel/product_details.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Selector<MashatelProvider, List<Product>>(
        builder: (context, value, child) {
          return value.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetails(value[index]));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                value[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value[index].name),
                                Text(value[index].price),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
        selector: (x, y) {
          return y.products;
        },
      ),
    );
  }
}
