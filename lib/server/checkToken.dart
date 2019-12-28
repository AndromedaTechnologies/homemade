import 'dart:convert';

import 'package:homemade/server/GeneralAPI.dart';
import 'package:http/http.dart' as http;

class RefreshToken{


  static checkTokenIsValid(http.Response responseHttp) async{
    if (responseHttp.statusCode == 401) {
      String decode = jsonDecode(responseHttp.body)['detail'];
      print(decode);
      if (false)
        return await refreshToken();
    }
    return 1;
  }

  static refreshToken() async{
    try {

//      String email = await UserModel.getEmail();
//      String password = await UserModel.getPassword();

//      Map<String, String> body = {
//        'username': email,
//        'password': password
//      };

      GeneralAPI auth = GeneralAPI();

//      http.Response response = await auth.postWithoutToken(url: loginURL,body: body);

//      if (response.statusCode != 200) {
//        throw Exception;
//      }

      return 2;

    } catch (e) {
      print("Refresh Token Failed");
//      UserModel.clearToken();

    return 3;
    }
  }

}