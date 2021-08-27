import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';

class AnimatingSplash extends StatefulWidget {
  const AnimatingSplash({Key key}) : super(key: key);

  @override
  AnimatingSplashState createState() => AnimatingSplashState();
}

class AnimatingSplashState extends State<AnimatingSplash> {
  Color backgroundColor = MainTheme.mainColor;
  double _opacity = 0;
  void animate() {
    setState(() {
      if (backgroundColor == MainTheme.mainColor)
        backgroundColor = MainTheme.secondaryColor;
      else
        backgroundColor = MainTheme.mainColor;
    });
  }

  Future<void> finishSplash() async{
    setState(() {
      _opacity = 1;
    });
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 600),
        color: backgroundColor,
        child: Center(
            child: Center(
                child: Container(
                    height: 200,
                    width: 300,
                    child: Image.asset("assets/logo.png")))),
        onEnd: () {
          animate();
        },
      ),
      AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _opacity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black
          ),
        )
      )
    ]);
  }
}
