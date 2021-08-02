import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCalender extends StatefulWidget {
  final DateRangePickerSelectionChangedCallback onSelectionChanged;
  const BookingCalender({Key key,this.onSelectionChanged}) : super(key: key);

  @override
  _BookingCalenderState createState() => _BookingCalenderState();
}

class _BookingCalenderState extends State<BookingCalender> {
  DateRangePickerSelectionChangedCallback function;
  List<DateTime> blackOutDates;
  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      monthViewSettings: DateRangePickerMonthViewSettings(
        blackoutDates: blackOutDates,
      ),
      onSelectionChanged: widget.onSelectionChanged,
    );
  }
}
