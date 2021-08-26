import 'package:prop_plus/modules/property_module.dart';

class MainModule {
  final PropertyModule propertyModule;
  final int service_id, price;
  final String imgSrc;
  MainModule({this.propertyModule, this.service_id, this.imgSrc, this.price});
  factory MainModule.fromJson(
      PropertyModule propertyModule, Map<String, dynamic> json) {
    try {
      return new MainModule(
        propertyModule: propertyModule,
        imgSrc: json['url'].toString(),
        service_id: int.parse(json['service_id'].toString()),
        price: int.parse(json['price_per_night'].toString()),
      );
    } catch (e) {
      return null;
    }
  }
}
