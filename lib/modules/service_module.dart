import 'package:prop_plus/modules/property_module.dart';
class ServiceModule {
  // ignore: non_constant_identifier_names
  final int service_id;
  final PropertyModule propertyModule;
  final String description;
  final int price;
  List<String> imageUrls;
  // ignore: non_constant_identifier_names
  ServiceModule({this.service_id, this.propertyModule, this.description, this.price, this.imageUrls});
  factory ServiceModule.fromJson(
      Map<String, dynamic> json, PropertyModule propertyModule) {
    try {
      return new ServiceModule(
          imageUrls: null,
          propertyModule: propertyModule,
          service_id: int.parse(json['id']?.toString()),
          description: json['description']?.toString(),
          price: int.parse(json['price_per_night']?.toString()));
    } catch (e) {
      return null;
    }
  }
  factory ServiceModule.fromJson2(
      Map<String, dynamic> json, PropertyModule propertyModule) {
    try {
      return new ServiceModule(
          imageUrls: null,
          propertyModule: propertyModule,
          service_id: int.parse(json['service_id']?.toString()),
          description: json['description']?.toString(),
          price: int.parse(json['price_per_night']?.toString()));
    } catch (e) {
      return null;
    }
  }
}
