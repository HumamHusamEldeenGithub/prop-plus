import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCalender extends StatefulWidget {
  final ServiceModule serviceModule;
  const BookingCalender({Key key, this.serviceModule}) : super(key: key);

  @override
  _BookingCalenderState createState() => _BookingCalenderState();
}

class _BookingCalenderState extends State<BookingCalender> {
  List<DateTime> blackOutDates = <DateTime>[];
  List<BookingModule> bookingModules;
  bool initialized = false;
  Future<void> initailizeBlackOuts() async {
    initialized = true;
    List<DateTime> curBlackOutDates = <DateTime>[];
    bookingModules = await HTTP_Requests.getAllBookingForService(3.toString());
    for (int i = 0; i < bookingModules.length; i++) {
      for (int j = 0;
          j <=
              bookingModules[i]
                  .toDate
                  .difference(bookingModules[i].fromDate)
                  .inDays;
          j++) {
        curBlackOutDates.add(bookingModules[i].fromDate.add(Duration(days: j)));
      }
    }
    curBlackOutDates.add(DateTime(2021,8,15));
    curBlackOutDates.add(DateTime(2021,8,16));
    curBlackOutDates.add(DateTime(2021,8,17));
    blackOutDates=curBlackOutDates;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

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
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                          "Please choose the range of time you would like to book this service",
                          style: TextStyle(fontSize: MainTheme.fontMedium),
                      ),
                    ),
                    Container(
                      height: 500,
                      child: SfDateRangePicker(
                        startRangeSelectionColor: MainTheme.mainColor,
                        endRangeSelectionColor: MainTheme.mainColor,
                        rangeSelectionColor: Color(0x6400B9FF),
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          cellDecoration: BoxDecoration(color: Colors.white,shape: BoxShape.rectangle),
                          blackoutDateTextStyle: TextStyle(color: Colors.white),
                          blackoutDatesDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xFFA86A6A),
                              borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          blackoutDates: blackOutDates ,
                        ),
                        onSelectionChanged: onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                    ),
                    Container(
                      width: 70,
                      child: FloatingActionButton(
                        backgroundColor: MainTheme.mainColor,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Text("Book Now",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                      )
                    )
                  ],
                ),
              );
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          }
        )
    );
  }
}
