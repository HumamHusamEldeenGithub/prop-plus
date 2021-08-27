class PropertyModule {
  final int id;
  final String title,phone,description,location;
  final double rating;
  final String type ;
  PropertyModule({this.type,this.id, this.title,this.phone, this.description, this.location, this.rating});
  factory PropertyModule.fromJson(Map<String, dynamic> json) {
    try {
      return new PropertyModule(
          id: int.parse(json['id']?.toString()),
          title: json['name']?.toString(),
          phone: json['phone']?.toString(),
          description: json['description']?.toString(),
          rating: double.parse(json['rating']?.toString()),
          type :json['type']?.toString(),
          location: json['city'] !=null ? json['city'].toString() + ' / ' +
              json['street']?.toString():"");
    } catch(e){print(e);return null ;}
  }
}
