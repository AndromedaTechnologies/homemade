

class LocationModel{
  String name;
  String latitude;
  String longitude;

  LocationModel.fromJson(Map<String,dynamic> json){
    name = json['name']?.toString()??"";
    latitude = json['business_latitudename']?.toString()??"";
    longitude = json['longitude']?.toString()??"";

  }

}