
class DishImageModel {
  String id;
  String image;

  DishImageModel({this.id, this.image});

  DishImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['dishimages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dishimages'] = this.image;
    return data;
  }
}