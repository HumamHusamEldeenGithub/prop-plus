import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/main.dart';
import 'package:prop_plus/modules/service_module.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/screens/all_services.dart';
import 'package:prop_plus/screens/booking_calender_screen.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/loading_dialog.dart';
import 'package:prop_plus/shared/photos_slider_show.dart';
import 'package:prop_plus/shared/shimmer_widget.dart';
import '../shared/custom_image_view.dart';
import '../shared/http_requests.dart';

class DetailsScreen extends StatefulWidget {
  static String path = "/description";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController _scrollController = ScrollController();
  ServiceModule serviceModule;
  bool imageVisible = true;
  bool favorite = false;
  bool initialized = false;
  dynamic prevModule;
  Future<ServiceModule> loadService(dynamic prevModule) async {
    serviceModule = await HTTP_Requests.getService(
        prevModule.service_id, prevModule.propertyModule);
    var urls =
        await HTTP_Requests.getAllImagesForService(prevModule.service_id);
    serviceModule.imageUrls = urls;
    favorite = locater
        .get<UserController>()
        .currentUser
        .favourite_services
        .contains(serviceModule.service_id);
    return serviceModule;
  }

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (imageVisible) {
          setState(() {
            imageVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!imageVisible) {
          setState(() {
            imageVisible = true;
          });
        }
      }
    });
  }

  Future<void> onTapFavorite() async {
    if (!favorite) {
      await HTTP_Requests.addNewFavourite(
          locater<UserController>().currentUser.dbId.toString(),
          serviceModule.service_id.toString());
    } else {
      await HTTP_Requests.deleteFavourite(
          locater<UserController>().currentUser.dbId.toString(),
          serviceModule.service_id.toString());
    }
    setState(() {
      favorite = !favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    prevModule = args['module'];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: loadService(prevModule),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
            bottomNavigationBar: ShimmerWidget.rectangle(
              width: width,
              height: 45,
            ),
            body: ListView(
              controller: _scrollController,
              children: [
                Stack(children: [
                  GestureDetector(
                    child: Container(
                      child: Image.network(
                        prevModule.imgSrc,
                        fit: BoxFit.cover,
                      ),
                      height: imageVisible == true ? height * 0.4 : 0,
                      width: width,
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                  )),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 40.0),
                          ShimmerWidget.rectangle(
                            width: width * 0.9,
                            height: 20,
                            shapeBorder: BorderRadius.circular(10),
                          ),
                          const SizedBox(height: 40.0),
                          Center(
                              child: ShimmerWidget.rectangle(
                                  width: width * 0.9,
                                  height: 20,
                                  shapeBorder: BorderRadius.circular(10))),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShimmerWidget.rectangle(
                                  width: width * 0.9,
                                  height: 20,
                                  shapeBorder: BorderRadius.circular(10))
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ShimmerWidget.rectangle(
                              width: width * 0.9,
                              height: 20,
                              shapeBorder: BorderRadius.circular(10)),
                          SizedBox(
                            height: 40,
                          ),
                          ShimmerWidget.rectangle(
                              width: width * 0.9,
                              height: 20,
                              shapeBorder: BorderRadius.circular(10))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
        return Scaffold(
          bottomNavigationBar: Container(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(MainTheme.mainColor),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  color: Colors.white,
                )),
              ),
              child: Text(
                "Book Now",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.pushNamed(context, BookingCalenderScreen.path,
                    arguments: serviceModule);
              },
            ),
          ),
          body: ListView(
            controller: _scrollController,
            children: [
              Stack(children: [
                GestureDetector(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    child: Image.network(
                      serviceModule.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                    height: imageVisible == true ? height * 0.4 : 0,
                    width: width,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotosSlider(
                                imagesUrls: serviceModule.imageUrls)));
                  },
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                )),
              ]),
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
                                    prevModule.propertyModule.title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 0.45 * width,
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
                                  LoadingDialog.showSelfDestroyedDialog(
                                      context, onTapFavorite());
                                })
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            serviceModule != null
                                ? serviceModule.description
                                : "",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(width: 60),
                                Text(
                                  "Price".toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(prevModule.price.toString() + " \$")
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
                                Text(prevModule.propertyModule.location),
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
                                  starSize: 1,
                                  starPadding: 0.6,
                                  rating: prevModule.propertyModule.rating,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomAminitiesListView(),
                        SizedBox(
                          height: 40,
                        ),
                        args['showAllServices'] != false
                            ? Center(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                MainTheme.mainColor)),
                                    onPressed: () => {
                                          Navigator.pushNamed(
                                              context, AllServices.path,
                                              arguments:
                                                  serviceModule.propertyModule)
                                        },
                                    child: Text('Show all services ')),
                              )
                            : SizedBox()
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomAminitiesCard(icon: Icons.car_rental, title: "Parking"),
          CustomAminitiesCard(icon: Icons.bathtub, title: "Bath tup"),
          CustomAminitiesCard(icon: Icons.wifi, title: "Wifi"),
          CustomAminitiesCard(icon: Icons.ac_unit, title: "Cooler"),
        ],
      ),
    );
  }
}

class CustomStarBar extends StatelessWidget {
  final double starSize;
  final double starPadding;
  final double rating;

  CustomStarBar({this.starSize, this.starPadding, this.rating});

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
