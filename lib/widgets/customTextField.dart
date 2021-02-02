import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function saveFun;
  Function validateFun;
  String labelName;
  CustomTextField({this.labelName, this.saveFun, this.validateFun});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        onSaved: (valu) {
          this.saveFun(valu);
        },
        validator: (value) {
          this.validateFun(value);
        },
        decoration: InputDecoration(
            labelText: this.labelName,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
