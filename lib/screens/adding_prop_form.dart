import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_divider.dart';
class PropertyInputForm extends StatefulWidget {

  @override
  _PropertyInputFormState createState() => _PropertyInputFormState();
}

class _PropertyInputFormState extends State<PropertyInputForm> {
  PropType _propType = PropType.Hotel;
  String _title ,_description , _location ,_imageUrl;
  PickedFile image  ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add the information of your Prop"),
      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        "Choose Your Prop Type",
                      style: TextStyle(fontSize:MainTheme.fontMedium),
                    ),
                  ],
                ),
                SizedBox(height : 5),
                RadioListTile<PropType>(
                  title: const Text('Hotel'),
                  value: PropType.Hotel,
                  groupValue: _propType,
                  onChanged: (PropType  value) {
                    setState(() {
                      _propType = value;
                    });
                  },
                ),
                RadioListTile<PropType>(
                  title: const Text('Property'),
                  value: PropType.Property,
                  groupValue: _propType,
                  onChanged: (PropType  value) {
                    setState(() {
                      _propType = value;
                    });
                  },
                ),

                DividerWithText(tag: "Add title ",),
                TextFormField(
                  onSaved: (value) => _title =value,
                ),

                DividerWithText(tag: "Add Description ",),
                TextFormField(
                  onSaved: (value) => _description =value,
                ),

                DividerWithText(tag: "Add Location  ",),
                TextFormField(
                  onSaved: (value) => _location =value,
                ),
                DividerWithText(tag:"Add Pic "),
                RaisedButton(
                  child: Text("Pick Image "),
                  onPressed: () async {
                    image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                    await locater.get<UserController>().uploadProfilePicture(File(image.path));
                    setState(() {
                     _imageUrl  = locater.get<UserController>().currentUser.avatarURl;
                    });
                  },
                ),

                DividerWithText(tag:""),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: (){
                    
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

enum PropType{
  Property , Hotel
}
