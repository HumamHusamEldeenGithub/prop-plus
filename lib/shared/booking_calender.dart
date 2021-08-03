import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCalender extends StatefulWidget {
  final ServiceModule serviceModule;
  const BookingCalender({Key key,this.serviceModule}) : super(key: key);

  @override
  _BookingCalenderState createState() => _BookingCalenderState();
}

class _BookingCalenderState extends State<BookingCalender> {

  List<DateTime> blackOutDates = <DateTime>[];
  List<BookingModule> bookingModules;

  Future<List<DateTime>> initailizeBlackOuts() async{
    List<DateTime> curBlackOutDates = <DateTime>[];
    bookingModules = await HTTP_Requests.getAllBookingForService(3.toString());
    debugPrint(bookingModules.length.toString());
    for(int i = 0;i < bookingModules.length;i++) {
      for (int j = 0; j <= bookingModules[i].toDate
          .difference(bookingModules[i].fromDate)
          .inDays; j++) {
        curBlackOutDates.add(bookingModules[i].fromDate.add(Duration(days: j)));
      }
    }
    debugPrint(curBlackOutDates.length.toString());
    for(int i = 0;i < curBlackOutDates.length;i++){
      debugPrint(curBlackOutDates[i].toString());
    }
    return curBlackOutDates;
  }


  void onSelectionChanged(DateRangePickerSelectionChangedArgs args){

  }

  @override
  void initState() {
    super.initState();
    initailizeBlackOuts().then((value) {
      setState(() {
        blackOutDates.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePicker(
          monthCellStyle: DateRangePickerMonthCellStyle(
            cellDecoration: BoxDecoration(
              color: Colors.white
            ),
            blackoutDateTextStyle: TextStyle(
              color: MainTheme.greyFontColor
            )
          ),
          monthViewSettings: DateRangePickerMonthViewSettings(
            blackoutDates: blackOutDates,
          ),
          onSelectionChanged: onSelectionChanged,
        )
    );
  }
}
