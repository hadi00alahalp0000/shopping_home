// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

import '../models/user_information.dart';

class AddProductToMyOrderServes {
  var message;
  var refresh;
  //Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> addProductToMyOrder(
      String? token, int quantities, int id) async {
    try {
      var response = await http.post(
        Uri.parse(
            ConstServer.domaiNname + ConstServer.addProductToMyOrder + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'quantities': quantities.toString(),
        },
      );

      if (response.statusCode == 200) {
        message = CasesFromServer.addProductToMyOrder;
        return CasesFromServer.can;
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
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse ==
            'You have already added this product, if you want to modify the quantity you can do in your cart  !!!') {
          message = CasesFromServer.cantAddSameProductAgainToMyOrder;
        } else if (jsonResponse ==
            'This quantity is greater than the present !!!') {
          message = CasesFromServer
              .addOrEditProductToMyOrderImpossibleWithThisQuantities;
        } else if (jsonResponse == 'You cant buy your product !!!') {
          message = CasesFromServer.cantBuyMyProducts;
        } else {
          message = CasesFromServer.errorFromServer;
        }
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
