import 'dart:convert';

import 'package:homemade/model/awardModel.dart';

import 'cuisineModel.dart';
import 'dishModel.dart';
import 'locationModel.dart';

class ChefModel {
  int id;
  String businessName;
  String businessEmail;
  String businessPhone;
  LocationModel pickupLocation;
  String city;
  String state;
  String businessImage;
  String postalCode;
  String experience;
  String chefDescription;

  String businessAddress;
  String cnic;
  String iban;
  String bankName;

  String userId;
  String createdAt;
  String updatedAt;

  ///In case of My Profile
  List<Cuisines> cuisines;
  List<AwardModel> awards;
  List<DishModel> dishes;

  ChefModel(
      {this.id,
      this.businessName,
      this.businessEmail,
      this.businessPhone,
      this.pickupLocation,
      this.city,
      this.state,
      this.businessImage,
      this.postalCode,
      this.experience,
      this.chefDescription,
      this.userId,
      this.createdAt,
      this.updatedAt});

  ChefModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    businessName = json['business_name'] ?? "";
    businessEmail = json['business_email'] ?? "";
    businessPhone = json['business_phone'] ?? "";

    pickupLocation = json['pickup_location'] != null &&
            jsonDecode(json['pickup_location']) is Map
        ? LocationModel.fromJson(jsonDecode(json['pickup_location']))
        : null;
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    businessImage = json['business_image'] ?? "";
    postalCode = json['postal_code'] ?? "";
    experience = json['experience'] ?? "";
    chefDescription = json['chef_description'] ?? "";
    userId = json['user_id'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";

    businessAddress = json['business_address'] ?? "";
    cnic = json['cnic'] ?? "";
    iban = json['iban'] ?? "";
    bankName = json['bank_name'] ?? "";

    if (json['awards'] != null) {
      awards = new List<AwardModel>();
      json['awards'].forEach((v) {
        awards.add(new AwardModel.fromJson(v));
      });
    } else {
      awards = new List<AwardModel>();
    }
    if (json['cuisines'] != null) {
      cuisines = new List<Cuisines>();
      json['cuisines'].forEach((v) {
        cuisines.add(new Cuisines.fromJson(v));
      });
    } else {
      cuisines = new List<Cuisines>();
    }

    if (json['dishes'] != null) {
      dishes = new List<DishModel>();
      json['dishes'].forEach((v) {
        dishes.add(new DishModel.fromJson(v));
      });
    } else {
      dishes = new List<DishModel>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['business_email'] = this.businessEmail;
    data['business_phone'] = this.businessPhone;
    data['pickup_location'] = this.pickupLocation;
    data['city'] = this.city;
    data['state'] = this.state;
    data['business_image'] = this.businessImage;
    data['postal_code'] = this.postalCode;
    data['experience'] = this.experience;
    data['chef_description'] = this.chefDescription;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
