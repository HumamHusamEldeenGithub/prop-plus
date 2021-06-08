import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_repo.dart';
import 'locater.dart';

class StorageRepo{
  FirebaseStorage storage =FirebaseStorage.instanceFor(bucket: "gs://propplus-1613c.appspot.com") ;

  AuthService _authService = locater.get<AuthService>();

  Future<String> uploadFile(File file ) async {
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("user/profile/${userId}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String>getUserProfileImageDownloadUrl(String uid) async{
    var storageRef = storage.ref().child('user/profile/$uid');
    return await storageRef.getDownloadURL();
  }

}