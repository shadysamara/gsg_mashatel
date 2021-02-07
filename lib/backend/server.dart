import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/backend/repository.dart';
import 'package:gsg_mashatel/models/market.dart';
import 'package:gsg_mashatel/models/product.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/pages/home_page.dart';
import 'package:gsg_mashatel/pages/login_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

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
  map['userId'] = userCredential.user.uid;
  // logger.e(userCredential.user.uid);
  AppUser appUser = AppUser.newUser(map);
  Repository.repository.appUser = appUser;
  Get.to(homePage());
}

String getUserId() {
  String userId =
      firebaseAuth.currentUser != null ? firebaseAuth.currentUser.uid : null;
  return userId;
}

signOut() async {
  await firebaseAuth.signOut();
  Get.off(LoginPage());
}

saveUserInFirebase(AppUser appUser) async {
  try {
    String userId =
        await registerUsingEmailAndPassword(appUser.email, appUser.password);
    Map map = appUser.toJson();
    map.remove('password');
    bool isMershant = appUser.type == userType.mershant;
    if (isMershant) {
      map['logoUrl'] = await uploadImage(
          Provider.of<MashatelProvider>(Get.context, listen: false).file);

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
  map['userId'] = userId;
  AppUser appUser = AppUser.newUser(map);

  return appUser;
}

Future<String> uploadImage(File file, [bool isProductImage = false]) async {
  String fileName = file.path.split('/').last;
  String folderName = isProductImage ? 'productImages' : 'logos';
  Reference reference = storage.ref('$folderName/$fileName');
  await reference.putFile(file);
  String imageUrl = await reference.getDownloadURL();
  return imageUrl;
}

fetchSplachData() async {
  getAllMarkets();

  AppUser appUser = await getUserFromFirebase();
  Repository.repository.appUser = appUser;
}

addNewProduct(Map map) async {
  String productImageUrl = await uploadImage(map['file'], true);

  map.remove('file');
  map['imageUrl'] = productImageUrl;
  await firestore
      .collection('Products')
      .doc(Repository.repository.appUser.userId)
      .collection('MarketProduct')
      .add({...map});
  Get.back();
}

getAllMarkets() async {
  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('isMershant', isEqualTo: true)
      .get();
  List<Market> markets = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['marketId'] = e.id;
    return Market.fromMap(map);
  }).toList();
  Provider.of<MashatelProvider>(Get.context, listen: false).setMarkets(markets);
}

getAllMarketsProductsFromFirebase(String marketId) async {
  QuerySnapshot querySnapshot = await firestore
      .collection('Products')
      .doc(marketId)
      .collection('MarketProduct')
      .get();

  List<Product> products = querySnapshot.docs.map((e) {
    Map map = e.data();
    map['productId'] = e.id;
    return Product.fromMap(map);
  }).toList();
  Provider.of<MashatelProvider>(Get.context, listen: false)
      .setProducts(products);
}

reportProduct(String productId, String userId, String reportReason) async {
  await firestore
      .collection('Reports')
      .doc(productId)
      .collection('Users')
      .doc(userId)
      .set({'reportReason': reportReason});
}
