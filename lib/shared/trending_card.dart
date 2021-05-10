import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/trending_module.dart';

class TrendingCard extends StatefulWidget {

  final TrendingModel model ;

  const TrendingCard({Key key, this.model}) : super(key: key);



  @override
  _TrendingCardState createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(MainTheme.pagePadding, 0, 0, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.model.imgSrc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.model.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 23,
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
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$ ${widget.model.price}/night",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.model.description,
                          style: TextStyle(color: Colors.grey[600]),
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
        ));
  }
}
