// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/secure_storage.dart';
import 'package:shopping_home/models/user_information.dart';

class RefreshTokenServes {
  SecureStorage store_Token = SecureStorage();
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.refreshToken);
  Future<bool> refresh_token(String? token) async {
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        token = jsonResponse['refresh_token'];
        await store_Token.save('token', token!);
        UserInformation.myToken = token;
        return true;
      } else {
        await store_Token.save('token', '');
        UserInformation.myToken = null;
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
