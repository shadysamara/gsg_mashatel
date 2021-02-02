import 'package:flutter/material.dart';
import 'package:gsg_mashatel/backend/repository.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(Repository.repository.appUser.toJson().toString()),
      ),
    );
  }
}
