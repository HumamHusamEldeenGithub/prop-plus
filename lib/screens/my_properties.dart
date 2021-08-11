import 'package:flutter/material.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/user_properties_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/user_property_card.dart';




class MyProperties extends StatefulWidget {

  static String path = "/myProperties" ;

  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {

  List<MainModule> userPropertyModules = <MainModule>[];

  Future<List<MainModule>> getUserPropertiesFromDB() async {
    print(locater<UserController>().currentUser.dbId);
    var modules = await HTTP_Requests.getUserProperties(locater<UserController>().currentUser.dbId);
    // for (var i =0 ; i< modules.length ; i++){
    //   modules[i].imageUrls = await HTTP_Requests.getAllImagesForService(modules[i].service_id);
    // }
    return modules;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("My Properties"),
    //   ),
    //   body: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       children: userPropertyModules.map((card) {
    //         return UserPropertyCard(module: card);
    //       }).toList(),
    //     ),
    //   )
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("My Properties"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getUserPropertiesFromDB(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                MainModule module = snapshot.data[index];
                return UserPropertyCard(
                  module: module,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
