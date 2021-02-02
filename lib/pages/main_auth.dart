import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/pages/registerationPage.dart';

class MainAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RaisedButton(
              child: Text('Mershant'),
              onPressed: () {
                Get.to(RegistrationPage(userType.mershant));
              }),
          RaisedButton(
              child: Text('Customer'),
              onPressed: () {
                Get.to(RegistrationPage(userType.customer));
              })
        ],
      ),
    );
  }
}
