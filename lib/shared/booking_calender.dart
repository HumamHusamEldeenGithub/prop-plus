import 'package:flutter/material.dart';
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

  List<DateTime> blackOutDates;
  List<BookingModule> bookingModules;

  void initailizeBlackOuts() async{
    bookingModules = await HTTP_Requests.getAllBookingForService(widget.serviceModule.id.toString());
    for(int i = 0;i < bookingModules.length;i++) {
      for (int j = 0; j <= bookingModules[i].toDate
          .difference(bookingModules[i].fromDate)
          .inDays; j++) {
        blackOutDates.add(bookingModules[i].fromDate.add(Duration(days: j)));
      }
    }
  }


  void onSelectionChanged(DateRangePickerSelectionChangedArgs args){

  }

  @override
  Widget build(BuildContext context) {
    //initailizeBlackOuts();
    return BookingCalender(serviceModule: widget.serviceModule,
    );
  }
}
