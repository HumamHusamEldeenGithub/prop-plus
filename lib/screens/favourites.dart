import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/modules/favourite_module.dart';
import 'package:prop_plus/shared/favourite_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// new TrendingModule(
// "Luxury hotel",
// "Location - location",
// "100",
// "assets/real-state.jpg",
// 4,
// "Location - location"));

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);
  @override
  FavouritesState createState() => FavouritesState();
}

class FavouritesState extends State<Favourites> {
  List<FavouriteModule> favouriteModules = <FavouriteModule>[];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }
  void refreshPage() {
    setState(() {});
  }

  void createFavouriteModules() {
    favouriteModules.add(new FavouriteModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
    favouriteModules.add(new FavouriteModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/banner1.jpg",
        5,
        "Location - location"));
    favouriteModules.add(new FavouriteModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/img3.jpg",
        3,
        "Location - location"));
    favouriteModules.add(new FavouriteModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
    favouriteModules.add(new FavouriteModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
    favouriteModules.add(new FavouriteModule(
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
    createFavouriteModules();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: favouriteModules.map((card) {
              return FavouriteCard(module: card);
            }).toList(),
          ),
        ),
      ) ,
    );
  }
}
