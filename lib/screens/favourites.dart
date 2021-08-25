import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/modules/favourite_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/favourite_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class Favourites extends StatefulWidget {
  Function parentFunction;
  Favourites({this.parentFunction, Key key}) : super(key: key);
  @override
  FavouritesState createState() => FavouritesState();
}

class FavouritesState extends State<Favourites> {
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
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          child: MainWidget.databaseData['PropertyModules'] != null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        MainWidget.databaseData['FavouriteModules'].map((card) {
                      return FavouriteCard(refreshFunction:widget.parentFunction,module: card);
                    }).toList(),
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
