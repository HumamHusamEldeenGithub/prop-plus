import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/FavouriteTheme.dart';
import 'package:prop_plus/modules/favourite_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/favourite_card.dart';
import 'package:prop_plus/shared/shimmer_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class Favourites extends StatefulWidget {
  Function parentFunction;
  Favourites({this.parentFunction, Key key}) : super(key: key);
  @override
  FavouritesState createState() => FavouritesState();
}

class FavouritesState extends State<Favourites> {

  bool _finishedLoading;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await widget.parentFunction();
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
    _finishedLoading = false;
    widget.parentFunction();
    setState(() {});
  }

  void finishLoading(){
    _finishedLoading = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _finishedLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: (_finishedLoading)
              ? Center(
                  child: (MainWidget.databaseData['FavouriteModules'] != null&& MainWidget.databaseData['FavouriteModules'].isNotEmpty) ?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        MainWidget.databaseData['FavouriteModules'].map((card) {
                      return FavouriteCard(
                          refreshFunction: refreshPage, module: card,);
                    }).toList(),
                  ):
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("You have no favourite services yet!"),
                    ),
                  )
                )
              : Container(
                  child: Card(
                      elevation: 8.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                                      shapeBorder: BorderRadius.circular(10),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ShimmerWidget.rectangle(
                                      width: 200,
                                      height: 10,
                                      shapeBorder: BorderRadius.circular(10),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ShimmerWidget.rectangle(
                                      width: 200,
                                      height: 10,
                                      shapeBorder: BorderRadius.circular(10),
                                    ),
                                  ],
                                ),
                              ])))),
        ),
      ),
    );
  }
}
