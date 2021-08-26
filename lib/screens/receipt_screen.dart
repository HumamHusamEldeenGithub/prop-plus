import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'package:prop_plus/shared/loading_widget.dart';
import 'package:prop_plus/shared/receipt.dart';

class ReceiptScreen extends StatefulWidget {
  static final path = "/receipt";
  ReceiptScreen({Key key}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  BookingModule bookingModule;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendBooking() async{
    LoadingDialog.showLoadingDialog(
        context,
        HTTP_Requests.sendBookRequest(bookingModule.serviceModule.service_id.toString(), bookingModule.fromDate.toString(), bookingModule.toDate.toString()),
        Text("Booked successfully!",textAlign: TextAlign.center,),
        (){
          Navigator.pushReplacementNamed(context, '/homeScreen');
        }
    );
   }

  @override
  Widget build(BuildContext context) {
    bookingModule = ModalRoute.of(context).settings.arguments;
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
      bottomNavigationBar: Container(
        height: 45,
        child: ElevatedButton(
          onPressed: sendBooking,
          child: Text("Book now",),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(MainTheme.mainColor)),
        ),
      ),
      body: Receipt(bookingModule: bookingModule)
    );
  }
}
