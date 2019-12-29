import 'dart:convert';

import 'package:dio/dio.dart';


class RefreshToken{


  static checkTokenIsValid(Response response) async{
    if (response.statusCode == 401) {
      String decode;
//      try {
//        decode = jsonDecode(response.data)['detail'];
//      }catch(e){
        decode = response.data['detail'];
//      }
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

//      GeneralAPI auth = GeneralAPI();

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