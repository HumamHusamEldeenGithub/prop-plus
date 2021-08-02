class PropertyModule {
  final int id;
  final String title,phone,description,location;
  final double rating;
  PropertyModule({this.id, this.title,this.phone, this.description, this.location, this.rating});
  factory PropertyModule.fromJson(Map<String, dynamic> json) {
    try {
      return new PropertyModule(
          id: int.parse(json['id']?.toString()),
          title: json['name']?.toString(),
          phone: json['phone']?.toString(),
          description: json['description']?.toString(),
          rating: double.parse(json['rating']?.toString()),
          location: json['city'].toString() + ' / ' +
              json['street']?.toString());
    } catch(e){return null ;}
  }
}
