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

class PropertyInputForm extends StatefulWidget {
  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {
  String _title, _description, _city, _street, _phone, _type = "Hotel";
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
      icon: const Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 16,
      style: TextStyle(color: MainTheme.mainColor),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          _type = newValue;
        });
      },
      items: <String>['Hotel', 'Private Property']
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
        labelText: "Phone number",
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
      onSaved: (value) => _street = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    return textFields;
  }

  //TODO loading bar to upload the photo
  Future showProgressBar(ProgressDialog pr) async {
    double percentage = 0.0;
    await pr.show();

    await Future.delayed(Duration(seconds: 2)).then((onvalue) {
      percentage = percentage + 30.0;
      print(percentage);

      pr.update(
        progress: percentage,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
      );

      Future.delayed(Duration(seconds: 2)).then((value) {
        percentage = percentage + 30.0;
        pr.update(progress: percentage, message: "Few more seconds...");
        print(percentage);
        Future.delayed(Duration(seconds: 2)).then((value) {
          percentage = percentage + 30.0;
          pr.update(progress: percentage, message: "Almost done...");
          print(percentage);

          Future.delayed(Duration(seconds: 2)).then((value) {
            pr.hide().whenComplete(() {
              print(pr.isShowing());
            });
            percentage = 0.0;
          });
        });
      });
    });

    await Future.delayed(Duration(seconds: 6)).then((onValue) {
      print("PR status  ${pr.isShowing()}");
      if (pr.isShowing())
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      print("PR status  ${pr.isShowing()}");
    });
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
        locater<UserController>().currentUser.dbId,
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
    ProgressDialog pr = ProgressDialog(context);

    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: false,
      //  customBody: LinearProgressIndicator(
      //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
      //   backgroundColor: Colors.white,
      // ),
    );

    pr.style(
//      message: 'Downloading file...',
      message: 'Please wait ...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

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
        title: Text("Add the information of your Prop"),
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
                    "Please enter all the information for adding a new property :",
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
                            LoadingDialog.showLoadingDialog(context, uploadImage(), Text("Uploaded image"), Text("Failed to upload image"),(){Navigator.pop(context);});
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
                          LoadingDialog.showLoadingDialog(context, submitForm(), Text("You've successfully submitted your property!"),Text("There was a problem submitting your property, please try again"), (){Navigator.popUntil(context, ModalRoute.withName('/homeScreen'));});
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
