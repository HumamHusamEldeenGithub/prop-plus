import 'package:flutter/material.dart';
import 'package:prop_plus/shared/booking_calender.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class BookingCalenderScreen extends StatefulWidget {

  static String path = "/booking_calender_screen" ;

  @override
  _BookingCalenderScreenState createState() => _BookingCalenderScreenState();
}

class _BookingCalenderScreenState extends State<BookingCalenderScreen> {



  @override
  Widget build(BuildContext context) {

    dynamic module = ModalRoute.of(context).settings.arguments;
    return BookingCalender(serviceModule: module,);
  }
}
