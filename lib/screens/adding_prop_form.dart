import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_to_approve_model.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_divider.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'package:prop_plus/shared/loading_widget.dart';
import 'package:prop_plus/shared/popup.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../main.dart';

class PropertyInputForm extends StatefulWidget {
  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {
  String _title, _description, _city, _street, _phone, _type = "Flat";
  PickedFile image;
  List<String> imagesUrls = List<String>();
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Widget> buildInputTextField() {
    List<Widget> textFields = [];
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(DropdownButton<String>(
      value: _type,
      icon: Icon(
        Icons.arrow_drop_down,
        color: MainTheme.mainColor,
      ),
      iconSize: 20,
      elevation: 2,
      style: TextStyle(color: MainTheme.mainColor),
      underline: Container(
        height: 1,
        color: MainTheme.mainColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          _type = newValue;
        });
      },
      items: <String>['Flat','Villa','Hotel']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Title ",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.5,
          ),
        ),
      ),
      onSaved: (value) => _title = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Description",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
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
        labelText: "Phone number",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
      ),
      onSaved: (value) => _phone = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "City",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
      ),
      onSaved: (value) => _city = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(
      decoration: InputDecoration(
        labelText: "Street",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: MainTheme.greyFontColor,
            width: 0.3,
          ),
        ),
      ),
      onSaved: (value) => _street = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    return textFields;
  }


  Future<void> uploadImage() async{
    String imageUrl;
    imageUrl = await locater
      .get<UserController>()
      .uploadPropertyApprovalPhoto(File(image.path));
    setState(() {
      imagesUrls.add(imageUrl);
      imageUrl = null;
      image = null;
    });
  }

  Future<void> submitForm() async {
    PropertyToApprove module = new PropertyToApprove(
        user_id:
        MainWidget.userData['CurrentUser'].dbId,
        title: _title,
        phone: _phone,
        city: _city,
        street: _street,
        type: _type,
        description: _description,
        approvalImagesUrls: imagesUrls);
    await HTTP_Requests.sendApprovalRequest(module);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

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
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: _width * 0.8,
                  child: Text(
                    "Enter all the information for adding a new property :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Container(
                        width: _width * 0.9,
                        child: Column(
                          children: buildInputTextField(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    DividerWithText(tag: "The Approval Images"),
                    Container(
                      width: _width * 0.6,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[500]),
                        child: Text("Pick the Images one by one :"),
                        onPressed: () async {

                          image = await ImagePicker.platform
                              .pickImage(source: ImageSource.gallery);
                          if(image!=null)
                            LoadingDialog.showLoadingDialog(context, uploadImage(), Text("Uploaded image"), Text("Failed to upload image"),(){}, false);
                          /*setState(() {
                                  loading = true;
                                });*/

                        },
                      ),
                    ),
                    DividerWithText(tag: ""),
                    Container(
                      width: _width * 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF3DD6EB),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () async {
                          final form = formKey.currentState;
                          form.save();
                          LoadingDialog.showLoadingDialog(context, submitForm(), Text("You've successfully submitted your property!"),Text("There was a problem submitting your property, please try again"), (){}, false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
