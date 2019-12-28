import 'package:shared_preferences/shared_preferences.dart';

class UserStreamModel {
  String email, firstName, lastName, image, phoneNo;

  UserStreamModel(
      {this.email = "",
      this.firstName = "",
      this.lastName = "",
      this.image = "",
      this.phoneNo = ""
      });

  getModelFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.email = prefs.getString("email");
    this.firstName = prefs.getString("first_name");
    this.lastName = prefs.getString("last_name");
    this.image = prefs.getString("image");
    this.phoneNo = prefs.getString("phoneNo");
  }

}
