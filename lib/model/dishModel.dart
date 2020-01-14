import 'package:homemade/model/imageModel.dart';

class DishModel {
  String id;
  String name;
  String price;
  String servingSize;
  String cuisineType;
  String dietaryInformation;
  String courseType;
  String description;
  String chefId;
  String createdAt;
  String updatedAt;

  List<String> ingredients;
  List<String> servingtime;
  List<DishImageModel> dishimages;
  List<String> reviews;

  DishModel(
      {this.id,
        this.name,
        this.price,
        this.servingSize,
        this.cuisineType,
        this.dietaryInformation,
        this.courseType,
        this.description,
        this.chefId,
        this.createdAt,
        this.updatedAt,
        this.ingredients,
        this.servingtime,
        this.dishimages,
        this.reviews});

  DishModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    servingSize = json['serving_size'];
    cuisineType = json['cuisine_type'];
    dietaryInformation = json['dietary_information'];
    courseType = json['course_type'];
    description = json['description'];
    chefId = json['chef_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ingredients'] != null) {
      ingredients = new List<String>();
      json['ingredients'].forEach((v) {
        ingredients.add(v);
      });
    }else{
      ingredients = new List<String>();
    }
    if (json['servingtime'] != null) {
      servingtime = new List<String>();
      json['servingtime'].forEach((v) {
        servingtime.add(v['servingtime']);
      });
    }else{
      servingtime = new List<String>();
    }
    if (json['dishimages'] != null) {
      dishimages = new List<DishImageModel>();
      json['dishimages'].forEach((v) {
        dishimages.add(new DishImageModel.fromJson(v));
      });
    }
//    if (json['reviews'] != null) {
//      reviews = new List<Null>();
//      json['reviews'].forEach((v) {
//        reviews.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['serving_size'] = this.servingSize;
    data['cuisine_type'] = this.cuisineType;
    data['dietary_information'] = this.dietaryInformation;
    data['course_type'] = this.courseType;
    data['description'] = this.description;
    data['chef_id'] = this.chefId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

