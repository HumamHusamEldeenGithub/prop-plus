class UserModule{
  int dbId ;
  String uid;
  String email;
  String userName;
  String avatarURl;
  String phoneNumber;
  List<int> favouriteServices;
  UserModule({this.dbId, this.phoneNumber, this.favouriteServices, this.uid , this.userName , this.avatarURl, this.email});
  factory UserModule.fromJson(
      Map<String, dynamic> json) {
    try {
      return new UserModule(
        dbId: int.parse(json['id'].toString()),
        uid: (json['firebase_id']).toString(),
        userName: json['name'].toString(),
        avatarURl: json['avatarURL'].toString(),
        phoneNumber: json['phone'].toString(),
        email: json['email'].toString(),
      );
    } catch (e) {
      return null;
    }
  }
}