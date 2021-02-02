import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            width: 300,
            child: Image.asset('assets/pngs/logo.png'),
          ),
          Row(
            children: [Text('login'), Text('register')],
          )
        ],
      ),
    );
  }
}
