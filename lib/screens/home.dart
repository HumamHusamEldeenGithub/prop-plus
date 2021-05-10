import 'package:flutter/material.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/trending_module.dart';
import 'package:prop_plus/shared/categories.dart';
import 'package:prop_plus/shared/real_state_card_standerd.dart';
import 'package:prop_plus/shared/trending_card.dart';
import 'package:prop_plus/modules/category_module.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesModules = <CategoryModel>[];
  List<TrendingModel> trendingModules = <TrendingModel>[];
  List<PropertyModel> propertyModules = <PropertyModel>[];

  // Mock Functions
  void createPropertyModules() {
    propertyModules.add(new PropertyModel("Luxury hotel",
        "Location - location ", "100", "assets/real-state.jpg", 4));
    propertyModules.add(new PropertyModel("Luxury hotel",
        "Location - location ", "100", "assets/banner1.jpg", 4));
    propertyModules.add(new PropertyModel(
        "Luxury hotel", "Location - location ", "100", "assets/img3.jpg", 4));
    propertyModules.add(new PropertyModel("Luxury hotel",
        "Location - location ", "100", "assets/real-state.jpg", 4));
  }

  void createTrendingModules() {
    trendingModules.add(new TrendingModel("Luxury hotel", "Location - location",
        "100", "assets/real-state.jpg", 4));
    trendingModules.add(new TrendingModel(
        "Luxury hotel", "Location - location", "100", "assets/banner1.jpg", 5));
    trendingModules.add(new TrendingModel(
        "Luxury hotel", "Location - location", "100", "assets/img3.jpg", 3));
    trendingModules.add(new TrendingModel("Luxury hotel", "Location - location",
        "100", "assets/real-state.jpg", 4));
  }

  void createCategoriesModules() {
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel2", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel3", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createCategoriesModules();
    createPropertyModules();
    createTrendingModules();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoriesModules.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        categoriesModules.forEach((element) {
                          element.isSelected = false;
                        });
                        categoriesModules[index].isSelected = true;
                      });
                    },
                    child: CategoryRadioButton(model: categoriesModules[index]),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Trending
            Text(
              "Trending",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),

            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: trendingModules.map((card) {
                    return TrendingCard(model: card);
                  }).toList(),
                )),
            SizedBox(
              height: 10,
            ),

            Text(
              "Recommended",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: propertyModules.map((card) {
                return PropertyCard(model: card);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
