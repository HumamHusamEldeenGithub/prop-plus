import 'dart:io';

import 'package:prop_plus/main.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/storage_repo.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'dart:developer' as developer;

class UserController{
  UserModule _currentUser;
  AuthService _authService =  locater.get<AuthService>();
  StorageRepo _storageRepo = locater.get<StorageRepo>();

  UserController(){
    InitializeUser();
    //getUserDBId() ;
  }

  Future<UserModule>InitializeUser() async{
     _currentUser = await _authService.getUserModule();
     _currentUser = await HTTP_Requests.getUserByFirebase(_currentUser.uid);
     UserModule newUser  = UserModule();
     newUser.dbId = _currentUser?.dbId;
     newUser.favouriteServices = await HTTP_Requests.getFavouriteServicesById(_currentUser.dbId);
     newUser.userName = _currentUser.userName;
     newUser.avatarURl = _currentUser.avatarURl;
     newUser.phoneNumber = _currentUser.phoneNumber;
     MainWidget.userData['CurrentUser'] = newUser;
     return _currentUser;
  }

  Future<void>getUserDBId() async{
    _currentUser.dbId = await HTTP_Requests.getUserByFirebase(_currentUser.uid);
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
    _currentUser.dbId = await HTTP_Requests.getUserByFirebase(_currentUser.uid);
    return _currentUser.uid ;
    //TODO : check if null
   // _currentUser.avatarURl = await getDownloadUrl();
  }

  Future createUserWithEmailAndPassword(String email ,String password , String userName) async{
    _currentUser = await _authService.createUserWithEmailAndPassword(email, password, userName);
    int dbId = await HTTP_Requests.createNewUserInDB(userName,"",email,_currentUser.uid);
    _currentUser.dbId = dbId ;
    _currentUser = await HTTP_Requests.getUserById(_currentUser.dbId.toString());
    return _currentUser.uid;
  }

  Future getUserFavourites() async{
    return await HTTP_Requests.getFavouriteServicesWithDetails(_currentUser.dbId);
  }

  signOut(){
    _authService.signOut();
  }


  UserModule get currentUser => _currentUser;

}