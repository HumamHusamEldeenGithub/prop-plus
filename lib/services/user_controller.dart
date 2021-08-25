import 'dart:io';

import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/storage_repo.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'dart:developer' as developer;

class UserController{
  UserModule _currentUser;
  AuthService _authService =  locater.get<AuthService>();
  Future init;
  StorageRepo _storageRepo = locater.get<StorageRepo>();

  UserController(){
    init = InitializeUser();
    //getUserDBId() ;
  }

  Future<UserModule>InitializeUser() async{
     _currentUser = await _authService.getUserModule();
     _currentUser.dbId = await HTTP_Requests.getUserId(_currentUser.uid);
     return _currentUser;
  }

  Future<void>getUserDBId() async{
    _currentUser.dbId = await HTTP_Requests.getUserId(_currentUser.uid);
  }

  Future<String> uploadProfilePicture(File image) async{
    _currentUser.avatarURl = await _storageRepo.uploadProfilePhoto(image);
    return await _storageRepo.uploadProfilePhoto(image);
  }

  Future<String>getDownloadUrl() async{
    await _storageRepo .getUserProfileImageDownloadUrl(_currentUser.uid);
  }
  Future<String> uploadPropertyApprovalPhoto(File image) async{
    return await _storageRepo.uploadPropertyApprovalPhotos(image);
  }
  Future<String> uploadServicePhoto(File image) async{
    return await _storageRepo.uploadServicePic(image);
  }
  Future<String>signInWithEmailAndPassword (String email ,String password) async{
    _currentUser =await _authService.signInWithEmailAndPassword(email, password);
    return _currentUser.uid ;
    //TODO : check if null
   // _currentUser.avatarURl = await getDownloadUrl();
  }

  Future createUserWithEmailAndPassword(String email ,String password , String userName) async{
    _currentUser = await _authService.createUserWithEmailAndPassword(email, password, userName);
    developer.log(_currentUser.uid);
    int dbId = await HTTP_Requests.createNewUserInDB(userName,"",email,_currentUser.uid);
    _currentUser.dbId = dbId ;
    developer.log(_currentUser.dbId.toString());
    return _currentUser.uid;
  }

  signOut(){
    _authService.signOut();
  }


  UserModule get currentUser => _currentUser;

}