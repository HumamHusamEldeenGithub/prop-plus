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
import 'package:prop_plus/shared/loading_widget.dart';
import 'package:prop_plus/shared/popup.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PropertyInputForm extends StatefulWidget {
  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {
  String _title, _description, _location, _phone;
  PickedFile image;
  List<String> imagesUrls = List<String>();
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Widget> buildInputTextField() {
    List<Widget> textFields = [];
    textFields.add(DividerWithText(
      tag: "Add title ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _title = value,
    ));
    textFields.add(DividerWithText(
      tag: "Add Description ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _description = value,
    ));
    textFields.add(DividerWithText(
      tag: "Add Phone ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _phone = value,
    ));
    textFields.add(DividerWithText(
      tag: "Add location ",
    ));
    textFields.add(TextFormField(
      onSaved: (value) => _location = value,
    ));
    return textFields;
  }

  //TODO loading bar to upload the photo
  Future showProgressBar(ProgressDialog pr)async{
    double percentage = 0.0;
    await pr.show();

    await Future.delayed(Duration(seconds: 2)).then((onvalue) {
      percentage = percentage + 30.0;
      print(percentage);

      pr.update(
        progress: percentage,
        message: "Please wait...",
        progressWidget: Container(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator()),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600),
      );

       Future.delayed(Duration(seconds: 2)).then((value) {
        percentage = percentage + 30.0;
        pr.update(
            progress: percentage, message: "Few more seconds...");
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


  @override
  Widget build(BuildContext context) {
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
      message:
      'Please wait ...',
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
        title: Text("Add the information of your Prop"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: buildInputTextField(),
                  ),
                ),
                SizedBox(height: 5),
                DividerWithText(tag: "The Approval Images"),
                RaisedButton(
                  child: Text("Pick the Images one by one :"),
                  onPressed: () async {
                    image = await ImagePicker.platform
                        .pickImage(source: ImageSource.gallery);
                    /*setState(() {
                            loading = true;
                          });*/
                    String imageUrl = await locater
                        .get<UserController>()
                        .uploadPropertyApprovalPhoto(File(image.path));
                    developer.log(imageUrl);
                    setState(() {
                      imagesUrls.add(imageUrl);
                      loading = true;
                    });
                  },
                ),
                DividerWithText(tag: ""),
                ElevatedButton(
                  //TODO need to remove it ... used to check if the upload is done
                  child: Text("Check"),
                  onPressed: () async {
                    await showProgressBar(pr);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Popup(
                              title: "Done",
                              content: "Done",
                            ));
                    developer.log(imagesUrls.length.toString());
                  },
                ),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final form = formKey.currentState;
                    form.save();

                    //Create a property to approve model and send it to approval request
                    PropertyToApprove model = new PropertyToApprove(
                        user_id: locater<UserController>().currentUser.dbId,
                        title: _title,
                        phone: _phone,
                        location: _location,
                        description: _description,
                        approvalImagesUrls: imagesUrls);
                    HTTP_Requests.sendApprovalRequest(model);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
