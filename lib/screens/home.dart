import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/TrendingTheme.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/categories.dart';
import 'package:prop_plus/shared/recommended_card.dart';
import 'package:prop_plus/shared/shimmer_widget.dart';
import 'package:prop_plus/shared/trending_card.dart';
import 'package:prop_plus/constant/CategoryTheme.dart';
import 'package:prop_plus/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  Function parentFunction;
  Function changeCategory ;
  Home({this.parentFunction , this.changeCategory, Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await widget.parentFunction();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    refreshPage();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void refreshPage() {
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Padding(
              padding: const EdgeInsets.all(MainTheme.pagePadding),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: CategoryTheme.descriptionFontSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MainWidget.databaseData['CategoriesModules'] != null
                ? SizedBox(
                    height: CategoryTheme.allHeight,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          MainWidget.databaseData['CategoriesModules']?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              MainWidget.databaseData['CategoriesModules']
                                  .forEach((element) {
                                element.isSelected = false;
                              });
                              MainWidget
                                  .databaseData['CategoriesModules'][index]
                                  .isSelected = true;
                              if (index==0)
                                widget.parentFunction(true) ;
                              else
                                widget.changeCategory(MainWidget
                                    .databaseData['CategoriesModules'][index].title) ;

                            });
                          },
                          child: CategoryRadioButton(
                              model: MainWidget
                                  .databaseData['CategoriesModules'][index]),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 75,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.all(CategoryTheme.iconPadding),
                          child: ShimmerWidget.circle(
                            width: 60,
                            height: 1,
                            shapeBorder: CategoryTheme.borderRadius,
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(MainTheme.pagePadding),
              child: Center(
                child: Text(
                  "Trending",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            (MainWidget.databaseData['TrendingModules'] != null && MainWidget.databaseData['TrendingModules'].isNotEmpty)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: MainWidget.databaseData['TrendingModules']
                          ?.map((card) {
                        return TrendingCard(module: card,refreshFunction: refreshPage,);
                      })?.toList(),
                    ))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: ShimmerWidget.trendingCards)),
            Padding(
              padding: const EdgeInsets.all(MainTheme.pagePadding),
              child: Center(
                child: Text(
                  "Recommended",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            (MainWidget.databaseData['PropertyModules'] != null && MainWidget.databaseData['PropertyModules'].isNotEmpty)
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: MainWidget.databaseData['PropertyModules']
                          .map((card) {
                        return RecommendedCard(module: card,refreshFunction: refreshPage,);
                      }).toList(),
                    ),
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: ShimmerWidget.rectangle(
                            width: _width * 0.97,
                            height: 200,
                            shapeBorder: BorderRadius.circular(10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: ShimmerWidget.rectangle(
                            width: _width * 0.97,
                            height: 200,
                            shapeBorder: BorderRadius.circular(10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: ShimmerWidget.rectangle(
                            width: _width * 0.97,
                            height: 200,
                            shapeBorder: BorderRadius.circular(10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: ShimmerWidget.rectangle(
                            width: _width * 0.97,
                            height: 200,
                            shapeBorder: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
