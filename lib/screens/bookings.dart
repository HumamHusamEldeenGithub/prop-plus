import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/shared/booking_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Bookings extends StatefulWidget {
  Function parentFunction;
  Bookings({this.parentFunction,Key key}) : super(key: key);
  @override
  BookingsState createState() => BookingsState();
}

class BookingsState extends State<Bookings> {
  List<BookingModule> bookingsModules = <BookingModule>[];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await widget.parentFunction();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }
  void refreshPage() {
    setState(() {});
  }

  void createBookingModules() {
    bookingsModules.add(new BookingModule(
        id: 1,
        title: "Luxury hotel",
        description: "Description - description",
        price: 100,
        imgSrc: "assets/real-state.jpg",
        location: "Location - location",
        fromDate: DateTime.parse("2021-01-01"),
        toDate: DateTime.parse("2021-01-05")
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //createBookingModules();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: bookingsModules.map((card) {
              return BookingCard(module: card);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
