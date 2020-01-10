import 'dart:convert';


import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/error/debugerror.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/UserModel.dart';
import 'package:homemade/model/loginModel.dart';
import 'package:homemade/res/stringapi.dart';

import 'checkToken.dart';

class API {
  GlobalKey<ScaffoldState> scaffold;

  API(this.scaffold);

  Future postWithoutTokenAndStoreUserData(
      {String url, FormData body, bool storeUserData}) async {
    print(url);
    print(body);
    try {
      bool checkConnection = await _checkConnection();
      if (!checkConnection) {
        return null;
      }

      Response response = await Dio().post(url,
          data: body,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            validateStatus: (status) {
              return status < 500;
            },
          ));

      print(response.data);
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        if (storeUserData) {
          LoginModel model = LoginModel.fromJson(response.data);

          model.prefsSet();

          Response responseGet = await get(url: USER_URL);
          if (responseGet != null) {
            print("Respons eget");

            LoginModel userModel = LoginModel.fromJson(responseGet.data);
//            return null;
            userModel.prefsSet();
            return responseGet;
          } else {
            /// Logout user again
            model.clearPrefs();
            return null;
          }
        } else
          return response;
      } else
        _serverResponse(response);
    } catch (e) {
      print("ERROR! postWithoutTokenAndStoreUserData $e");
      return null;
    }
  }

  Future<Response> get({String url}) async {
    print("GET $url");

    ///check internet Connectivity

    bool checkConnection = await _checkConnection();
    if (!checkConnection) {
      return null;
    }

    String token = await UserModel.getToken();

    ///Make an api call
    Dio dio = Dio();
    Response response = await dio.get(url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json"
          },
          receiveTimeout: 5000,
          validateStatus: (status) {
            return status < 500;
          },
        ));

    print(response.data);
    print(response.statusCode);

    int checkToken = await RefreshToken.checkTokenIsValid(response);
    if (checkToken == 1)
      return _serverResponse(response);
    else if (checkToken == 2)
      return await get(url: url);
    else
      return null;
  }

  Future<Response> put({String url, var body,String contentType}) async {
    try {
      print("Put $url");
      print(contentType);

      bool checkConnection = await _checkConnection();
      if (!checkConnection) {
        return null;
      }

      String token = await UserModel.getToken();

      Response response = await Dio().put(url,
          data: body,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              "Accept": "application/json"
            },receiveTimeout: 5000,
            contentType: contentType!=null? contentType :null ,
            validateStatus: (status) {
              return status < 500;
            },
          ));
      print(response.data);
      print(response.statusCode);

      int checkToken = await RefreshToken.checkTokenIsValid(response);
      if (checkToken == 1)
        return _serverResponse(response);
      else if (checkToken == 2)
        return await put(url: url, body: body);
      else
        return null;
    } catch (e) {
      print("Post API ERROR $e");
      return null;
    }
  }

  Future<Response> post({String url, var body, String contentType}) async {
    try {
      print(url);

//      body.fields.forEach((field) => print(field.key + " " + field.value));
      if (body is FormData) {
        print(body.length);
        print(body.isFinalized);
        body.fields.forEach((field)=>print(field.key+" "+field.value));
        body.files.forEach((file){print(file.key);
        print(file.value.contentType);
        print(file.value.filename);
        });
//        if(!body.isFinalized)
//          body.finalize();
      }

      bool checkConnection = await _checkConnection();
      if (!checkConnection) {
        return null;
      }

      String token = await UserModel.getToken();


      Response response = await Dio().post(url,
          data: body,
          options: Options(
            headers:  {
              "Authorization": 'Bearer $token',
              "Accept": "application/json"
            },
            contentType: contentType!=null? contentType :null ,
            validateStatus: (status) {
              return status <= 500;
            },
          ));

      print(response.data);
      print(response.statusCode);

      int checkToken = await RefreshToken.checkTokenIsValid(response);
      if (checkToken == 1)
        return _serverResponse(response);
      else if (checkToken == 2)
        return await post(url: url, body: body);
      else
        return null;
    } catch (e) {
      print("Post API ERROR $e");
      return null;
    }
  }

  _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      CustomSnackBar.SnackBar_3Error(scaffold,
          title: "Please Connect to Internet!",
          leadingIcon: Icons.not_interested);
      return false;
    }
  }

  Future<Response> _serverResponse(Response response) async {
    if (response.statusCode >= 200 && response.statusCode <= 204)
      return response;
    else if (response.statusCode >= 400 &&
        response.statusCode < 500 &&
        response.statusCode != 404 &&
        response.statusCode != 405)
      DebugError.CheckMap(response.data, scaffold);
    else if (response.statusCode == 404)
      CustomSnackBar.SnackBar_3Error(scaffold,
          leadingIcon: Icons.error_outline, title: "Please Contact Support");
    else if (response.statusCode == 405)
      CustomSnackBar.SnackBar_3Error(scaffold,
          leadingIcon: Icons.error_outline, title: "Method Not Allowed");
    else if (response.statusCode > 405 && response.statusCode < 500)
      CustomSnackBar.SnackBar_3Error(scaffold,
          leadingIcon: Icons.error_outline,
          title: "Error! Code ${response.statusCode}");
    else if (response.statusCode == 500)
      CustomSnackBar.SnackBar_3Error(scaffold,
          leadingIcon: Icons.error_outline, title: "Server not responding");
    else
      CustomSnackBar.SnackBar_3Error(scaffold,
          leadingIcon: Icons.error_outline,
          title: "Error! Code ${response.statusCode}");
    return null;
  }

//  Future get({String url,String param=""}) async{
//    print(url+param);
//  }

//  Future postWithoutToken({String url,Map body}) async{
//    print(url);
//    try{
//
//      return await http.post(url,body: jsonEncode(body)).then((response) async{
//        final String responseBody = (response.body);
//        print(responseBody);
//        print(response.statusCode);
//          return response;
//      });
//
//    }catch(e){
//      print("ERROR! Post $e");
//    }
//  }
//
//
//  Future post({String url,Map body}) async{
//    print(url);
//    try{
//
////      String token = await LoginModel.getToken();
//
//      return await http.post(url,body: jsonEncode(body),headers: {
//        "Content-Type": "application/json"
////        "Authorization": "jwt $token"
//      }).then((response) async{
//        final String responseBody = (response.body);
//        print(responseBody);
//        print(response.statusCode);
//        int checkStatus = await RefreshToken.checkTokenIsValid(response);
//
//        if (checkStatus == 1) {
//          return response;
//        } else if(checkStatus==2) {
//          return postWithoutToken(url: url, body: body);
//        }
//      });
//
//    }catch(e){
//      print("ERROR! Post $e");
//    }
//  }

}
