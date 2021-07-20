import 'package:flutter/material.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/shared/booking_card.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List<BookingModule> bookingsModules = <BookingModule>[];

  void createBookingModules() {
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
    bookingsModules.add(new BookingModule(
        "Luxury hotel",
        "Location - location",
        "100",
        "assets/real-state.jpg",
        4,
        "Location - location",
        "1/1/2021",
        "5/1/2021"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBookingModules();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: bookingsModules.map((card) {
            return BookingCard(module: card);
          }).toList(),
        ),
      ),
    );
  }
}
