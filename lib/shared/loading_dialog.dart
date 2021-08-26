import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class LoadingDialog {
  static dynamic showLoadingDialog(BuildContext context,Future future,Widget title, Function onClose){
    showDialog(context: context, builder: (context){
      return FutureBuilder(future: future, builder: (context,snapshot){
        print(snapshot.connectionState);
        if(snapshot.connectionState == ConnectionState.done){
          return AlertDialog(
            title: title,
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