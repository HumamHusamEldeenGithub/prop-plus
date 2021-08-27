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

class ReportProblem extends StatefulWidget {
  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  String _text;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Widget> buildInputTextField() {
    List<Widget> textFields = [];
    textFields.add(SizedBox(
      height: 15,
    ));
    textFields.add(TextFormField(

      decoration: InputDecoration(

        labelText: "Report a problem ",
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
      onSaved: (value) => _text = value,
    ));
    textFields.add(SizedBox(
      height: 15,
    ));
    return textFields;
  }


  Future<void> submitForm() async {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  width: _width ,
                  child: Text(
                    "We will be glad to hear from you  :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: Container(
                        width: _width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: buildInputTextField(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
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
                          LoadingDialog.showLoadingDialog(context, submitForm(), Text("You've successfully submitted your property!"),Text("There was a problem submitting your property, please try again"), (){}, (){}, false);
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
