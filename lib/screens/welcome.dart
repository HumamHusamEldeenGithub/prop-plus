import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prop_plus/modules/property_module.dart';



class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            /*image: DecorationImage(
              image:AssetImage("images/room3.jpg"),
              fit: BoxFit.cover,
            )*/
          color: Colors.lightBlue,
        ),
        child: Column(
          children: [
            SizedBox(height: _height*0.1),
            Text(
              "WELCOME",
              style: TextStyle(fontSize: 40 , color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _height*0.15),
            AutoSizeText(
              "Prop+ : Make your perfect Trip ..",
              style: TextStyle(fontSize: 35, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: _height*0.1),

            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child:Padding(
                padding: const EdgeInsets.only(top:15,bottom: 15,left: 30,right: 30),
                child: Text("Get Started",style: TextStyle(color:Colors.lightBlue,fontSize: 20),),
              ),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title:"Would you like to create a free account ?" ,
                      description:"" ,
                      primaryButtonText: "Create an account ",
                      primaryButtonRoute: "/signUp",
                      secondaryButtonRoute: "/anonymousScreen",
                    )
                );
              },
            ),

            SizedBox(height: _height*0.1),
            FlatButton(
              child: Text("Sign in", style: TextStyle(color: Colors.white,fontSize: 20),),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/signIn');
              },

            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title,
      description,
      primaryButtonText,
      secondaryButtonText,
      primaryButtonRoute, // where the user should go if he click the primaryButton
      secondaryButtonRoute; // where the user should go if he click the SecondaryButton

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.primaryButtonText,
    @required this.primaryButtonRoute,
    this.secondaryButtonText,
    this.secondaryButtonRoute
  });
  static const double padding = 20.0;
  final primaryColor = Colors.blue;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),

      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(0.0,10.0)
                  )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24.0),

                AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 24.0),

                AutoSizeText(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: primaryColor
                  ),
                ),
                SizedBox(height: 24.0),

                RaisedButton(
                  color:primaryColor ,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: AutoSizeText(
                    primaryButtonText,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(primaryButtonRoute);
                  },
                ),
                SizedBox(height: 24.0),

                ShowSecondaryButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  ShowSecondaryButton(BuildContext context) {
    if(secondaryButtonText!=null && secondaryButtonRoute!=null)
      return FlatButton(
        child: AutoSizeText(
          secondaryButtonText,
          maxLines: 1,
          style: TextStyle(
              fontSize: 18.0,
              color: primaryColor,
              fontWeight: FontWeight.w400
          ),
        ),
        onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
        },
      );
    else
      return SizedBox(height: 24.0);
  }
}


