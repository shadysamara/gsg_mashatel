import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/pages/home_page.dart';
import 'package:gsg_mashatel/pages/main_auth.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = getUserId();
    if (userId != null) {
      fetchSplachData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      userId == null ? Get.off(MainAuthPage()) : Get.off(homePage());
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image.asset('assets/pngs/logo.png'),
      ),
    );
  }
}
