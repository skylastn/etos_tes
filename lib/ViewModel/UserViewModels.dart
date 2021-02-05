import 'package:etos_tes/Model/User.dart';
import 'package:etos_tes/Network/ApiClient.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class UserViewModels {
  static Future<User> getUser() async {
    // future is used to handle the error when calling api > Future + async or await
    ApiClient apiClient = new ApiClient();
    var dan = '&';
    // var materiget = 'idahli='+iduser;
//    print(materiget);
    var data = await http.get(apiClient.getBaseUrl()+"User", headers: {
      'Accept': 'application/json',
    });

    print('Cek Data User : '+data.body);
    return userFromJson(data.body);


  }
}
