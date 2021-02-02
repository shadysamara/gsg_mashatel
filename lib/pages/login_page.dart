import 'package:flutter/material.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/widgets/customTextField.dart';

class LoginPage extends StatelessWidget {
  String email;
  String password;
  saveEmail(String value) {
    this.email = value;
  }

  savepassword(String value) {
    this.password = value;
  }

  nullValidator(String value) {
    if (value == '' || value == null) {
      return 'required field';
    }
  }

  GlobalKey<FormState> loginKey = GlobalKey();
  saveForm() {
    if (loginKey.currentState.validate()) {
      loginKey.currentState.save();

      signInUsingEmailAndPassword(this.email, this.password);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: loginKey,
            child: Expanded(
              child: ListView(
                children: [
                  CustomTextField(
                    labelName: 'Email',
                    saveFun: saveEmail,
                    validateFun: nullValidator,
                  ),
                  CustomTextField(
                    labelName: 'Password',
                    saveFun: savepassword,
                    validateFun: nullValidator,
                  ),
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
