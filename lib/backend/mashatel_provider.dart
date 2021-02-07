import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsg_mashatel/models/market.dart';
import 'package:gsg_mashatel/models/product.dart';
import 'package:gsg_mashatel/models/user.dart';

class MashatelProvider extends ChangeNotifier {
  Market selectedMarket;
  AppUser appUser;
  setAppUser(AppUser appUser) {
    this.appUser = appUser;
    notifyListeners();
  }

  bool isCallAllowed = false;
  bool isMessagesAllowed = false;
  changeCallAllowed() {
    this.isCallAllowed = !this.isCallAllowed;
    notifyListeners();
  }

  changeMessagesAllowed() {
    this.isMessagesAllowed = !this.isMessagesAllowed;
    notifyListeners();
  }

  File file;
  setFile(File file) {
    this.file = file;
    notifyListeners();
  }

  List<Market> markets = [];
  List<Product> products = [];

  setMarkets(List<Market> value) {
    this.markets = value;
    notifyListeners();
  }

  setProducts(List<Product> value) {
    this.products = value;
    notifyListeners();
  }

  int productBottomIndex = 0;
  changeIndex(int value) {
    this.productBottomIndex = value;
    notifyListeners();
  }
}
