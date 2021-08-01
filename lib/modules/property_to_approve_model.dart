class PropertyToApprove {
  int user_id;
  String title;
  String description;
  String phone;
  String location;
  List<String> approvalImagesUrls;
  PropertyToApprove(
      {this.user_id,
      this.title,
      this.phone,
      this.description,
      this.location,
      this.approvalImagesUrls});
}
