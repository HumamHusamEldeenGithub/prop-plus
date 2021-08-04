import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_divider.dart';
import 'package:http/http.dart' as http;
import 'package:prop_plus/shared/http_requests.dart';

class AddNewServiceScreen extends StatefulWidget {
  static String path = "/add_new_service";
  @override
  _AddNewServiceScreen createState() => _AddNewServiceScreen();
}

class _AddNewServiceScreen extends State<AddNewServiceScreen> {
  String _title, _description, _location, _imageUrl, _price;
  PickedFile image;
  final formKey = GlobalKey<FormState>();

  List<Widget> buildInputTextField() {
    List<Widget> textFields = [];
    textFields.add(DividerWithText(
      tag: "Add Description ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _description = value,
    ));
    textFields.add(DividerWithText(
      tag: "Add price per night ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _price = value,
    ));
    return textFields;
  }

  @override
  Widget build(BuildContext context) {
    dynamic module = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Service"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Add information of your new property's service",
                        style: TextStyle(fontSize: MainTheme.fontMedium),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Form(
                  key: formKey,
                  child: Column(
                    children: buildInputTextField(),
                  ),
                ),
                SizedBox(height: 5),
                DividerWithText(tag: "Add Pic "),
                ElevatedButton(
                  child: Text("Pick Image "),
                  onPressed: () async {
                    image = await ImagePicker.platform
                        .pickImage(source: ImageSource.gallery);
                    await locater
                        .get<UserController>()
                        .uploadProfilePicture(File(image.path));
                    setState(() {
                      _imageUrl =
                          locater.get<UserController>().currentUser.avatarURl;
                    });
                  },
                ),
                DividerWithText(tag: ""),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final form = formKey.currentState;
                    form.save();
                    HTTP_Requests.addNewServiceToDB(
                        ServiceModule(
                            propertyModule: module.propertyModule,
                            price: double.parse(_price),
                            description: _description,
                            imageUrls: [])
                        // }
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PropType { Property, Hotel }
