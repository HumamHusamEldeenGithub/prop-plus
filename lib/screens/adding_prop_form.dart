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

class PropertyInputForm extends StatefulWidget {
  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {

  Future<void> sendApprovalRequest() async {
    print(_title);

    //TODO : get user's database id and use it here
    //var userId = locater.get<UserController>().currentUser.uid;
    var userId = 1;
    print(userId) ;

    final response = await http.post(
      Uri.parse(
          'https://propplus-production.herokuapp.com/properties_to_approve'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _title,
        'user_id': userId.toString(),
        'phone': _phone,
        'description': _description,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Map<String, dynamic> propToApprove = jsonDecode(response.body);
      dynamic propToApproveId = propToApprove['id'];
      print("DONE");
      print(propToApproveId);

      //TODO iterate over all images
      // for (image in _imageUrl) {
      //   final imageResponse = await http.post(
      //     Uri.parse(
      //         'https://propplus-production.herokuapp.com/approval_images'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(
      //         <String, String>{'property_id': propToApproveId, 'url': image.path}),
      //   );
      //
      //   if (imageResponse.statusCode == 201 ||
      //       response.statusCode == 200) {} else {
      //     throw Exception('Failed to post to  approval_images table  .');
      //   }
      // }
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }


  String _title, _description, _location, _phone;
  PickedFile image;
  List<String>imagesUrls=List<String>();
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

  @override
  Widget build(BuildContext context) {
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
                  onPressed:()async {

                    image = await ImagePicker.platform
                        .pickImage(source: ImageSource.gallery);
                    String imageUrl=await locater
                        .get<UserController>()
                        .uploadPropertyApprovalPhoto(File(image.path));
                    developer.log(imageUrl);
                    setState(() {
                      imagesUrls.add(imageUrl);
                    });



                  },
                ),

                DividerWithText(tag: ""),
                ElevatedButton(
                  child:Text("Check"),
                  onPressed: (){
                    developer.log(imagesUrls.length.toString());
                  },
                ),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final form = formKey.currentState;
                    form.save();
                    // TODO create a propertyToApprove model and send it to httpRequsets.sendApprovalRequest


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


