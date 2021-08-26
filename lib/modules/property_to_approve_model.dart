class PropertyToApprove {
  int user_id;
  String title;
  String description;
  String phone;
  String city, street;
  String type;
  List<String> approvalImagesUrls;
  PropertyToApprove(
      {this.user_id,
      this.title,
      this.phone,
      this.description,
      this.city,
      this.street,
      this.type,
      this.approvalImagesUrls});
}
