import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/backend/repository.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/pages/home_page.dart';
import 'package:logger/logger.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
Logger logger = Logger();
final String collectionName = 'users';
Future<String> registerUsingEmailAndPassword(
    String email, String password) async {
  UserCredential userCredential = await firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password);
  return userCredential.user.uid;
}

Future<String> signInUsingEmailAndPassword(
    String email, String password) async {
  UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
  DocumentSnapshot documentSnapshot = await firestore
      .collection(collectionName)
      .doc(userCredential.user.uid)
      .get();
  Map map = documentSnapshot.data();
  AppUser appUser = AppUser.newUser(map);
  Repository.repository.appUser = appUser;
  Get.to(homePage());
}

String getUserId() {
  String userId = firebaseAuth.currentUser.uid;
  return userId;
}

signOut() {
  firebaseAuth.signOut();
}

saveUserInFirebase(AppUser appUser) async {
  try {
    String userId =
        await registerUsingEmailAndPassword(appUser.email, appUser.password);
    Map map = appUser.toJson();
    map.remove('password');
    bool isMershant = appUser.type == userType.mershant;
    if (isMershant) {
      map['logoUrl'] = await uploadImage(appUser.logo);
      map.remove('logo');
      appUser.logoUrl = map['logoUrl'];
    }

    await firestore.collection(collectionName).doc(userId).set(map);
    Repository.repository.appUser = appUser;
    Get.to(homePage());
  } on Exception catch (e) {
    logger.e(e);
  }
}

Future<AppUser> getUserFromFirebase() async {
  String userId = getUserId();

  DocumentSnapshot documentSnapshot =
      await firestore.collection(collectionName).doc(userId).get();
  Map map = documentSnapshot.data();
  AppUser appUser = AppUser.newUser(map);
  return appUser;
}

Future<String> uploadImage(File file) async {
  String fileName = file.path.split('/').last;
  Reference reference = storage.ref('images/$fileName');
  await reference.putFile(file);
  String imageUrl = await reference.getDownloadURL();
  return imageUrl;
}
