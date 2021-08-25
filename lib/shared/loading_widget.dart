import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {

  static showLoaderDialog(BuildContext context, String title) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7), child: Text("${title}")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showCustomDialog(BuildContext context , String title){
    return AlertDialog(
      content: Text("${title} "),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homeScreen');
            },
            child: Text('Done')
        ),
      ],
    );
  }
}
