import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_repo.dart';
import 'locater.dart';

class StorageRepo{
  FirebaseStorage storage =FirebaseStorage.instanceFor(bucket: "gs://propplus-1613c.appspot.com") ;

  AuthService _authService = locater.get<AuthService>();

  Future<String> uploadProfilePhoto(File file ) async {
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("users/user_id:${userId}/profile_pic");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  Future<String>getUserProfileImageDownloadUrl(String uid) async{
    var storageRef = storage.ref().child("users/user_id:${uid}/profile_pic");
    return await storageRef.getDownloadURL();
  }


}