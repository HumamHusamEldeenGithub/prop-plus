import 'package:flutter/material.dart';
import 'package:prop_plus/modules/favourite_module.dart';
import 'package:prop_plus/shared/favourite_card.dart';

// new TrendingModule(
// "Luxury hotel",
// "Location - location",
// "100",
// "assets/real-state.jpg",
// 4,
// "Location - location"));

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<FavouriteModule> favouriteModules = <FavouriteModule>[];

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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: favouriteModules.map((card) {
            return FavouriteCard(module: card);
          }).toList(),
        ),
      ),
    );
  }
}
