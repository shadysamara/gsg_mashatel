import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/pages/login_page.dart';
import 'package:gsg_mashatel/pages/registerationPage.dart';

class MainAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Register As Mershant'),
                onPressed: () {
                  Get.to(RegistrationPage(userType.mershant));
                }),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Register As Customer'),
                onPressed: () {
                  Get.to(RegistrationPage(userType.customer));
                }),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Login to Mashatel'),
                onPressed: () {
                  Get.to(LoginPage());
                })
          ],
        ),
      ),
    );
  }
}
