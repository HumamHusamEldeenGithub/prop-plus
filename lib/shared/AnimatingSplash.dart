import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';

class AnimatingSplash extends StatefulWidget {
  const AnimatingSplash({Key key}) : super(key: key);

  @override
  AnimatingSplashState createState() => AnimatingSplashState();
}

class AnimatingSplashState extends State<AnimatingSplash> {

  Color backgroundColor = MainTheme.mainColor;

  void animate(){
    print("Animating");
    setState(() {
      if(backgroundColor == MainTheme.mainColor)
        backgroundColor = MainTheme.secondaryColor;
      else
        backgroundColor = MainTheme.mainColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      color: backgroundColor,
      child: Center(
          child: Center(
            child: Container(
              height: 200,
              width: 300,
              child: Image.asset("assets/logo.png")
            )
          )
      ),
      onEnd: (){
        animate();
      },
    );
  }
}
