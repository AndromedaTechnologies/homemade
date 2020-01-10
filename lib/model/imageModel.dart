
class DishImageModel {
  String id;
  String dishimages;

  DishImageModel({this.id, this.dishimages});

  DishImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dishimages = json['dishimages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dishimages'] = this.dishimages;
    return data;
  }
}