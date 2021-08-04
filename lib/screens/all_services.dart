import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/shared/booking_card.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/service_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    print("ENTETR DB");
    dynamic prevModule = ModalRoute.of(context).settings.arguments;
    var modules = await HTTP_Requests.getAllService(prevModule);
    return modules;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Services"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllServicesFromDB(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
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
