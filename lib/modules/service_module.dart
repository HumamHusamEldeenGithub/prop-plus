import 'package:prop_plus/modules/property_module.dart';
class ServiceModule {
  final int id;
  final PropertyModule propertyModule;
  final String description;
  final double price;
  List<String> imageUrls;
  ServiceModule({this.id, this.propertyModule, this.description, this.price, this.imageUrls});
  factory ServiceModule.fromJson(
      Map<String, dynamic> json, PropertyModule propertyModule) {
    try {
      return new ServiceModule(
          imageUrls: null,
          propertyModule: propertyModule,
          id: int.parse(json['id']?.toString()),
          description: json['description']?.toString(),
          price: double.parse(json['price_per_night']?.toString()));
    } catch (e) {
      return null;
    }
  }
}
