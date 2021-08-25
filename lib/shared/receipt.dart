
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';

class Receipt extends StatefulWidget {
  static final path = "/receipt";
  final DateTime startDate,endDate;
  final pricePerNight;
  final serviceModule;
  Receipt({Key key,this.startDate,this.endDate,this.pricePerNight,this.serviceModule}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {

  UserModule user;
  double totalPrice;
  @override
  void initState() {
    super.initState();
    user = locater.get<UserController>().currentUser;
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
      body: Column(
          children: [
            Text(widget.serviceModule.propertyModule.title)
          ]
      ),
    );
  }
}
