import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';


class LoadingDialog {
  static bool _isSuccessful = false;
  static Future<void> _runFuture(Future future) async{
    try {
      await future;
    }
    catch(e){
      print(e);
      return;
    }
    _isSuccessful = true;
  }

  static dynamic showLoadingDialog(BuildContext context,Future future,Widget onSuccessTitle,Widget onFailedTitle, Function onCloseSuccess,Function onCloseFailed, bool useOnClose){
    _isSuccessful = false;
    showDialog(context: context, builder: (context){
      return FutureBuilder(future: _runFuture(future), builder: (context,snapshot){
        print(snapshot.connectionState);
        if(snapshot.connectionState == ConnectionState.done){
          return AlertDialog(
            title: _isSuccessful? onSuccessTitle : onFailedTitle,
            content: TextButton(
              onPressed: useOnClose?( _isSuccessful? onCloseSuccess: onCloseFailed ): (){
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
    });
  }

  static showSelfDestroyedDialog(BuildContext context,Future future) async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 100,
          child: Center(child: CircularProgressIndicator())
        ),
      );
    });
    try {
      await future;
    }
    catch(E){
      print(E);
    }
    Navigator.pop(context);
  }



  static double showRatingDialog(BuildContext context,Future future(dynamic)) {
    double _rating = 0;
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Please give us your rating"),
        content: Container(
          height: 100,
          child: Center(
            child: Column(
              children: [
                RatingBar(
                  onRatingChanged: (rating) => _rating = rating,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  halfFilledIcon: Icons.star_half,
                  isHalfAllowed: true,
                  filledColor: Colors.yellow,
                  emptyColor: Colors.yellow,
                  halfFilledColor: Colors.yellow,
                  size: 48,
                ),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  showLoadingDialog(context, future(_rating),
                      Text("Thank you for your rating!"),
                      Text("There was a problem."), (){}, (){},false);
                }, child: Text("Rate"))
              ],
            ),
          ),
        ),
      );
    });
  }
}