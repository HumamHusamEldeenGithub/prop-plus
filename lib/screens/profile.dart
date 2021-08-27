import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_plus/main.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';
import 'package:prop_plus/shared/custom_avatar.dart';
import 'package:prop_plus/shared/http_requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  Function parentFunction;
  Profile({this.parentFunction, Key key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  UserModule currentUser = MainWidget.userData['CurrentUser'];
  PickedFile image;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = MainWidget.userData['CurrentUser'];
  }

  void _onRefresh() async {
    // monitor network fetch
    await widget.parentFunction;
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    currentUser = MainWidget.userData['CurrentUser'];
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
      print("Refresh Profile");
      currentUser = MainWidget.userData['CurrentUser'];
    });
  }

  bool _checkAvatarNotNull() {
    try {
      return MainWidget.userData['CurrentUser'].avatarURl != null;
    } catch (e) {
      return false;
    }
  }

  String getAvatarLink() {
    //print("Image is " + _checkAvatarNotNull().toString());
    if (_checkAvatarNotNull()) {
      return currentUser.avatarURl;
    } else {
      return "https://thumbs.dreamstime.com/b/creative-vector-illustration-default-avatar-profile-placeholder-isolated-background-art-design-grey-photo-blank-template-mo-107388687.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    currentUser = MainWidget.userData['CurrentUser'];
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
                  height: 20,
                ),
                Avatar(
                    size: 65,
                    avatarURL: getAvatarLink(),
                    onTap: () async {
                      //TODO view Image
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(currentUser?.userName!=null?currentUser.userName:'Name',style: TextStyle(fontSize: 25),),
                SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 50,
                ),
                CustomProfileButton(
                  text: "Edit Profile",
                  customIcon: Icons.person,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/editProfilePage', arguments: refreshPage);
                  },
                ),
                CustomProfileButton(
                  text: "My Properties",
                  customIcon: Icons.home_work_rounded,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/myProperties');
                  },
                ),
                CustomProfileButton(
                  text: "Adding Property",
                  customIcon: Icons.add,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/propInputForm');
                  },
                ),
                CustomProfileButton(
                  text: "Report a problem",
                  customIcon: Icons.report,
                  onPressed: () async {
                    Navigator.of(context).pushNamed('/report_problem');
                  },
                ),
                CustomProfileButton(
                  text: "Logout",
                  customIcon: Icons.power_settings_new,
                  onPressed: () async {
                    try {
                      locater.get<UserController>().signOut();
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProfileButton extends StatefulWidget {
  final String text;
  final IconData customIcon;
  final Function onPressed;
  const CustomProfileButton(
      {Key key, this.text, this.customIcon, this.onPressed})
      : super(key: key);

  @override
  _CustomProfileButtonState createState() => _CustomProfileButtonState();
}

class _CustomProfileButtonState extends State<CustomProfileButton> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Function on_pressed = widget.onPressed;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 65,
        width: _width * 0.85,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Color(0xeef3f6fb))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      widget.customIcon,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              Container(
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            ],
          ),
          onPressed: on_pressed,
        ),
      ),
    );
  }
}
