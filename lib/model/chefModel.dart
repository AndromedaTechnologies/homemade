
class ChefModel {
  int id;
  String businessName;
  String businessEmail;
  String businessPhone;
  String pickupLocation;
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
    id = json['id']??0;
    businessName = json['business_name']??"";
    businessEmail = json['business_email']??"";
    businessPhone = json['business_phone']??"";
    pickupLocation = json['pickup_location']??"";
    city = json['city']??"";
    state = json['state']??"";
    businessImage = json['business_image']??"";
    postalCode = json['postal_code']??"";
    experience = json['experience']??"";
    chefDescription = json['chef_description']??"";
    userId = json['user_id']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";

    businessAddress = json['business_address']??"";
    cnic = json['cnic']??"";
    iban = json['iban']??"";
    bankName = json['bank_name']??"";
    
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
