import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prop_plus/services/provider.dart';
class AnonymousScreen extends StatefulWidget {

  @override
  _AnonymousScreenState createState() => _AnonymousScreenState();
}

class _AnonymousScreenState extends State<AnonymousScreen> {

  Future submitAnonymous() async{
    final auth = Provider.of(context).auth;
    auth.signInAnonymously();
    Navigator.of(context).pushReplacementNamed('/homeScreen');
  }

  @override
  Widget build(BuildContext context) {
    submitAnonymous();
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(color:Colors.white),
          Text("Loading..",style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}


