import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final String title;
  final String content;
 // final List<Widget> actions;

  Popup({
    this.title,
    this.content,
   // this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Result'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Done"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}