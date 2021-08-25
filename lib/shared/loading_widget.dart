import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {
  static showLoaderDialog(BuildContext context, String title) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
        content: Container(
      width: _width * 0.4,
      height: _height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7), child: AutoSizeText("${title}")),
        ],
      ),
    ));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showCustomDialog(BuildContext context, String title) {
    return AlertDialog(
      content: Text("${title} "),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homeScreen');
            },
            child: Text('Done')),
      ],
    );
  }
}
