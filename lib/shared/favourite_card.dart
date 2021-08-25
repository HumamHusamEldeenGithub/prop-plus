
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/FavouriteTheme.dart';
import 'package:prop_plus/modules/favourite_module.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';

import 'http_requests.dart';
import 'loading_widget.dart';



class FavouriteCard extends StatefulWidget {
  Function refreshFunction ;
  final MainModule module ;
  FavouriteCard({this.refreshFunction,Key key,this.module}) : super(key: key);

  @override
  _FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {

  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, DetailsScreen.path,arguments: {'module': widget.module}) ;
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
                        image: NetworkImage(widget.module.imgSrc),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: FavouriteTheme.borderRadius,
                          topLeft: FavouriteTheme.borderRadius,
                          bottomLeft: FavouriteTheme.borderRadius,
                          bottomRight: FavouriteTheme.borderRadius)),
                ),
                SizedBox(
                  width: 20,
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
                              widget.module.propertyModule.title,
                              style: FavouriteTheme.titleTextStyle,
                            ),
                            Text(
                              "\$ "+widget.module.price.toString(),
                              style: FavouriteTheme.priceTextStyle,
                            ),
                            Text(
                              widget.module.propertyModule.location,
                              style: FavouriteTheme.locationTextStyle,
                            ),
                            RatingBar.builder(
                              initialRating: widget.module.propertyModule.rating,
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
                            SizedBox(
                              height: 30,
                              width: 35,
                              child: IconButton(
                                color: MainTheme.mainColor,
                                icon: favorite
                                    ? Icon(
                                  Icons.favorite,
                                  color: MainTheme.mainColor,
                                  size: 20,
                                )
                                    : Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                ),
                                onPressed: ()async {
                                  if (!favorite) {
                                    Loading.showLoaderDialog(context, "Adding property to favorite");
                                    await HTTP_Requests.addNewFavourite(
                                        locater<UserController>()
                                            .currentUser
                                            .dbId
                                            .toString(),
                                        widget.module.propertyModule.id.toString());

                                  } else {
                                    Loading.showLoaderDialog(context, "Removing property from favorite");
                                    await HTTP_Requests.deleteFavourite(
                                        locater<UserController>()
                                            .currentUser
                                            .dbId
                                            .toString(),
                                        widget.module.propertyModule.id.toString());
                                  }
                                  setState(() {
                                    favorite = !favorite;
                                    Navigator.pop(context);
                                    widget.refreshFunction();
                                  });
                                },
                              ),
                            ),
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