import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/main.dart';
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

  Future makeBookingProcess() async {
    dynamic bookingId = await HTTP_Requests.sendBookRequest(
        bookingModule.serviceModule.service_id.toString(),
        bookingModule.fromDate.toString(),
        bookingModule.toDate.toString());
    double totalPrice = 0;
    for (int i = 0;
        i <= bookingModule.toDate.difference(bookingModule.fromDate).inDays;
        i++) {
      totalPrice += bookingModule.serviceModule.price;
    }
    try {
      await HTTP_Requests.sendPaymentRequest(
          bookingId.toString(), totalPrice, 0.toString());
      await HTTP_Requests.sendBookingEmailToCustomer(
          MainWidget.userData['CurrentUser'].userName,
          MainWidget.userData['CurrentUser'].email,
          bookingModule.serviceModule.propertyModule.title,
          bookingModule.serviceModule.description,
          bookingModule.fromDate.toString(),
          bookingModule.toDate.toString(),
          totalPrice.toString(),
          bookingModule.serviceModule.propertyModule.phone);
      UserModule owner = await HTTP_Requests.getUserByPropertyId(bookingModule.serviceModule.propertyModule.id.toString()) ;
      await HTTP_Requests.sendBookingEmailToTheOwner(
        owner.userName,
        owner.email,
        bookingModule.serviceModule.propertyModule.title,
        bookingModule.fromDate.toString(),
        bookingModule.toDate.toString(),
        MainWidget.userData['CurrentUser'].userName,
        MainWidget.userData['CurrentUser'].phoneNumber,
        MainWidget.userData['CurrentUser'].email,
        totalPrice.toString(),
      );
    } catch (e) {
      await HTTP_Requests.deleteBooking(bookingId.toString());
      throw e;
    }
  }

  Future<void> sendBooking() async {
    LoadingDialog.showLoadingDialog(
        context,
        makeBookingProcess(),
        Text("Booked successfully!"),
        Text("There was a problem booking, please try again."), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }, () {
      Navigator.of(context).pop(context);
    }, true);
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
            child: Text(
              "Book now",
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(MainTheme.mainColor)),
          ),
        ),
        body: Receipt(bookingModule: bookingModule));
  }
}
