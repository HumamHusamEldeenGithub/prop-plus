import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/category_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/property_to_approve_model.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'dart:developer' as developer;

// ignore: camel_case_types
class HTTP_Requests {
  static Future<List> getPropertiesFromDB() async {
    http.Response response;
    response = await http.get(
        Uri.parse("https://propplus-production.herokuapp.com/properties/home"));
    var data = jsonDecode(response.body) as List;
    print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {

      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property,data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<void> sendApprovalRequest(PropertyToApprove model) async {

    final response = await http.post(
      Uri.parse(
          'https://propplus-production.herokuapp.com/properties_to_approve'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': model.title,
        'user_id': model.user_id.toString(),
        'phone': model.phone,
        'description': model.description,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      developer.log("1");
      Map<String, dynamic> propToApprove = jsonDecode(response.body);

      var propToApproveId = propToApprove['id'];

      ///////////////////////
      //Template
      //iterate over all photos url and create a string of urls to send it 
      String jsonUrls = "";
      for(int i=0;i<model.approvalImagesUrls.length;i++){
        jsonUrls+=model.approvalImagesUrls.elementAt(i);
        if(i+1!=model.approvalImagesUrls.length)
        jsonUrls+=",";
      }
      developer.log(jsonUrls);
      //////////////////////
      //TODO iterate over all images
      final imageResponse = await http.post(
        Uri.parse('https://propplus-production.herokuapp.com/approval_images'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'property_to_approve_id': propToApproveId.toString(), 'url':jsonUrls }),
      );

      if (imageResponse.statusCode == 201 || response.statusCode == 200) {
        developer.log("2");
      } else {
        throw Exception('Failed to post to  approval_images table  .');
      }
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }

  static Future<void> sendBookRequest(
      String serviceId, String fromDate, String toDate) async {
    //TODO : get user's database id
    String userId = locater.get<UserController>().currentUser.dbId.toString();

    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/bookings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'service_id': serviceId,
        'user_id': userId,
        'start_date': fromDate,
        'end_date': toDate,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }

  static Future<List> getAllBookingForService(String serviceId) async {
    http.Response response;
    response = await http.get(
        Uri.parse("https://propplus-production.herokuapp.com/bookings/service_id%22"));
            var data = jsonDecode(response.body) as List;
        print(data);
    List<BookingModule> list = <BookingModule>[];
    for (var i = 0; i < data.length; i++) {
      var item = BookingModule.fromJson(data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }




  static Future<ServiceModule> getService(int serviceId,PropertyModule propertyModule) async {
    http.Response response;
    response = await http.get(
        Uri.parse("https://propplus-production.herokuapp.com/services/" + serviceId.toString()));
    var data = jsonDecode(response.body) as List;
    print(data);
    ServiceModule module;
      var item = ServiceModule.fromJson(data[0],propertyModule);
    return item;
  }


  static Future<void> addNewServiceToDB(propInfo) async {
    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/services'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: propInfo,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Map<String, dynamic> newService = jsonDecode(response.body);
      dynamic newServiceId = newService['id'];
      print("DONE");

      //TODO iterate over all images
      final imageResponse = await http.post(
        Uri.parse('https://propplus-production.herokuapp.com/images'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'service_id': newServiceId, 'url': "URLS"}),
      );
      if (imageResponse.statusCode == 201 || response.statusCode == 200) {
      } else {
        throw Exception('Failed to post to  images table  .');
      }
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }
  static Future<int> getUserId(String firebaseId) async {
    http.Response response;
    response = await http.get(
        Uri.parse("https://propplus-production.herokuapp.com/users/ByFirebase/"+firebaseId));
    var data = jsonDecode(response.body) ;
    print(data);
    return data['id'];
  }



  // Mock Functions
  /*
  static List createPropertyModules() {
    List<PropertyModule> propertyModules = <PropertyModule>[];
    propertyModules.add(new PropertyModule(
        id: 0,
        title: "Luxury hotel",
        description: "Description - Description ",
        price: "100",
        imgSrc:
            "https://i.pinimg.com/originals/70/0b/65/700b65aa1565bbcb40b68b72ca2df192.jpg",
        rating: 4,
        location: "Location - location"));
    propertyModules.add(new PropertyModule(
        id: 0,
        title: "Luxury hotel",
        description: "Description - Description ",
        price: "100",
        imgSrc:
            "https://i.pinimg.com/originals/70/0b/65/700b65aa1565bbcb40b68b72ca2df192.jpg",
        rating: 4,
        location: "Location - location"));
    propertyModules.add(new PropertyModule(
        id: 0,
        title: "Luxury hotel",
        description: "Description - Description ",
        price: "100",
        imgSrc:
            "https://i.pinimg.com/originals/70/0b/65/700b65aa1565bbcb40b68b72ca2df192.jpg",
        rating: 4,
        location: "Location - location"));
    propertyModules.add(new PropertyModule(
        id: 0,
        title: "Luxury hotel",
        description: "Description - Description ",
        price: "100",
        imgSrc:
            "https://i.pinimg.com/originals/70/0b/65/700b65aa1565bbcb40b68b72ca2df192.jpg",
        rating: 4,
        location: "Location - location"));
    return propertyModules;
  }

  static List createTrendingModules() {
    List<TrendingModule> trendingModules = <TrendingModule>[];
    trendingModules.add(new TrendingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
    trendingModules.add(new TrendingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/banner1.jpg",
        5,
        "Location - location"));
    trendingModules.add(new TrendingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/img3.jpg",
        3,
        "Location - location"));
    trendingModules.add(new TrendingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location"));
    return trendingModules;
  }

  */
  static List createCategoriesModules() {
    List<CategoryModel> categoriesModules = <CategoryModel>[];
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel2", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel3", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel4", false));
    return categoriesModules;
  }
}
