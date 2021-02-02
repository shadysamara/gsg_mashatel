import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/models/user.dart';
import 'package:gsg_mashatel/utilities/helpers.dart';
import 'package:gsg_mashatel/widgets/customTextField.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends StatelessWidget {
  userType type;
  RegistrationPage(this.type);
  String companyName;
  String userName;
  String email;
  String password;
  String mobileNumber;
  File logo;
  String companyActivity;
  saveCompanyName(String value) {
    this.companyName = value;
  }

  saveUserName(String value) {
    this.userName = value;
  }

  saveEmail(String value) {
    this.email = value;
  }

  savepassword(String value) {
    this.password = value;
  }

  saveMobileNum(String value) {
    this.mobileNumber = value;
  }

  saveLogo(File value) {
    this.logo = value;
  }

  saveCompanyActivity(String value) {
    this.companyActivity = value;
  }

  nullValidator(String value) {
    if (value == '' || value == null) {
      return 'required field';
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();
  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      AppUser appUser = type == userType.mershant
          ? AppUser.mershantUser({
              'companyActivity': this.companyActivity,
              'userName': this.userName,
              'email': this.email,
              'password': this.password,
              'mobileNumber': this.mobileNumber,
              'compnayName': this.companyName,
              'logo': this.logo
            })
          : AppUser.customerUser({
              'userName': this.userName,
              'email': this.email,
              'password': this.password,
              'mobileNumber': this.mobileNumber,
            });

      saveUserInFirebase(appUser);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mershant'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 40,
                width: 40,
                child: SvgPicture.asset(getSvgName('shop')),
              ),
              Text(
                'Mershant Registration',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Form(
            key: formKey,
            child: Expanded(
              child: ListView(
                children: [
                  this.type == userType.mershant
                      ? CustomTextField(
                          labelName: 'Company Name',
                          saveFun: saveCompanyName,
                          validateFun: nullValidator,
                        )
                      : Container(),
                  CustomTextField(
                    labelName: 'User Name',
                    saveFun: saveUserName,
                    validateFun: nullValidator,
                  ),
                  CustomTextField(
                    labelName: 'Password',
                    saveFun: savepassword,
                    validateFun: nullValidator,
                  ),
                  CustomTextField(
                    labelName: 'Email',
                    saveFun: saveEmail,
                    validateFun: nullValidator,
                  ),
                  CustomTextField(
                    labelName: 'Mobile',
                    saveFun: saveMobileNum,
                    validateFun: nullValidator,
                  ),
                  this.type == userType.mershant
                      ? CustomTextField(
                          labelName: 'Company Activity',
                          saveFun: saveCompanyActivity,
                          validateFun: nullValidator,
                        )
                      : Container(),
                  this.type == userType.mershant
                      ? GestureDetector(
                          onTap: () async {
                            PickedFile pickedFile = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            saveLogo(File(pickedFile.path));
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Icon(Icons.add),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('Register'),
                  onPressed: () {
                    saveForm();
                  }))
        ],
      ),
    );
  }
}
