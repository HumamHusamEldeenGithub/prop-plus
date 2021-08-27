import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/RealStateTheme.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/screens/description.dart';

class PropertyCard extends StatefulWidget {

  final MainModule module ;

  const PropertyCard({Key key, this.module}) : super(key: key);




  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(RealStateTheme.cardPadding),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, DetailsScreen.path,arguments: widget.module) ;
        },
        child: Card(
          child: Stack(children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: RealStateTheme.borderRadius, topRight: RealStateTheme.borderRadius),
                    child: Align(
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                      heightFactor: 0.65,
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: MainTheme.shadowBlurRadius,
                            offset: MainTheme.shadowOffest,
                            color: MainTheme.shadowColor
                        )
                      ],
                      borderRadius: BorderRadius.only(bottomLeft: RealStateTheme.borderRadius, bottomRight: RealStateTheme.borderRadius)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.module.propertyModule.title,
                                style: RealStateTheme.titleTextStyle,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.module.propertyModule.location,
                                style: RealStateTheme.locationTextStyle,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [

                                  Text(
                                    "${widget.module.propertyModule.rating} reviews",
                                    style: RealStateTheme.reviewTextStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "\$ ${widget.module.price}",
                                style: RealStateTheme.priceTextStyle,
                              ),
                              Text(
                                "per night",
                                style: RealStateTheme.perNightTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
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
