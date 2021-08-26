import 'package:flutter/material.dart';
import 'package:prop_plus/constant/TrendingTheme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;

  static var trendingCards = [
    Padding(
      padding:
          const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
      child: ShimmerWidget.rectangle(
        width: 150,
        height: 180,
        shapeBorder: BorderRadius.circular(10),
      ),
    ),
    Padding(
      padding:
          const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
      child: ShimmerWidget.rectangle(
        width: 150,
        height: 180,
        shapeBorder: BorderRadius.circular(10),
      ),
    ),
    Padding(
      padding:
          const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
      child: ShimmerWidget.rectangle(
        width: 150,
        height: 180,
        shapeBorder: BorderRadius.circular(10),
      ),
    ),
    Padding(
      padding:
          const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
      child: ShimmerWidget.rectangle(
        width: 150,
        height: 180,
        shapeBorder: BorderRadius.circular(10),
      ),
    ),
  ];

  final shapeBorder;
  const ShimmerWidget.rectangle(
      {Key key, this.width, this.height, this.shapeBorder});
  const ShimmerWidget.circle(
      {Key key,
      this.width,
      this.height,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  _ShimmerWidgetState createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.shapeBorder,
          color: Colors.grey,
        ),
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
