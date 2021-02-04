import 'package:flutter/material.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/models/product.dart';
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
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
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
                    Column(
                      children: [
                        Text(value[index].name),
                        Text(value[index].price),
                      ],
                    )
                  ],
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
