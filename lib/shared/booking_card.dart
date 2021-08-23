
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/FavouriteTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:intl/intl.dart';
import 'package:prop_plus/screens/description.dart';



class BookingCard extends StatefulWidget {
  final dynamic module ;
  const BookingCard({Key key,this.module}) : super(key: key);

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {

  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, DetailsScreen.path,arguments: widget.module) ;
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
                        image: AssetImage("assets/real-state.jpg"),
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
                              widget.module.title,
                              style: FavouriteTheme.titleTextStyle,
                            ),
                            Text(
                              "\$ ${widget.module.price}/night",
                              style: FavouriteTheme.priceTextStyle,
                            ),
                            Text(
                              widget.module.location,
                              style: FavouriteTheme.locationTextStyle,
                            ),
                            RatingBar.builder(
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 2),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("FROM : "+DateFormat('yyyy-MM-dd').format(widget.module.fromDate).toString() ,style: FavouriteTheme.locationTextStyle),
                            Text("TO : "+DateFormat('yyyy-MM-dd').format(widget.module.toDate).toString(), style: FavouriteTheme.locationTextStyle)
                          ],
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