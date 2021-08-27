import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/Validator.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'package:image/image.dart' as BinaryImages;
import 'dart:developer' as developer;

import 'package:prop_plus/shared/loading_widget.dart';

import '../main.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  PickedFile image;
  String avatarURL;
  final formKey = GlobalKey<FormState>();
  String _name ,_phone;
  UserModule currentUser;
  Function setStateCallback;
  String _warning;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> uploadImage(String imagePath) async{
    String imageUrl;
    imageUrl = await locater
        .get<UserController>()
        .uploadProfilePicture(File(imagePath));
    await HTTP_Requests.updateAvatarURL(currentUser.dbId.toString(), imageUrl);
    MainWidget.userData['CurrentUser'].avatarURl = imageUrl;
    setStateCallback();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    currentUser = MainWidget.userData['CurrentUser'];
    print("HEYEYERY "+ currentUser.avatarURl.toString());
    avatarURL = currentUser.avatarURl!=null ? currentUser.avatarURl
    : "https://thumbs.dreamstime.com/b/creative-vector-illustration-default-avatar-profile-placeholder-isolated-background-art-design-grey-photo-blank-template-mo-107388687.jpg";
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
              showAlert(),
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: MainTheme.fontXLarge,fontWeight: FontWeight.bold),
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
                                avatarURL))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            image = await ImagePicker.platform
                                .pickImage(source: ImageSource.gallery);
                            final tempDir = await getTemporaryDirectory();
                            final path = tempDir.path;
                            BinaryImages.Image decodedImage = BinaryImages.decodeImage(await image.readAsBytes());
                            BinaryImages.Image smallerImage = BinaryImages.copyResize(decodedImage, width: 150);
                            var compressedImage = new File('$path/img_temporary.jpg')..writeAsBytesSync(BinaryImages.encodeJpg(smallerImage, quality: 15));

                            if(image!=null)
                              LoadingDialog.showLoadingDialog(context, uploadImage(compressedImage.path), Text("Uploaded Image"), Text("Failed to upload image"),(){Navigator.pop(context);});
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
                      labelText: "Full Name" ,
                      hintText: "${currentUser?.userName}",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
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
                      hintText: "${currentUser?.phoneNumber}",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
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
                      //TODO update the username in firebase and database
                      submit();
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

  bool validate() {
    final form = formKey.currentState;
    //form.save(); ////////////////////check
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _warning = null;
                });
              },
            )
          ],
        ),
      );
    } else
      return SizedBox(
        height: 0,
      );
  }
  void submit() async {
    if (validate()) {
      await HTTP_Requests.updateUserName(currentUser.dbId.toString(), _name);
      await HTTP_Requests.updatePhoneNumber(currentUser.dbId.toString(), _phone);
      currentUser = MainWidget.userData['CurrentUser'];
    }
  }


}