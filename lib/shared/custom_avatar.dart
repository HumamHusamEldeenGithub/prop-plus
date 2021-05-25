import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  final String avatarURL;
  final Function onTap;
  final double size;

  const Avatar({this.avatarURL, this.onTap , this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: avatarURL == null
          ? CircleAvatar(radius: size, child: Icon(Icons.photo_camera))
          : CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(avatarURL),
      ),
    );
  }
}