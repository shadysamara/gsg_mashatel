import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/backend/repository.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/models/market.dart';
import 'package:gsg_mashatel/pages/products_page.dart';
import 'package:gsg_mashatel/widgets/customDrawer.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut();
              })
        ],
      ),
      body: Selector<MashatelProvider, List<Market>>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await getAllMarketsProductsFromFirebase(
                      value[index].marketId);
                  Get.to(ProductsPage());
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          value[index].logoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Text(value[index].userName),
                          Text(value[index].email),
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
          return y.markets;
        },
      ),
    );
  }
}
