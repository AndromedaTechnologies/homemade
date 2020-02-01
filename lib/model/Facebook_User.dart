
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Facebook{
  String name;
  Picture picture;
  String firstName;
  String lastName;
  String email;
  String id;
  String phoneNumber;
  String birthday;
  String gender;

  Facebook.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    picture =
    json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    id = json['id'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    birthday = json['birthday'];
  }
}

class Picture {
  Data data;
  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int height;
  bool isSilhouette;
  String url;
  int width;

  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['is_silhouette'] = this.isSilhouette;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

/*{"name":"fb test user","picture":{"data":{"height":50,"is_silhouette":true,"url":"https:\/\/scontent.xx.fbcdn.net\/v\/t31.0-1\/cp0\/c15.0.50.50a\/p50x50\/10733713_10150004552801937_4553731092814901385_o.jpg?_nc_cat=1&_nc_ohc=zvdOdnl7sjMAX-0KC_y&_nc_ht=scontent.xx&oh=4a83b131d2c8591917a81ddce6325455&oe=5EDA01D4","width":50}},"first_name":"fb","last_name":"user","gender":"female","birthday":"02\/03\/2001","email":"fb_usuyrmh_user\u0040tfbnw.net","id":"103008361264428"}*/