class BusinessResult {
  String id;
  String name;
  String address;
  double latitude;
  double longitude;
  bool isExpanded = false;
  double rating = 0.0;

  BusinessResult({this.id, this.name, this.address, this.latitude, this.longitude, this.isExpanded});

  factory BusinessResult.fromJson(Map<String, dynamic> json) {
    return BusinessResult(
      id: json["id"],
      name: json["name"],
      address: json["vicinity"],
      latitude: json["geometry"]["location"]["lat"],
      longitude: json["geometry"]["location"]["lng"],
      isExpanded: false,
    );

  }
}