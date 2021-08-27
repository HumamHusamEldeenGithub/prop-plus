import 'package:flutter/material.dart';
import 'package:prop_plus/constant/FavouriteTheme.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/user_properties_module.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/screens/all_services.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/screens/user_property_description_screen.dart';

class UserPropertyCard extends StatefulWidget {
  final PropertyModule module;
  const UserPropertyCard({Key key, this.module}) : super(key: key);

  @override
  _UserPropertyCardState createState() => _UserPropertyCardState();
}

class _UserPropertyCardState extends State<UserPropertyCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AllServices.path,
            arguments: {'module' : widget.module , 'showAddService':true });
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
                      borderRadius: BorderRadius.only(
                          topRight: FavouriteTheme.borderRadius,
                          topLeft: FavouriteTheme.borderRadius,
                          bottomLeft: FavouriteTheme.borderRadius,
                          bottomRight: FavouriteTheme.borderRadius)),
                  child: Icon(
                    widget.module.type == "Hotel"
                        ? Icons.home_work_outlined
                        : Icons.home_outlined,
                    size: 60,
                  ),
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
                              widget.module.title,
                              style: FavouriteTheme.titleTextStyle,
                            ),
                            // Text(
                            //   "\$ ${widget.module.price}/night",
                            //   style: FavouriteTheme.priceTextStyle,
                            // ),
                            Text(
                              widget.module.location,
                              style: FavouriteTheme.locationTextStyle,
                            ),
                            RatingBar.builder(
                              initialRating: widget.module.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2),
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
