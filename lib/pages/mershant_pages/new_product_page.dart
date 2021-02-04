import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsg_mashatel/backend/mashatel_provider.dart';
import 'package:gsg_mashatel/backend/server.dart';
import 'package:gsg_mashatel/widgets/customTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProduct extends StatelessWidget {
  String productName;
  String price;
  String description;
  bool allowCall;
  bool allowMessages;
  File productimage;
  GlobalKey<FormState> newProductFormKey = GlobalKey();
  nullValidator(String value) {
    if (value == '' || value == null) {
      return 'required field';
    }
  }

  setProductName(String value) {
    this.productName = value;
  }

  setProductPrice(String value) {
    this.price = value;
  }

  setProductDescription(String value) {
    this.description = value;
  }

  setAllowCall(bool value) {
    this.allowCall = value;
  }

  setAllowMessages(bool value) {
    this.allowMessages = value;
  }

  saveForm(context) {
    if (newProductFormKey.currentState.validate()) {
      newProductFormKey.currentState.save();
      Map map = {
        'productName': this.productName,
        'productPrice': this.price,
        'productDescription': this.description,
        'allowCalling':
            Provider.of<MashatelProvider>(context, listen: false).isCallAllowed,
        'allowMessaging': Provider.of<MashatelProvider>(context, listen: false)
            .isMessagesAllowed,
        'file': Provider.of<MashatelProvider>(context, listen: false).file,
      };
      addNewProduct(map);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Form(
          key: newProductFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  labelName: 'Product Name',
                  saveFun: setProductName,
                  validateFun: nullValidator,
                ),
                CustomTextField(
                  labelName: 'Price',
                  saveFun: setProductPrice,
                  validateFun: nullValidator,
                ),
                CustomTextField(
                  labelName: 'Description',
                  saveFun: setProductDescription,
                  validateFun: nullValidator,
                ),
                Selector<MashatelProvider, bool>(
                  builder: (context, value, child) {
                    return CheckboxListTile(
                      title: Text('Allow Calling'),
                      value: value,
                      onChanged: (value) {
                        Provider.of<MashatelProvider>(context, listen: false)
                            .changeCallAllowed();
                      },
                    );
                  },
                  selector: (x, y) {
                    return y.isCallAllowed;
                  },
                ),
                Selector<MashatelProvider, bool>(
                  builder: (context, value, child) {
                    return CheckboxListTile(
                      title: Text('Allow Messaging'),
                      value: value,
                      onChanged: (value) {
                        Provider.of<MashatelProvider>(context, listen: false)
                            .changeMessagesAllowed();
                      },
                    );
                  },
                  selector: (x, y) {
                    return y.isMessagesAllowed;
                  },
                ),
                Selector<MashatelProvider, File>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        PickedFile pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        File file = File(pickedFile.path);
                        Provider.of<MashatelProvider>(context, listen: false)
                            .setFile(file);
                      },
                      child: Container(
                        color: Colors.grey[300],
                        height: 200,
                        width: 200,
                        child: value != null
                            ? Image.file(
                                value,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.add),
                      ),
                    );
                  },
                  selector: (x, y) {
                    return y.file;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text('Add Product'),
                    onPressed: () {
                      saveForm(context);
                    })
              ],
            ),
          )),
    );
  }
}
