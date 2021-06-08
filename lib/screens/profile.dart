import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/provider.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_avatar.dart';
import 'dart:developer' as developer;


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModule currentUser = locater.get<UserController>().currentUser;
  PickedFile image  ;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("LogOut"),
      onPressed: () async{
        final auth = Provider.of(context).auth;
        await auth.signOut();
      },
    );
  }
}

