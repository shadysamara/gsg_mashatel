import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/pages/login_page.dart';
import 'package:gsg_mashatel/pages/main_auth.dart';
import 'package:gsg_mashatel/pages/registerationPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      home: MaterialApp(
    home: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.redAccent,
            body: Center(
              child: Icon(
                Icons.error,
                size: 150,
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          backgroundColor: Colors.redAccent,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
