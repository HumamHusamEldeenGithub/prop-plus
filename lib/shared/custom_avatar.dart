import 'package:flutter/material.dart';
class Avatar extends StatefulWidget {
  final String avatarURL;
  final Function onTap;
  final double size;

  const Avatar({this.avatarURL, this.onTap , this.size});

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.avatarURL == null
          ? CircleAvatar(radius: widget.size, child: Icon(Icons.photo_camera))
          : CircleAvatar(
        radius: widget.size,
        backgroundImage: NetworkImage(widget.avatarURL),
      ),
    );
  }
}