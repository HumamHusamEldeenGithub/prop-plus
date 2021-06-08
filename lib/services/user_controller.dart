import 'dart:io';

import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/storage_repo.dart';

class UserController{
  UserModule _currentUser;
  AuthService _authService =  locater.get<AuthService>();
  Future init;
  StorageRepo _storageRepo = locater.get<StorageRepo>();

  UserController(){
    init = InitializeUser();
  }

  Future<UserModule>InitializeUser() async{
     _currentUser = await _authService.getUserModule();
     return _currentUser;
  }


  Future<void> uploadProfilePicture(File image) async{
    _currentUser.avatarURl = await _storageRepo.uploadFile(image);
  }

  Future<String>getDownloadUrl() async{
    await _storageRepo .getUserProfileImageDownloadUrl(_currentUser.uid);
  }

  Future<void>signInWithEmailAndPassword (String email ,String password) async{
    _currentUser =await _authService.signInWithEmailAndPassword(email, password);
    _currentUser.avatarURl = await getDownloadUrl();
  }

  signOut(){
    _authService.signOut();
  }


  UserModule get currentUser => _currentUser;

}