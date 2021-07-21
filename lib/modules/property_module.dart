class PropertyModule {
  final int id;
  final String title, description, price, imgSrc;
  final double rating;
  final String location;
  PropertyModule({this.id, this.title, this.description, this.price, this.imgSrc,
      this.rating, this.location});
  factory PropertyModule.fromJson(Map<String, dynamic> json) {
    try {
      return PropertyModule(
          id: int.parse(json['property_id'].toString()),
          title: json['name'].toString(),
          description: json['description'].toString(),
          price: json['price_per_night'].toString(),
          imgSrc: json['MIN(images.url)'].toString(),
          rating: double.parse(json['rating'].toString()),
          location: json['city'].toString() + ' / ' +
              json['street'].toString());
    } catch(e){ return null ; }
  }
}
