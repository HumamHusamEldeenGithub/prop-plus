class BookingModule{
  final int id,price;
  final String title, description, imgSrc;
  final DateTime fromDate,toDate;
  final String location;
  BookingModule({this.id, this.title, this.description, this.price, this.imgSrc, this.location,this.fromDate,this.toDate});
  factory BookingModule.fromJson(Map<String, dynamic> json){
    try{

      return new BookingModule(

          id: int.parse(json['booking_id']?.toString()),
          title: json['title']?.toString(),
          description: json['description']?.toString(),
          price: int.parse(json['price']?.toString()),
          imgSrc: json['url']?.toString(),
          location: json['city']?.toString() + ' / ' + json['street']?.toString(),
          fromDate: DateTime.parse(json['start_date']?.toString().replaceAll('.', ':').substring(0,19) + 'Z'),
          toDate: DateTime.parse(json['end_date']?.toString().replaceAll('.', ':').substring(0,19) + 'Z')
      );
    }
    catch(e){
      return null;
    }
  }
}