import 'awardModel.dart';
import 'chefModel.dart';
import 'cuisineModel.dart';

class ChefDetailModel {
  ChefModel chef;
  List<Awards> awards;
  List<Cuisines> cuisines;

  ChefDetailModel({this.chef, this.awards, this.cuisines});

  ChefDetailModel.fromJson(Map<String, dynamic> json) {
    chef = json['chef'] != null ? new ChefModel.fromJson(json['chef']) : null;
    if (json['awards'] != null) {
      awards = new List<Awards>();
      json['awards'].forEach((v) {
        awards.add(new Awards.fromJson(v));
      });
    }else{
      awards = new List<Awards>();
    }
    if (json['cuisines'] != null) {
      cuisines = new List<Cuisines>();
      json['cuisines'].forEach((v) {
        cuisines.add(new Cuisines.fromJson(v));
      });
    }else{
      cuisines = new List<Cuisines>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chef != null) {
      data['chef'] = this.chef.toJson();
    }
    if (this.awards != null) {
      data['awards'] = this.awards.map((v) => v.toJson()).toList();
    }
    if (this.cuisines != null) {
      data['cuisines'] = this.cuisines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
