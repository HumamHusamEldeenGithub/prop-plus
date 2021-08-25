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
  List<DateTime> _blackOutDates = <DateTime>[];
  List<BookingModule> _bookingModules;
  DateRangePickerController _controller = DateRangePickerController();
  Future<void> initailizeBlackOuts() async {
    List<DateTime> curBlackOutDates = <DateTime>[];
    _bookingModules = await HTTP_Requests.getAllBookingForService(3.toString());
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
    curBlackOutDates.add(DateTime(2021,8,26));
    _blackOutDates=curBlackOutDates;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if(_controller.selectedRange.startDate == null)
      return;
    DateTime startDateToBook = _controller.selectedRange.startDate;
    DateTime endDateToBook = _controller.selectedRange.endDate;
    DateTime curDate = DateTime.now();
    curDate = DateTime(curDate.year,curDate.month,curDate.day);
    if(startDateToBook.isBefore(curDate)){
      _controller.selectedRange = PickerDateRange(null, null);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Invalid booking date'),
          content: Text("You can't choose a date before the current date!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close')
            ),
          ],
        );
      });
    }
    if(endDateToBook!=null){
      for (int j = 0; j <= endDateToBook.difference(startDateToBook).inDays; j++){
        DateTime dateToIterate = startDateToBook.add(Duration(days: j));
        print(dateToIterate);
        if(_blackOutDates.contains(dateToIterate)){
          _controller.selectedRange = PickerDateRange(null, null);
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text('Invalid booking date'),
              content: Text("Sorry you can't book in this range, Please choose different days!"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close')
                ),
              ],
            );
          });
          return;
        }
      }
    }


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
                        controller: _controller,
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
                              borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          blackoutDates: _blackOutDates ,
                        ),
                        onSelectionChanged: onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(MainTheme.mainColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: (){},
                        child: Text("Continue",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
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
