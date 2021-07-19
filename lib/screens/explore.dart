import 'package:flutter/material.dart';




class Explore extends StatefulWidget {

  static String path = "/explore" ;

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {



  @override
  Widget build(BuildContext context) {

    String searchText = ModalRoute.of(context).settings.arguments as String ;

    return Scaffold(
      appBar: AppBar(
        title: Text("Results for " + searchText),
      ),
      body: Center(
        child: Text("Search Page " + searchText),
      ),
    );
  }
}
