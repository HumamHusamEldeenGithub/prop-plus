import 'package:prop_plus/modules/service_module.dart';

class BookingModule{
  final ServiceModule serviceModule;
  final int id;
  final DateTime fromDate,toDate;
  BookingModule({this.id, this.serviceModule,this.fromDate,this.toDate});
  factory BookingModule.fromJson(Map<String, dynamic> json, ServiceModule serviceModule){
    try{

      return new BookingModule(
          id: int.parse(json['booking_id']?.toString()),
          serviceModule: serviceModule,
          fromDate: DateTime.parse(json['start_date']?.toString().replaceAll('.', ':').substring(0,19) + 'Z'),
          toDate: DateTime.parse(json['end_date']?.toString().replaceAll('.', ':').substring(0,19) + 'Z')
      );
    }
    catch(e){
      return null;
    }
  }
}