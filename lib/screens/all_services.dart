import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/shared/booking_card.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/service_card.dart';
import 'package:prop_plus/shared/shimmer_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_new_service_screen.dart';

class AllServices extends StatefulWidget {
  static String path = "/all_services";

  AllServices({Key key}) : super(key: key);
  @override
  AllServicesState createState() => AllServicesState();
}

class AllServicesState extends State<AllServices> {
  List<MainModule> bookingsModules = <MainModule>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void refreshPage() {
    setState(() {});
  }

  Future<List<ServiceModule>> getAllServicesFromDB() async {
    dynamic args = ModalRoute.of(context).settings.arguments as Map;
    dynamic prevModule = args['module'];
    var modules = await HTTP_Requests.getAllService(prevModule);
    for (var i = 0; i < modules.length; i++) {
      modules[i].imageUrls =
          await HTTP_Requests.getAllImagesForService(modules[i].service_id);
    }
    return modules;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments as Map;
    bool showAddService = args['showAddService'];
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                MainTheme.mainColor,
                MainTheme.secondaryColor,
              ],
            ),
          ),
        ),
        title: Text("All Services"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllServicesFromDB(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.data == null) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ShimmerWidget.rectangle(
                      width: _width * 0.97,
                      height: 200,
                      shapeBorder: BorderRadius.circular(10),
                    ),
                  );
                },
              );
              ;
            }
            return ListView.builder(
              itemCount: snapshot.data.length + (showAddService ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == snapshot.data.length)
                  return Center(
                    child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushNamed(
                              context, AddNewServiceScreen.path,
                              arguments: args['module'])
                        },
                        child: Text('Add a new Service')),
                  );
                ServiceModule module = snapshot.data[index];
                return ServiceCard(
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
