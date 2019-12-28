import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServer {
  Future postWithoutTokenAndStoreUserData(
      {String url, FormData data, bool islogin}) async {
    print(url);
    print(data);
    try {
      return await Dio()
          .post(url,
              data: data,
              options: Options(
                headers: {
                  "Accept": "application/json",
                },
                validateStatus: (status) {
                  return status < 500;
                },
              ))
          .then((response) async {
        print(response.data);
        print(response.statusCode);

        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token",response.data['token']);
        }

        return response;
      });
    } catch (e) {
      print("ERROR! postWithoutTokenAndStoreUserData $e");
      return null;
    }
  }
}
