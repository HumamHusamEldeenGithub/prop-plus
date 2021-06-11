class PropertyModule {
  final int id;
  final String title, description, price, imgSrc;
  final double rating;
  final String location;
  PropertyModule({this.id, this.title, this.description, this.price, this.imgSrc,
      this.rating, this.location});
  factory PropertyModule.fromJson(Map<String, dynamic> json) {
    return PropertyModule(
        id: int.parse(json['id']),
        title: json['name'],
        description: json['description'],
        price: json['price'],
        imgSrc: json['imgSrc'],
        rating: double.parse(json['rating']),
        location: json['location']);
  }
}
