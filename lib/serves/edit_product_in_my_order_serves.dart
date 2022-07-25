// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

class EditProductInMyOrderServes {
  var message;
  var refresh;
  //Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> editProductInMyOrder(
    String? token,
    int quantities,
    int id,
  ) async {
    try {
      var response = await http.post(
        Uri.parse(
            ConstServer.domaiNname + ConstServer.editProductInMyOrder + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'quantities': quantities,
        },
      );
      if (response.statusCode == 200) {
        message = CasesFromServer.editProductQuantitiesInMyOrder;
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
        if (jsonResponse == 'The amount of product is insufficient !!!') {
          message = CasesFromServer
              .addOrEditProductToMyOrderImpossibleWithThisQuantities;
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
