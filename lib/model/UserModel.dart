import 'package:shared_preferences/shared_preferences.dart';


class UserModel {
  int id;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  String image;
  String phoneNumber;
  String dateOfBirth;
  String role;
  String gender;

  UserModel(
      {this.id,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.image,
        this.phoneNumber,
        this.dateOfBirth,
        this.role,
        this.gender});


  static String getInitials(String firstName, String lastName) {
    String nameFirst = "";
    String nameLast = "";
    try {
      nameFirst = firstName.substring(0, 1).toUpperCase();
    } catch (e) {}

    try {
      nameLast = lastName.substring(0, 1).toUpperCase();
    } catch (e) {
      nameLast = ".";
    }

    return nameFirst + nameLast;
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    print(token);
    return token;
  }


  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    role = json['role'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['role'] = this.role;
    data['gender'] = this.gender;
    return data;
  }
}

