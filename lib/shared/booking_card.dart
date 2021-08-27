import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/FavouriteTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:intl/intl.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';

class BookingCard extends StatefulWidget {
  final BookingModule module;
  final refreshFunction;
  const BookingCard({Key key, this.module, this.refreshFunction}) : super(key: key);

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {

  Future cancelBooking() async {
    await HTTP_Requests.deleteBooking(widget.module.id.toString());
    setState(() {
      widget.refreshFunction();
    });
  }

  Future sendRating(dynamic rating) async{
    await HTTP_Requests.updateRating(widget.module.serviceModule.propertyModule.id.toString(),rating);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.path, arguments: {
          'module': new MainModule(
              propertyModule: widget.module.serviceModule.propertyModule,
              service_id: widget.module.serviceModule.service_id,
              imgSrc: widget.module.serviceModule.imageUrls[0],
              price: int.parse(widget.module.serviceModule.price.toString()))
        });
      },
      child: Container(
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.module.serviceModule.imageUrls[0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: FavouriteTheme.borderRadius,
                          topLeft: FavouriteTheme.borderRadius,
                          bottomLeft: FavouriteTheme.borderRadius,
                          bottomRight: FavouriteTheme.borderRadius)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.module.serviceModule.propertyModule.title,
                              style: FavouriteTheme.titleTextStyle,
                            ),
                            Text(
                              "\$ ${widget.module.serviceModule.price}/night",
                              style: FavouriteTheme.priceTextStyle,
                            ),
                            Text(
                              widget
                                  .module.serviceModule.propertyModule.location,
                              style: FavouriteTheme.locationTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "FROM : " +
                                    DateFormat('yyyy-MM-dd')
                                        .format(widget.module.fromDate)
                                        .toString(),
                                style: FavouriteTheme.locationTextStyle
                            ),
                            Text(
                                "TO : " +
                                    DateFormat('yyyy-MM-dd')
                                        .format(widget.module.toDate)
                                        .toString(),
                                style: FavouriteTheme.locationTextStyle
                            ),
                            (DateTime.now().isBefore(widget.module.fromDate))? Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text("PENDING",style: TextStyle(color: MainTheme.mainColor),),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      onPressed: (){
                                        LoadingDialog.showLoadingDialog(
                                          context,
                                          cancelBooking(),
                                          Text("You've canceled the booking."),
                                          Text("A problem occured while canceling the booking."),
                                                (){}, (){},false
                                        );
                                      },
                                      child: Text("CANCEL",style: TextStyle(color: Colors.red)),
                                    ),
                                  ),
                                ],
                              ),
                            ): Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: TextButton(
                                onPressed: (){
                                  print("Try rate");
                                  LoadingDialog.showRatingDialog(context, sendRating);
                                },
                                child: Text("RATE",style: TextStyle(color: Colors.yellow[700]),)
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
