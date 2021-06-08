import 'package:flutter/material.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/shared/property_card.dart';
import 'package:prop_plus/modules/property_module.dart';
class Description extends StatefulWidget {

  static String path = "/description" ;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {


  @override
  Widget build(BuildContext context) {

    PropertyModule module = ModalRoute.of(context).settings.arguments as PropertyModule ;


    return Scaffold(
      appBar: AppBar(
        title: Text("HI"),
      ),
      body: Center(
        child: PropertyCard(module: module,),
      ),
    );
  }
}
