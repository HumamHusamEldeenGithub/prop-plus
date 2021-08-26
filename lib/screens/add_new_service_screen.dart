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
import 'package:prop_plus/shared/loading_dialog.dart';
import 'dart:developer' as developer;

import 'package:prop_plus/shared/loading_widget.dart';

class AddNewServiceScreen extends StatefulWidget {
  static String path = "/add_new_service";
  @override
  _AddNewServiceScreen createState() => _AddNewServiceScreen();
}

class _AddNewServiceScreen extends State<AddNewServiceScreen> {
  String _title, _description, _location,  _price;
  List<String> _imagesUrls = List<String>();
  PickedFile image;
  final formKey = GlobalKey<FormState>();

  List<Widget> buildInputTextField() {
    List<Widget> textFields = [];
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Description",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color(0xFF00B9FF),
            width: 2.0,
          ),
        ),
      ),
      onSaved: (value) => _description = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Price per night",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color(0xFF00B9FF),
            width: 2.0,
          ),
        ),
      ),
      onSaved: (value) => _price = value,
    ));
    return textFields;
  }

  Future<void> uploadImage() async{
    String url;
    try {
      url = await locater
          .get<UserController>()
          .uploadServicePhoto(File(image.path));
    }
    catch(e){
      print("Failed to upload image");
      return;
    }
    setState(() {
      _imagesUrls.add(url);
      url = null;
      image = null;
    });
  }
  
  Future<void> submitForm(dynamic module) async {
    await HTTP_Requests.addNewServiceToDB(ServiceModule(
        propertyModule: module,
        price: int.parse(_price),
        description: _description,
        imageUrls: _imagesUrls)
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    dynamic module = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                MainTheme.mainColor,
                MainTheme.secondaryColor,
              ],
            ),
          ),
        ),
        title: Text("New Service"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: _width * 0.8,
                child: Text(
                  "Add information of your new property's service :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: formKey,
                child: Container(
                  width: _width * 0.9,
                  child: Column(
                    children: buildInputTextField(),
                  ),
                ),
              ),
              SizedBox(height: 15),
              DividerWithText(tag: "Add Pic "),
              Container(
                width: _width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
                  child: Text("Pick Image "),
                  onPressed: () async {
                    image = await ImagePicker.platform
                        .pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      LoadingDialog.showLoadingDialog(context, uploadImage(), Text("Uploaded image"), (){Navigator.pop(context);});
                    }
                  },
                ),
              ),
              DividerWithText(tag: ""),
              Container(
                width: _width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFF3DD6EB),),
                  child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  onPressed: () {
                    final form = formKey.currentState;
                    form.save();
                    ///
                    LoadingDialog.showLoadingDialog(context, submitForm(module), Text("You've successfully submitted your service!"), (){
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum PropType { Property, Hotel }
