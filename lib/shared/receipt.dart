
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prop_plus/constant/MainTheme.dart';
import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/user_module.dart';
import 'package:prop_plus/services/locater.dart';
import 'package:prop_plus/services/user_controller.dart';

class Receipt extends StatefulWidget {
  static final path = "/receipt";
  final BookingModule bookingModule;
  Receipt({Key key,this.bookingModule}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {

  UserModule user;
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    user = locater.get<UserController>().currentUser;
    for(int i = 0 ;i <= widget.bookingModule.toDate.difference(widget.bookingModule.fromDate).inDays; i++ ){
      totalPrice += widget.bookingModule.serviceModule.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: MainTheme.fontXXLarge,);
    TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: MainTheme.fontXLarge,);
    TextStyle normalStyle = TextStyle(fontWeight: FontWeight.normal,fontSize: MainTheme.fontLarge);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("Your receipt : ",textAlign: TextAlign.left,style: titleStyle,),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Guest name : ",style: boldStyle,),
                Text(user.userName!=null? user.userName : "NULL", style: normalStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Place to stay : ",style: boldStyle,),
                Text(widget.bookingModule.serviceModule.propertyModule.title, style: normalStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Price per night : ",style: boldStyle,),
                Text(widget.bookingModule.serviceModule.price.toString(), style: normalStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Starting from : ",style: boldStyle,),
                Text(DateFormat("dd-MM-yyyy").format(widget.bookingModule.fromDate).toString(), style: normalStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Until : ",style: boldStyle,),
                Text(DateFormat("dd-MM-yyyy").format(widget.bookingModule.toDate).toString(), style: normalStyle),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Text("Total price : ",style: boldStyle,),
                Text(totalPrice.toString(), style: normalStyle),
              ],
            ),
          ),

        ]
      );
  }
}
