import 'package:flutter/material.dart';
import 'package:prop_plus/modules/user_properties_module.dart';
import 'package:prop_plus/shared/user_property_card.dart';




class MyProperties extends StatefulWidget {

  static String path = "/myProperties" ;

  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {

  List<UserPropertyModule> userPropertyModules = <UserPropertyModule>[];

  void createPropertyModules() {
    userPropertyModules.add(new UserPropertyModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createPropertyModules();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Properties"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: userPropertyModules.map((card) {
            return UserPropertyCard(module: card);
          }).toList(),
        ),
      )
    );
  }
}
