import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class LoadingDialog extends StatefulWidget {
  final title;
  const LoadingDialog({Key key ,this.title}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        width: _width*0.5 ,
        height: _height*0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
              child: AutoSizeText(
                "${widget.title}",
                maxLines: 1 ,
              ),
            ),
            SizedBox(
              height: 10,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
