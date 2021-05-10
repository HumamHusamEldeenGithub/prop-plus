import "package:flutter/material.dart";
import 'package:photo_view/photo_view.dart';




class ViewImage extends StatelessWidget {
  final String imageUrl ;

  ViewImage({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
            child: PhotoView(
                imageProvider: AssetImage(imageUrl)
            )
        ),
      ),
    );
  }
}