import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_module.dart';

class PropertyCard extends StatefulWidget {

  final PropertyModule model ;

  const PropertyCard({Key key, this.model}) : super(key: key);




  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                  child: Image.asset(widget.model.imgSrc),
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
                            widget.model.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.model.description,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: widget.model.rating,
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
                                "${widget.model.rating} reviews",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "\$ ${widget.model.price}",
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
    );
  }
}
