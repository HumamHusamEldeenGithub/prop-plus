import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_repo.dart';
import 'locater.dart';
import 'package:file_support/file_support.dart';
import 'dart:developer' as developer;

class StorageRepo{
  FirebaseStorage storage =FirebaseStorage.instanceFor(bucket: "gs://propplus-1613c.appspot.com") ;

  AuthService _authService = locater.get<AuthService>();

  Future<String> uploadProfilePhoto(File file ) async {
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("users/user_id:${userId}/profile_pic/${DateTime.now()}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String>getUserProfileImageDownloadUrl(String uid) async{
    var storageRef = storage.ref().child("users/user_id:${uid}/profile_pic");
    return await storageRef.getDownloadURL();
  }

  Future<String> uploadPropertyApprovalPhotos(File file ) async {
    //developer.log(FileSupport().getFileNameWithoutExtension(file));
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("users/user_id:${userId}/approvalPhotos/${FileSupport().getFileNameWithoutExtension(file)}/${DateTime.now()}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadServicePic(File file ) async {
    //developer.log(FileSupport().getFileNameWithoutExtension(file));
    var userId = await _authService.getCurrentUID();
    var storageRef = storage.ref().child("users/user_id:${userId}/propetiesPics/${FileSupport().getFileNameWithoutExtension(file)}/${DateTime.now()}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }


}