// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

class BuyMyOrderServes {
  var message;
  var refresh;
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.buyMyOrder);
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> buyMyOrder(String? token) async {
    try {
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        jsonResponse = jsonResponse['message'];
        if (jsonResponse ==
            "You don't have enough balance to buy these products") {
          message = CasesFromServer.cantBuyThisOrder;
          return CasesFromServer.cant;
        } else {
          message = CasesFromServer.canBuyThisOrder;
          return CasesFromServer.can;
        }
      } else if (response.statusCode == 401) {
        refresh = await refreshToken.refresh_token(UserInformation.myToken);
        if (refresh) {
          return CasesFromServer.maybe;
        } else {
          message = CasesFromServer.trySignInAgain;
          return CasesFromServer.trySignInAgain;
        }
      } else if (response.statusCode > 200 &&
          response.statusCode != 401 &&
          response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
        return CasesFromServer.cant;
      } else {
        message = CasesFromServer.noInternet;
        return CasesFromServer.cant;
      }
    } catch (e) {
      message = CasesFromServer.noInternet;
      return CasesFromServer.cant;
    }
  }
}
