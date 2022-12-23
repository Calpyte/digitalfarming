class FarmCoordinates {
  String? id;
  double? latitude;
  double? longitude;
  int? sequenceNumber;

  FarmCoordinates(
      {this.id, this.latitude, this.longitude, this.sequenceNumber});

  FarmCoordinates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['sequenceNumber'] = sequenceNumber;
    return data;
  }
}
