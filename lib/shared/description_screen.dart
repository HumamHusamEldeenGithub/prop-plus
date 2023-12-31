import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'custom_image_view.dart';

class DetailsScreen extends StatefulWidget {
   PropertyModule model  = new PropertyModule(id:0,title:"Luxury hotel",description: "Description - Description ",
  price:"100", imgSrc:"assets/real-state.jpg", rating:4,location:"Location - location");


  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController _scrollController = ScrollController();
  bool imageVisible = true;
  bool favorite = false;
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (imageVisible) {
          setState(() {
            imageVisible = false;
          });
        }
      } else if(_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!imageVisible) {
          setState(() {
            imageVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RaisedButton(

        color: MainTheme.mainColor,
        textColor: Colors.white,
        child: Text(
          "Book Now",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        onPressed: () {
        },
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          GestureDetector(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                widget.model.imgSrc,
                fit: BoxFit.cover,
              ),
              height: imageVisible == true ? 300 : 0,
              width: 600,
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) =>ViewImage(imageUrl: widget.model.imgSrc ,))
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                widget.model.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        IconButton(
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
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.model.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.0),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Price".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.model.price
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Rating".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomStarBar(
                              starSize: 12,
                              starPadding: 0.6,
                              rating: widget.model.rating,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Location".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Unknown"
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomAminitiesCard extends StatelessWidget {
  final String title;
  final IconData icon;
  CustomAminitiesCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Card(
                  child: Icon(
                    icon,
                    size: 30,
                  )),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class CustomAminitiesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          CustomAminitiesCard(icon: Icons.car_rental, title: "Parking"),
        ],
      ),
    );
  }
}

class CustomStarBar extends StatelessWidget {
  final double starSize;
  final double starPadding;
  final double rating;

  CustomStarBar({this.starSize, this.starPadding,this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: starSize,
          itemPadding: EdgeInsets.symmetric(horizontal: starPadding),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        Text(
          "${rating} reviews",
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    );
  }
}
