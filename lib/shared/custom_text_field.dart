import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color secondaryColor; //border Color
  final Function validate;
  final IconData icon;
  final String hintText;
  String saved; // where  the value of the textField should  be stored

  CustomTextField({
    Key key,
    @required this.secondaryColor,
    @required this.validate,
    @required this.icon,
    @required this.hintText,
    @required this.saved,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child:TextFormField(
        validator: validate,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white , ),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            border: InputBorder.none

        ),
        onSaved: (value) => saved = value,
        obscureText: true,
      ),

    );
  }
}