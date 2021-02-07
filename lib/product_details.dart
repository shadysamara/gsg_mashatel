import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/models/product.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  Product product;
  ProductDetails(this.product);
  callMarket(String phoneNumber) async {
    if (product.isCall) {
      String url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      Get.defaultDialog(
          title: 'error', content: Text('Calling is disabled in this product'));
    }
  }

  sendMessageToMarket(String phoneNumber) async {
    if (product.isMessage) {
      String url = 'sms:$phoneNumber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      Get.defaultDialog(
          title: 'error',
          content: Text('Messagong is disabled in this product'));
    }
  }

  String reportReason = '';
  reportMarket(String marketNumber) {}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: Selector<MashatelProvider, int>(
        selector: (x, y) {
          return y.productBottomIndex;
        },
        builder: (context, value, child) {
          return BottomNavigationBar(
            onTap: (value) async {
              Provider.of<MashatelProvider>(context, listen: false)
                  .changeIndex(value);
              switch (value) {
                case 1:
                  callMarket(
                      Provider.of<MashatelProvider>(context, listen: false)
                          .selectedMarket
                          .mobileNumber);
                  break;
                case 0:
                  sendMessageToMarket(
                      Provider.of<MashatelProvider>(context, listen: false)
                          .selectedMarket
                          .mobileNumber);
                  break;
                case 2:
                  await Get.defaultDialog(
                    title: 'Report',
                    content: TextField(
                      onChanged: (value) {
                        reportReason = value;
                      },
                    ),
                    onConfirm: () {
                      Get.back();
                    },
                  );
                  reportProduct(product.productId, getUserId(), reportReason);
                  break;
              }
            },
            currentIndex: value,
            items: [
              BottomNavigationBarItem(label: '', icon: Icon(Icons.message)),
              BottomNavigationBarItem(label: '', icon: Icon(Icons.call)),
              BottomNavigationBarItem(label: '', icon: Icon(Icons.report)),
            ],
          );
        },
      ),
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height / 4,
            width: size.width,
            color: Colors.grey,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                Text(product.description),
                Text(product.price),
                Text(product.isCall.toString()),
                Text(product.isMessage.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
