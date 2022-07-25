// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/product.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

class EditProductServes {
  // Values
  var message;
  var refresh;
  late Map<String, dynamic> errorMap;

  // Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();

  Future<String> editProduct(String? token, Product product, int id) async {
    try {
      var response = await http.post(
        Uri.parse(ConstServer.domaiNname + ConstServer.editProduct + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        // Maybe The Body Want To Be More Cleary Or Want To Use Dio Here
        body: productToJson(product),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse['message'];
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
        errorMap = jsonResponse['error'];
        // convert the Map from back to List<dynamic>
        convertMapToList() => errorMap.entries.map((e) => e.value).toList();
        // convert the list<dynamic> here to text and save it in message
        if (convertMapToList() is List) {
          String text = '';
          for (List<dynamic> l in convertMapToList()) {
            if (l is List) {
              for (dynamic s in l) {
                if (s is String) {
                  // convert the list that have string to string
                  text += s + '\n';
                } else {
                  // convert the list that have dynamic value like int or double ....etc to string
                  text += '$s' + '\n';
                }
              }
            }
          }
          if (text == '') {
            message = CasesFromServer.errorFromServer;
          } else {
            message = text;
          }
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
