import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/category_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/property_to_approve_model.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/modules/user_properties_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'dart:developer' as developer;

import '../main.dart';

// ignore: camel_case_types
class HTTP_Requests {

  static String authorizationKey = "55b1cbe8-e38e-410f-842a-7f70dc4762cc";
  ////////////////////GET/////////////////////////

  static Future<ServiceModule> getService(
      int serviceId, PropertyModule propertyModule) async {
    http.Response response;
    response = await http.get(
      Uri.parse("https://propplus-production.herokuapp.com/services/" +
          serviceId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body);
    //print(data);
    ServiceModule module;
    var item = ServiceModule.fromJson(data, propertyModule);
    return item;
  }

  static Future<List> getRecommendedProperties() async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/properties/home",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    //print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getRecommendedPropertiesWithType(String type) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/properties/type/"+type,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    //print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getFavouriteServicesWithDetails(int userId) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/favourite_services/withDetails/" +
            userId.toString(),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    //print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getFavouriteServicesById(int userId) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/favourite_services/ByUserId/" +
            userId.toString(),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    List<int> list = <int>[];

    for (var i = 0; i < data.length; i++) {

      var item = data[i]['service_id'];
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getAllBookingForService(
      ServiceModule serviceModule) async {
    int serviceId = serviceModule.service_id;
    http.Response response;
    response = await http.get(
      Uri.parse(
          "https://propplus-production.herokuapp.com/bookings/service_id/" +
              serviceId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    print(data);
    List<BookingModule> list = <BookingModule>[];
    for (var i = 0; i < data.length; i++) {
      var item = BookingModule.fromJson(data[i], serviceModule);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getAllBookingsForUser(int userId) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/bookings/ByUserId/" +
            userId.toString(),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    print(data);
    List<BookingModule> list = <BookingModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var service = ServiceModule.fromJson2(data[i], property);
      var booking = BookingModule.fromJson(data[i], service);
      try {
        if (booking != null) list.add(booking);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List<ServiceModule>> getAllService(
      PropertyModule propertyModule) async {
    print(propertyModule.id);
    http.Response response;
    response = await http.get(
      Uri.parse(
          "https://propplus-production.herokuapp.com/services/ByPropertyId/" +
              propertyModule.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    print(data);
    List<ServiceModule> list = <ServiceModule>[];
    for (var i = 0; i < data.length; i++) {
      var item = ServiceModule.fromJson(data[i], propertyModule);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List<String>> getAllImagesForService(int id) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
          "https://propplus-production.herokuapp.com/images/ByServiceId/" +
              id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    List<String> list = <String>[];
    for (var i = 0; i < data.length; i++) {
      var item = data[i]['url'];
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getUserProperties(int id) async {
    print(id);
    http.Response response;
    response = await http.get(
      Uri.parse(
          "https://propplus-production.herokuapp.com/properties/ByUserId/" +
              id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    print(data);
    List<PropertyModule> list = <PropertyModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      print(property);
      try {
        if (property != null) list.add(property);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getSearchResult(String searchText) async {
    http.Response response;
    response = await http.post(
      Uri.parse(
        "https://propplus-production.herokuapp.com/properties/search",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, dynamic>{'searchText': searchText}),
    );
    var data = jsonDecode(response.body) as List;
    print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getTrendingProperties() async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/properties/home",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    //print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  static Future<List> getTrendingPropertiesWithType(String type) async {
    http.Response response;
    response = await http.get(
      Uri.parse(
        "https://propplus-production.herokuapp.com/properties/type/"+type,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    var data = jsonDecode(response.body) as List;
    //print(data);
    List<MainModule> list = <MainModule>[];
    for (var i = 0; i < data.length; i++) {
      var property = PropertyModule.fromJson(data[i]);
      var item = MainModule.fromJson(property, data[i]);
      try {
        if (item != null) list.add(item);
      } catch (e) {
        print(e);
      }
    }
    return list;
  }

  ////////////////////GET/////////////////////////

  ////////////////////SEND/////////////////////////

  static Future<dynamic> createNewUserInDB(
      String _name, String _phone, String _email, String userID) async {
    print(jsonEncode(<String, String>{
      'name': _name,
      'phone': _phone,
      'email': _email,
      'firebase_id': userID,
      'date_of_reg': DateTime.now().toString(),
    }));
    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, String>{
        'name': _name,
        'phone': _phone,
        'email': _email,
        'firebase_id': userID,
        'date_of_reg': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> content = jsonDecode(response.body);
      int id = int.parse(content['id'].toString());
      return id;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to users table  .');
    }
  }

  static Future<dynamic> addNewFavourite(
      String userId, String serviceId) async {
    print(userId);
    print(serviceId);
    final response = await http.post(
      Uri.parse(
          'https://propplus-production.herokuapp.com/favourite_services'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
        'service_id': serviceId,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("ADD NEW FAVOURITE TO USER : " + userId);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to Favourite table  .');
    }
  }

  static Future<dynamic> deleteFavourite(
      String userId, String serviceId) async {
    final response = await http.delete(
      Uri.parse(
          'https://propplus-production.herokuapp.com/favourite_services/ByUser_ServiceId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
        'service_id': serviceId,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to delete favorite service.');
    }
  }

  static Future<dynamic> deleteBooking(
      String bookingId) async {
    final response = await http.delete(
      Uri.parse(
          'https://propplus-production.herokuapp.com/booking/'+bookingId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to delete favorite service.');
    }
  }

  static Future<void> addNewServiceToDB(ServiceModule module) async {
    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/services'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, dynamic>{
        "property_id": module.propertyModule.id.toString(),
        "description": module.description,
        "price_per_night": module.price.toString(),
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Map<String, dynamic> newService = jsonDecode(response.body);
      dynamic newServiceId = newService['id'];

      String jsonUrls = "";
      for (int i = 1; i < module.imageUrls.length; i++) {
        jsonUrls += module.imageUrls.elementAt(i);
        if (i + 1 != module.imageUrls.length) jsonUrls += ",";
      }

      //TODO iterate over all images
      final imageResponse = await http.post(
        Uri.parse('https://propplus-production.herokuapp.com/images'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationKey,
        },
        body: jsonEncode(<String, dynamic>{
          'service_id': newServiceId,
          'url': jsonUrls,
          'main_url': module.imageUrls[0]
        }),
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
      throw Exception('Failed to post to services table  .');
    }
  }

  static Future getUserByFirebase(String firebaseId) async {
    http.Response response;
    response = await http.get(
      Uri.parse("https://propplus-production.herokuapp.com/users/ByFirebase/" +
          firebaseId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );

    var data = jsonDecode(response.body);
    UserModule userModule = UserModule.fromJson(data);
    return userModule;
  }

  static Future<bool> sendApprovalRequest(PropertyToApprove module) async {
    final response = await http.post(
      Uri.parse(
          'https://propplus-production.herokuapp.com/properties_to_approve'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, String>{
        'name': module.title,
        'user_id': module.user_id.toString(),
        'phone': module.phone,
        'description': module.description,
        'type': module.type
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> propToApprove = jsonDecode(response.body);
      var propToApproveId = propToApprove['id'];
      final location = await http.post(
        Uri.parse(
            'https://propplus-production.herokuapp.com/approve_locations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationKey,
        },
        body: jsonEncode(<String, String>{
          'property_id': propToApproveId.toString(),
          'city': module.city,
          'street': module.street,
        }),
      );

      //iterate over all photos url and create a string of urls to send it
      String jsonUrls = "";
      for (int i = 0; i < module.approvalImagesUrls.length; i++) {
        jsonUrls += module.approvalImagesUrls.elementAt(i);
        if (i + 1 != module.approvalImagesUrls.length) jsonUrls += ",";
      }
      final imageResponse = await http.post(
        Uri.parse('https://propplus-production.herokuapp.com/approval_images'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationKey,
        },
        body: jsonEncode(<String, dynamic>{
          'property_to_approve_id': propToApproveId.toString(),
          'url': jsonUrls
        }),
      );

      if ((imageResponse.statusCode == 201 ||
              imageResponse.statusCode == 200) &&
          (location.statusCode == 201 || location.statusCode == 200)) {
        print("Send Successfully");
        return true;
      } else {
        throw Exception('Failed to post to  approval_images table  .');
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }

  static Future<dynamic> sendBookRequest(
      String serviceId, String fromDate, String toDate) async {
    //TODO : get user's database id
    String userId = MainWidget.userData['CurrentUser'].dbId.toString();

    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/bookings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
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
      Map<String, dynamic> data = jsonDecode(response.body);
      var id = data['id'];
      return id ;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to  properties_to_approve table  .');
    }
  }
  static Future<void> sendPaymentRequest(
      String bookingId,  double amount,String type) async {
    final response = await http.post(
      Uri.parse('https://propplus-production.herokuapp.com/payments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, dynamic>{
        'booking_id': bookingId,
        'amount': amount.toString(),
        'payment_type': type,
        'payment_date': DateTime.now().toString(),
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


  static Future sendBookingEmailToTheOwner(
      String name,
      String email,
      String propertyName,
      String startDate,
      String endDate,
      String customerName,
      String customerPhone,
      String customerEmail,
      String totalPrice) async {
    final service_id = 'service_9jx63jf';
    final template_id = 'template_p9r61j9';
    final user_id = 'user_ajnKi0eDKQOl6ozAkEila';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'service_id': service_id,
          'template_id': template_id,
          'user_id': user_id,
          'template_params': {
            'user_name': name,
            'property_name': propertyName,
            'start_date': startDate,
            'end_date': endDate,
            'customer_name': customerName,
            'customer_email': customerEmail,
            'customer_phone': customerPhone,
            'total_price': totalPrice,
            'user_email': email,
          }
        }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
    }
  }

  static sendBookingEmailToCustomer(
      String customerName,
      String customerEmail,
      String propertyTitle,
      String serviceDescription,
      String startDate,
      String endDate,
      String totalPrice,
      String propertyPhone) async {
    final service_id = 'service_9jx63jf';
    final template_id = 'template_ieb35pm';
    final user_id = 'user_ajnKi0eDKQOl6ozAkEila';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'service_id': service_id,
          'template_id': template_id,
          'user_id': user_id,
          'template_params': {
            'customer_email': customerEmail,
            'property_name': propertyTitle,
            'start_date': startDate,
            'end_date': endDate,
            'customer_user_name': customerName,
            'property_phone}': propertyPhone,
            'total_price': totalPrice,
          }
        }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //TODO : return a flag to show succeeded widget
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
    }
  }
  static Future<dynamic> updateAvatarURL(
      String userId, String avatarURL) async {
    final response = await http.put(
      Uri.parse(
          'https://propplus-production.herokuapp.com/users/avatarURL/'+userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
      body: jsonEncode(<String, String>{
        'avatarURL': avatarURL,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post to Favourite table  .');
    }
  }


  static Future getUserById(String userId) async {
    http.Response response;
    response = await http.get(
      Uri.parse("https://propplus-production.herokuapp.com/users/" +
          userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationKey,
      },
    );

    var data = jsonDecode(response.body);
    UserModule userModule = UserModule.fromJson(data);
    return userModule;
  }

  ////////////////////SEND/////////////////////////



  static List createCategoriesModules() {
    List<CategoryModel> categoriesModules = <CategoryModel>[];
    categoriesModules.add(new CategoryModel(Icons.amp_stories_outlined, "All", true));
    categoriesModules.add(new CategoryModel(Icons.hotel, "Hotel", false));
    categoriesModules.add(new CategoryModel(Icons.star, "Top Rated ", false));
    categoriesModules
        .add(new CategoryModel(Icons.beach_access, "Beach", false));
    categoriesModules.add(
        new CategoryModel(Icons.attach_money_rounded, "Best Price", false));
    categoriesModules
        .add(new CategoryModel(Icons.house_sharp, "Villas", false));
    return categoriesModules;
  }
  static Future<dynamic> updatePhoneNumber(
      String userId, String phone) async {
    final response = await http.put(
        Uri.parse(
          'https://propplus-production.herokuapp.com/users/phone/'+userId),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationKey,
        },
          body: jsonEncode(<String, String>{
            'phone': phone,
          }),
        );
        if (response.statusCode == 201 ||  response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to upadte the phone number  .');
    }
  }
  static Future<dynamic> updateUserName(
      String userId, String name) async {
    final response = await http.put(
        Uri.parse(
          'https://propplus-production.herokuapp.com/users/name/'+userId),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationKey,
        },
          body: jsonEncode(<String, String>{
            'name': name,
          }),
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to post to Favourite table  .');
    }
  }
}


