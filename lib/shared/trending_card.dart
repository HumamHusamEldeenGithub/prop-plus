import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/TrendingTheme.dart';
import 'package:prop_plus/main.dart';
import 'package:prop_plus/modules/main_module.dart';
import 'package:prop_plus/screens/description.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:prop_plus/shared/loading_dialog.dart';

class TrendingCard extends StatefulWidget {
  final MainModule module;

  final refreshFunction ;
  const TrendingCard({Key key, this.module,this.refreshFunction}) : super(key: key);

  @override
  _TrendingCardState createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  bool favorite = false;

  Future<void> onTapFavorite() async{
    if (!favorite) {
      await HTTP_Requests.addNewFavourite(
          MainWidget.userData['CurrentUser']
            .dbId
            .toString(),
        widget.module.service_id.toString()
      );
      MainWidget.userData['CurrentUser'].favouriteServices.add(widget.module.service_id);
    }
    else {
      await HTTP_Requests.deleteFavourite(
          MainWidget.userData['CurrentUser']
            .dbId
            .toString(),
        widget.module.service_id.toString());

      MainWidget.userData['CurrentUser'].favouriteServices.remove(widget.module.service_id);
    }
    setState(() {
      favorite = !favorite;
      widget.refreshFunction();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    favorite = MainWidget.userData['CurrentUser']?.favouriteServices?.contains(widget.module.service_id);
    return Padding(
        padding:
            const EdgeInsets.fromLTRB(TrendingTheme.trendingPadding, 0, 0, 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailsScreen.path,
                arguments: {'module': widget.module,'refreshFunction': widget.refreshFunction});
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
                          image: NetworkImage(widget.module.imgSrc),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: TrendingTheme.borderRadius,
                            topLeft: TrendingTheme.borderRadius)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: MainTheme.shadowBlurRadius,
                              offset: MainTheme.shadowOffest,
                              color: MainTheme.shadowColor)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomRight: TrendingTheme.borderRadius,
                            bottomLeft: TrendingTheme.borderRadius)),
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
                            widget.module.propertyModule.title,
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
                                  onPressed: (){LoadingDialog.showSelfDestroyedDialog(context, onTapFavorite());}
                                ),
                              )
                            ],
                          ),
                          Text(
                            widget.module.propertyModule.location,
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
