import 'package:shared_preferences/shared_preferences.dart';

class UserStreamModel {
  String email, firstName, lastName, image, phoneNo,role;

  UserStreamModel(
      {this.email = "",
      this.firstName = "",
      this.lastName = "",
      this.image = "",
      this.phoneNo = "",
        this.role = "1",
      });

  getModelFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.email = prefs.getString("email");
    this.firstName = prefs.getString("firstName");
    this.lastName = prefs.getString("lastName");
    this.phoneNo = prefs.getString("phoneNumber");
    this.image = prefs.getString("image");
    this.role = prefs.getString("role");
  }

}
