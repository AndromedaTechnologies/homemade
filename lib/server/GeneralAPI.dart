
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'checkToken.dart';

class GeneralAPI{

  Future get({String url,String param=""}) async{
    print(url+param);
  }


  Future postWithoutToken({String url,Map body}) async{
    print(url);
    try{

      return await http.post(url,body: jsonEncode(body)).then((response) async{
        final String responseBody = (response.body);
        print(responseBody);
        print(response.statusCode);
          return response;
      });

    }catch(e){
      print("ERROR! Post $e");
    }
  }


  Future post({String url,Map body}) async{
    print(url);
    try{

//      String token = await LoginModel.getToken();

      return await http.post(url,body: jsonEncode(body),headers: {
        "Content-Type": "application/json"
//        "Authorization": "jwt $token"
      }).then((response) async{
        final String responseBody = (response.body);
        print(responseBody);
        print(response.statusCode);
        int checkStatus = await RefreshToken.checkTokenIsValid(response);

        if (checkStatus == 1) {
          return response;
        } else if(checkStatus==2) {
          return postWithoutToken(url: url, body: body);
        }
      });

    }catch(e){
      print("ERROR! Post $e");
    }
  }

}