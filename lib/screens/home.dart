import 'package:flutter/material.dart';
import 'package:prop_plus/shared/categories.dart';
import 'package:prop_plus/shared/real_state_card_standerd.dart';
import 'package:prop_plus/shared/trending_card.dart';

class Home extends StatelessWidget {
  List<Widget> getPropertyCard() {
    return [
      Text(
        "Recommended",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20,
      ),
      PropertyCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/real-state.jpg",
        rating: 5,
      ),
      PropertyCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/banner1.jpg",
        rating: 5,
      ),
      PropertyCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/real-state.jpg",
        rating: 5,
      ),
      PropertyCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/img3.jpg",
        rating: 5,
      ),
      PropertyCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/banner1.jpg",
        rating: 5,
      ),
    ];
  }

  List<Widget> getTrendingCards() {
    return [
      TrendingCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/real-state.jpg",
        rating: 5,
      ),
      TrendingCard(
        title: "Title 2",
        description: "Description 2 ",
        price: "80",
        imgSrc: "assets/banner1.jpg",
        rating: 4.2,
      ),
      TrendingCard(
        title: "Title 3",
        description: "Description 3 ",
        price: "550",
        imgSrc: "assets/img3.jpg",
        rating: 3,
      ),
      TrendingCard(
        title: "Title 1 ",
        description: "Description 1 ",
        price: "100",
        imgSrc: "assets/real-state.jpg",
        rating: 5,
      ),
    ];
  }

  List<Widget> getCategories()
  {
    return [
      Category(),
      Category(),
      Category(),
      Category(),
      Category(),
      Category(),
      Category(),
      Category(),

    ] ;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: getCategories(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Trending",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: getTrendingCards(),
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getPropertyCard(),
            ),
          ),
        ],
      ),
    );
  }
}
