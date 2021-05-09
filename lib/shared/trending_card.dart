import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';

class TrendingCard extends StatefulWidget {
  final String title, description, price, imgSrc;
  final double rating;

  const TrendingCard(
      {Key key,
        this.title,
        this.description,
        this.price,
        this.rating,
        this.imgSrc})
      : super(key: key);

  @override
  _TrendingCardState createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imgSrc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              widget.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
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
                                  } ,
                              ),
                            )
                          ],
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$ ${widget.price}/night",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("${widget.rating}"),
                                Icon(Icons.star, size: 15),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
