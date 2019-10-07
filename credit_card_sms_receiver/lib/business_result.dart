class BusinessResult {
  String id;
  String name;
  String address;
  double latitude;
  double longitude;

  BusinessResult({this.id, this.name, this.address, this.latitude, this.longitude});

  factory BusinessResult.fromJson(Map<String, dynamic> json) {
    return BusinessResult(
      id: json["id"],
      name: json["name"],
      address: json["vicinity"],
      latitude: json["geometry"]["location"]["lat"],
      longitude: json["geometry"]["location"]["lng"],
    );

  }
}