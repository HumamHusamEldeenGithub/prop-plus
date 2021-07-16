import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_divider.dart';
import 'package:http/http.dart' as http;

class PropertyInputForm extends StatefulWidget {
  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {
  Future<void> sendApprovalRequest() async {
    print(_title);

    //TODO : get user's database id and use it here
    //var userId = locater.get<UserController>().currentUser.uid;
    var userId = 954;
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

  PropType _propType = PropType.Hotel;
  String _title, _description, _location, _imageUrl, _phone;
  PickedFile image;
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
                Row(
                  children: [
                    Text(
                      "Choose Your Prop Type",
                      style: TextStyle(fontSize: MainTheme.fontMedium),
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: buildInputTextField(),
                  ),
                ),
                SizedBox(height: 5),
                RadioListTile<PropType>(
                  title: const Text('Hotel'),
                  value: PropType.Hotel,
                  groupValue: _propType,
                  onChanged: (PropType value) {
                    setState(() {
                      _propType = value;
                    });
                  },
                ),
                RadioListTile<PropType>(
                  title: const Text('Property'),
                  value: PropType.Property,
                  groupValue: _propType,
                  onChanged: (PropType value) {
                    setState(() {
                      _propType = value;
                    });
                  },
                ),
                DividerWithText(tag: "Add Pic "),
                RaisedButton(
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
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final form = formKey.currentState;
                    form.save();
                    sendApprovalRequest();
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
