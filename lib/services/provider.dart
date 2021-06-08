import 'package:flutter/material.dart';
import 'package:prop_plus/services/auth_repo.dart';

class Provider extends InheritedWidget{
  final AuthService auth ;
  Provider({Key key , Widget child , this.auth}) : super(key: key , child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
  static Provider of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);

}