import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/screens/description.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModule module;

  const ServiceCard({Key key, this.module}) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailsScreen.path,
            arguments: {'module': widget.module, 'showAllServices': false},
          );
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
                    //TODO FIX THIS
                    child: Image.network(widget.module.imageUrls.isNotEmpty
                        ? widget.module.imageUrls[0]
                        : ""),
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
                              RatingBar.readOnly(
                              size: 20,
                              initialRating: widget.module.propertyModule.rating,
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledColor: Colors.amberAccent,filledColor: Colors.amberAccent,
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
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                  )),
                )),
          ]),
        ),
      ),
    );
  }
}
