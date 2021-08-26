import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class LoadingDialog {
  static bool _isSuccessful = false;
  static Future<void> _runFuture(Future future) async{
    try {
      await future;
    }
    catch(e){
      print(e);
      return;
    }
    _isSuccessful = true;
  }

  static dynamic showLoadingDialog(BuildContext context,Future future,Widget onSuccessTitle,Widget onFailedTitle, Function onClose){
    _isSuccessful = false;
    showDialog(context: context, builder: (context){
      return FutureBuilder(future: _runFuture(future), builder: (context,snapshot){
        print(snapshot.connectionState);
        if(snapshot.connectionState == ConnectionState.done){
          return AlertDialog(
            title: _isSuccessful? onSuccessTitle : onFailedTitle,
            content: TextButton(
              onPressed: onClose,
              child: Text("Close"),
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
    });
  }
}