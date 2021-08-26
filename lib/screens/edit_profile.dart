import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'dart:developer' as developer;

import 'package:prop_plus/shared/loading_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  PickedFile image;
  final formKey = GlobalKey<FormState>();
  String _name ,_phone;
  UserModule currentUser;
  Function setStateCallback;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locater.get<UserController>().InitializeUser();
    currentUser = locater.get<UserController>().currentUser;
  }

  Future<void> uploadImage() async{
    String imageUrl;
    try {
      imageUrl = await locater
          .get<UserController>()
          .uploadProfilePicture(File(image.path));
      await HTTP_Requests.updateAvatarURL(currentUser.userName, imageUrl);
    }
    catch(E) {
      print("Failed to upload image");
      return;
    }
    setState(() {
      setStateCallback();
      locater.get<UserController>().currentUser.avatarURl = imageUrl;
      imageUrl =null;
      image=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    setStateCallback = ModalRoute.of(context).settings.arguments;
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                locater.get<UserController>().currentUser.avatarURl!=null ?
                                locater.get<UserController>().currentUser.avatarURl.toString():
                                "https://thumbs.dreamstime.com/b/creative-vector-illustration-default-avatar-profile-placeholder-isolated-background-art-design-grey-photo-blank-template-mo-107388687.jpg"
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            image = await ImagePicker.platform
                                .pickImage(source: ImageSource.gallery);
                            if(image!=null)
                              LoadingDialog.showLoadingDialog(context, uploadImage(), Text("Uploaded Image"), (){Navigator.pop(context);});
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: MainTheme.mainColor,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),

            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "FullName" ,
                      hintText: "${currentUser.userName}",
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
                    validator: NameValidator.validate,
                    onSaved: (value) => _name = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Phone" ,
                      hintText: "Unknown",
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
                    validator: PhoneNumberValidator.validate,
                    onSaved: (value) => _phone = value,
                  ),
                ],
              ),
            ),


              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      form.save();
                      //TODO update the username in firebase and database
                    },
                    color: MainTheme.mainColor,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }




}