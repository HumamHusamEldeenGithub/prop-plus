import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_avatar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  UserModule currentUser = locater.get<UserController>().currentUser;

  PickedFile image;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      child: SmartRefresher(
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
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Avatar(
                  size: 50,
                    avatarURL:"https://media-exp1.licdn.com/dms/image/C4D03AQFtcr7InPL8Jg/profile-displayphoto-shrink_800_800/0/1589865922874?e=1635379200&v=beta&t=2igAfqyj7e7ZyW2NPK85Rh8DBvVhtYOpGqRSXc1WHZA" ,
                    onTap: () async {
                      //get the image from gallery using Image Picker
                      image = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      // Upload the Image
                      await locater
                          .get<UserController>()
                          .uploadProfilePicture(File(image.path));
                    }),
                SizedBox(height: 50,),
                SizedBox(
                  width: _width * 0.5,
                  child: ElevatedButton(
                    child: Text("log Out "),
                    onPressed: () async {
                      try {
                        locater.get<UserController>().signOut();
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: _width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    child: Text("Adding property "),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/propInputForm');
                    },
                  ),
                ),
                SizedBox(
                  width: _width * 0.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/myProperties');
                      },
                      child: Text("My Properties")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
