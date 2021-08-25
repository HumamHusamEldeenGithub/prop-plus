import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/shared/booking_calender.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class BookingCalenderScreen extends StatefulWidget {

  static String path = "/booking_calender_screen" ;

  @override
  _BookingCalenderScreenState createState() => _BookingCalenderScreenState();
}

class _BookingCalenderScreenState extends State<BookingCalenderScreen> {

  ServiceModule serviceModule;

  List<DateTime> _blackOutDates = <DateTime>[];
  List<BookingModule> _bookingModules;
  Future<void> initailizeBlackOuts() async {
    serviceModule = ModalRoute.of(context).settings.arguments;
    List<DateTime> curBlackOutDates = <DateTime>[];
    _bookingModules = await HTTP_Requests.getAllBookingForService(serviceModule);
    for (int i = 0; i < _bookingModules.length; i++) {
      for (int j = 0;
      j <=
          _bookingModules[i]
              .toDate
              .difference(_bookingModules[i].fromDate)
              .inDays;
      j++) {
        curBlackOutDates.add(_bookingModules[i].fromDate.add(Duration(days: j)));
      }
    }
    _blackOutDates = curBlackOutDates;
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
      body: FutureBuilder(
        future: initailizeBlackOuts(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
            return BookingCalender(serviceModule: serviceModule,blackOutDates: _blackOutDates,);
          else
            return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
