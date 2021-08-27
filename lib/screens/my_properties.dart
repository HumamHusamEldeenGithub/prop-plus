import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/favourite_card.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/shimmer_widget.dart';
import 'package:prop_plus/shared/user_property_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class MyProperties extends StatefulWidget {
  static String path = "/myProperties";

  @override
  _MyPropertiesState createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  List<MainModule> userPropertyModules = <MainModule>[];

  Future<List<PropertyModule>> getUserPropertiesFromDB() async {
    var modules = await HTTP_Requests.getUserProperties(
        MainWidget.userData['CurrentUser'].dbId);
    return modules;
  }

  dynamic prevModule;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    //await widget.parentFunction();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    refreshPage();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void refreshPage() {
    // widget.parentFunction();
    setState(() {});
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
      ),
      body: Center(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: FutureBuilder(
            future: getUserPropertiesFromDB(),
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.data == null) {
                return Container(
                    child: Card(
                        elevation: 8.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerWidget.rectangle(
                                    width: 100,
                                    height: 100,
                                    shapeBorder: BorderRadius.circular(8),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ShimmerWidget.rectangle(
                                        width: 200,
                                        height: 10,
                                        shapeBorder:
                                        BorderRadius.circular(10),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ShimmerWidget.rectangle(
                                        width: 200,
                                        height: 10,
                                        shapeBorder:
                                        BorderRadius.circular(10),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ShimmerWidget.rectangle(
                                        width: 200,
                                        height: 10,
                                        shapeBorder:
                                        BorderRadius.circular(10),
                                      ),
                                    ],
                                  ),
                                ]))));
              }
              return snapshot.data.length != 0? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  PropertyModule module = snapshot.data[index];
                  return UserPropertyCard(
                    module: module,
                  );
                },
              ) : Center(
                  child: Text("You have no properties yet!")
              );
            },
          ),
        ),
      ),
    );
  }
}
