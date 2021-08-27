import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/screens/receipt_screen.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCalender extends StatefulWidget {
  final serviceModule;
  final blackOutDates;
  const BookingCalender({Key key, this.serviceModule, this.blackOutDates}) : super(key: key);

  @override
  _BookingCalenderState createState() => _BookingCalenderState();
}

class _BookingCalenderState extends State<BookingCalender> {
  DateRangePickerController _controller = DateRangePickerController();
  BookingModule bookingModule;


  DateTime startDateToBook;
  DateTime endDateToBook;
  DateTime curDate;



  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    startDateToBook = _controller.selectedRange.startDate;
    endDateToBook = _controller.selectedRange.endDate;
    if(_controller.selectedRange.startDate == null)
      return;
    curDate = DateTime.now();
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
      setState(() {

      });
      return;
    }
    if(endDateToBook!=null){
      for (int j = 0; j <= endDateToBook.difference(startDateToBook).inDays; j++){
        DateTime dateToIterate = startDateToBook.add(Duration(days: j));
        if(widget.blackOutDates.contains(dateToIterate)){
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
          setState(() {

          });
          return;
        }
      }
    }
    setState(() {

    });
  }

  void ContinueToReceipt(){
    bookingModule = new BookingModule(serviceModule: widget.serviceModule,fromDate: startDateToBook,toDate: endDateToBook);
    Navigator.pushNamed(context, ReceiptScreen.path,arguments: bookingModule);
  }

  @override
  Widget build(BuildContext context) {
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
              enablePastDates: false,
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
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                blackoutDates: widget.blackOutDates ,
              ),
              onSelectionChanged: onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
          Container(
            width: 100,
            height: 50,
            child: endDateToBook!=null? ElevatedButton(
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all<Color>(MainTheme.mainColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: ContinueToReceipt,
              child: Text("Continue",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            ) : SizedBox.shrink()
          )
        ],
      ),
    );
  }
}

