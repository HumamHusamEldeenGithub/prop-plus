import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_widget.dart';

import 'loading_dialog.dart';

class RecommendedCard extends StatefulWidget {
  final MainModule module;

  final refreshFunction ;
  const RecommendedCard({Key key, this.module,this.refreshFunction}) : super(key: key);

  @override
  _RecommendedCardState createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {
  bool favorite = false;

  Future<void> onTapFavorite() async {
    if (!favorite) {
      await HTTP_Requests.addNewFavourite(
          locater<UserController>().currentUser.dbId.toString(),
          widget.module.service_id.toString());
    } else {
      await HTTP_Requests.deleteFavourite(
          locater<UserController>().currentUser.dbId.toString(),
          widget.module.service_id.toString());
    }
    setState(() {
      favorite = !favorite;
      widget.refreshFunction();
    });
  }

  @override
  void initState() {
    super.initState();
    favorite = locater.get<UserController>().currentUser.favourite_services.contains(widget.module.service_id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, DetailsScreen.path,
              arguments: {'module': widget.module});
        },
        child: Card(
          elevation: 5,
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRect(
                      child: Align(
                    child: widget.module.imgSrc != null
                        ? Image.network(widget.module.imgSrc)
                        : Text("Image"),
                    heightFactor: 0.65,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.module.propertyModule.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.module.propertyModule.location != null
                                  ? widget.module.propertyModule.location
                                  : "Location",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating:
                                      widget.module.propertyModule.rating,
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
                                Text(
                                  "${widget.module.propertyModule.rating} reviews",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "\$ ${widget.module.price}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Per Night",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 70,
                right: 10,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                      child: IconButton(
                          icon: favorite
                              ? Icon(
                                  Icons.favorite,
                                  color: MainTheme.mainColor,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                ),
                          onPressed: () {
                            LoadingDialog.showSelfDestroyedDialog(
                                context, onTapFavorite());
                          })),
                )),
          ]),
        ),
      ),
    );
  }
}
