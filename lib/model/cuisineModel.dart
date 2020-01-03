
class Cuisines {
  String cuisine;

  Cuisines({this.cuisine});

  Cuisines.fromJson(Map<String, dynamic> json) {
    cuisine = json['cuisine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuisine'] = this.cuisine;
    return data;
  }
}