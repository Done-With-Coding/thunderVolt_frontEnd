class LocationModel {
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  num? distance;

  LocationModel(
      {this.id, this.name, this.latitude, this.longitude, this.distance});

  LocationModel.fromJson(Map element) {
    this.id = element["id"];
    this.name = element["name"];
    this.distance = element["distance"];
    this.latitude = double.tryParse(element["latitude"]);
    this.longitude = double.tryParse(element["longitude"]);
    this.address = element["address"];
  }

  void toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["latitude"] = this.latitude;
    data["longitude"] = this.longitude;
  }
}

class BookingModel {
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? timeStamp;
  String? slot;
  String? phone;

  BookingModel(
      {this.name, this.address, this.timeStamp, this.slot, this.phone});

  BookingModel.fromJson(Map data) {
    this.name = data["station_name"];
    this.address = data["address"];
    this.timeStamp = data["b_date"];
    this.latitude = double.tryParse(data["latitude"]);
    this.longitude = double.tryParse(data["longitude"]);
    this.slot = data["slot"];
    this.phone = data["mobile_no"];
  }
}
