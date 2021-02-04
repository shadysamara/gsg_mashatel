import 'dart:io';

enum userType { customer, mershant }

class AppUser {
  String userId;
  String companyName;
  String userName;
  String email;
  String password;
  String mobileNumber;
  File logo;
  String logoUrl;
  String companyActivity;
  userType type;
  AppUser(
      {this.companyActivity,
      this.companyName,
      this.email,
      this.logo,
      this.userName,
      this.mobileNumber,
      this.password,
      this.userId,
      this.type});
  factory AppUser.newUser(Map map) {
    bool isMershant = map['isMershant'] ?? false;
    if (isMershant) {
      return AppUser.mershantUser(map);
    } else {
      return AppUser.customerUser(map);
    }
  }
  AppUser.mershantUser(Map map) {
    this.userId = map['userId'];
    this.companyActivity = map['companyActivity'];
    this.userName = map['userName'];
    this.email = map['email'];
    this.password = map['password'] ?? '';
    this.mobileNumber = map['mobileNumber'];
    this.companyName = map['compnayName'];
    this.logoUrl = map['logoUrl'];
    this.type = userType.mershant;
  }
  AppUser.customerUser(Map map) {
    this.userId = map['userId'];
    this.userName = map['userName'];
    this.email = map['email'];
    this.password = map['password'] ?? '';
    this.mobileNumber = map['mobileNumber'];
    this.type = userType.customer;
  }
  toJson() {
    return type == userType.customer
        ? {
            'userName': this.userName,
            'email': this.email,
            'password': this.password,
            'mobileNumber': this.mobileNumber,
            'isCustomer': true
          }
        : {
            'userName': this.userName,
            'email': this.email,
            'password': this.password,
            'mobileNumber': this.mobileNumber,
            'compnayName': this.companyName,
            'logo': this.logo,
            'logoUrl': this.logoUrl,
            'companyActivity': this.companyActivity,
            'isMershant': true
          };
  }
}
