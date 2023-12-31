import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/TrendingTheme.dart';
import 'package:prop_plus/modules/property_module.dart';
import 'package:prop_plus/modules/trending_module.dart';
import 'package:prop_plus/screens/description.dart';


class TrendingCard extends StatefulWidget {

  final TrendingModule module ;

  const TrendingCard({Key key, this.module}) : super(key: key);



  @override
  _TrendingCardState createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Description.path,arguments: widget.module) ;
          },
          child: Container(
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.module.imgSrc),
                        fit: BoxFit.cover,
                      ),
                    borderRadius: BorderRadius.only(topRight: TrendingTheme.borderRadius, topLeft: TrendingTheme.borderRadius)
                    ),
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
                      borderRadius: BorderRadius.only(bottomRight: TrendingTheme.borderRadius, bottomLeft: TrendingTheme.borderRadius)

                    ),
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),


                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.module.title,
                            style: TrendingTheme.titleTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${widget.module.price}/night",
                                style: TrendingTheme.priceTextStyle,
                              ),
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
                                  onPressed: () {
                                    setState(() {
                                      favorite = !favorite;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          Text(
                            widget.module.location,
                            style: TrendingTheme.locationTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
        ));
  }
}
