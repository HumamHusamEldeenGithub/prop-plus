import 'package:prop_plus/modules/booking_module.dart';
import 'package:prop_plus/modules/service_module.dart';

class PaymentModule{
  final BookingModule bookingModule;
  final int id,paymentType;
  final double totalAmount;
  final DateTime paymentDate;
  PaymentModule({this.id, this.bookingModule,this.paymentType,this.paymentDate, this.totalAmount});
  factory PaymentModule.fromJson(Map<String, dynamic> json, BookingModule bookingModule){
    try{
      return new PaymentModule(
        id: int.parse(json['booking_id']?.toString()),
        bookingModule: bookingModule,
        totalAmount: json['amount'],
        paymentDate: DateTime.parse(json['payment_date']?.toString().replaceAll('.', ':').substring(0,19) + 'Z'),
      );
    }
    catch(e){
      return null;
    }
  }
}