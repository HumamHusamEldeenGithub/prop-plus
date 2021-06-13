import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/trending_module.dart';
import 'package:prop_plus/shared/categories.dart';
import 'package:prop_plus/shared/property_card.dart';
import 'package:prop_plus/shared/trending_card.dart';
import 'package:prop_plus/modules/category_module.dart';
import 'package:prop_plus/constant/CategoryTheme.dart';
import 'package:http/http.dart' as http ;




class   Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<CategoryModel> categoriesModules = <CategoryModel>[];
  List<TrendingModule> trendingModules = <TrendingModule>[];
  List<PropertyModule> propertyModules = <PropertyModule>[];



  Future<void> getPropertiesFromDB() async{
    print("enter") ;
    http.Response response  ;
    response = await http.get(Uri.parse("https://prop-plus.herokuapp.com/services?full_details"));
    var data = jsonDecode(response.body) as List;
    print(data) ;
    setState(() {
      propertyModules =  data.map((json)  =>PropertyModule.fromJson(json)).toList() ;
    });
  }
  Future<PropertyModule> sendPropertyToDB() async {
    final response = await http.post(
      Uri.parse('https://prop-plus.herokuapp.com/properties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': 'Property title',
        'user_id' : '954' ,
        'phone' : '0954854618' ,
        'description' : 'Description' ,
        'rating' : '3.8'
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return PropertyModule.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }


  // Mock Functions
  void createPropertyModules() {
    propertyModules.add(new PropertyModule(id:0,title:"Luxury hotel",description: "Description - Description ",
        price:"100", imgSrc:"assets/real-state.jpg", rating:4,location:"Location - location"));
    propertyModules.add(new PropertyModule(id:0,title:"Luxury hotel",description: "Description - Description ",
        price:"100", imgSrc:"assets/banner1.jpg", rating:4,location:"Location - location"));
    propertyModules.add(new PropertyModule(id:0,title:"Luxury hotel",description: "Description - Description ",
        price:"100", imgSrc:"assets/real-state.jpg", rating:4,location:"Location - location"));
    propertyModules.add(new PropertyModule(id:0,title:"Luxury hotel",description: "Description - Description ",
        price:"100", imgSrc:"assets/real-state.jpg", rating:4,location:"Location - location"));
  }

  void createTrendingModules() {
    trendingModules.add(new TrendingModule("Luxury hotel", "Location - location",
        "100", "assets/real-state.jpg", 4,"Location - location"));
    trendingModules.add(new TrendingModule(
        "Luxury hotel", "Location - location", "100", "assets/banner1.jpg", 5,"Location - location"));
    trendingModules.add(new TrendingModule(
        "Luxury hotel", "Location - location", "100", "assets/img3.jpg", 3,"Location - location"));
    trendingModules.add(new TrendingModule("Luxury hotel", "Location - location",
        "100", "assets/real-state.jpg", 4,"Location - location"));
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
    //createPropertyModules();
    createTrendingModules();
    getPropertiesFromDB() ;
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // Categories
          Padding(
            padding: const EdgeInsets.all(MainTheme.pagePadding),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: CategoryTheme.descriptionFontSize, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: CategoryTheme.allHeight,
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
          Padding(
            padding: const EdgeInsets.all(MainTheme.pagePadding),
            child: Center(
              child: Text(
                "Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: trendingModules.map((card) {
                  return TrendingCard(module: card);
                }).toList(),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(MainTheme.pagePadding),
            child: Center(
              child: Text(
                "Recommended",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: propertyModules.map((card) {
                return PropertyCard(model: card);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
