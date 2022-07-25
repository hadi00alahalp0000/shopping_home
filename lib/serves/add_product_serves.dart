// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, unnecessary_new, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';
import 'package:shopping_home/models/product.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

import '../const_server.dart';
import '../models/cases_from_server.dart';
import '../models/user_information.dart';

class AddProductServes {
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.addProduct);
  var message;
  var refresh;
  late Map<String, dynamic> errorMap;
  //Controller
  SendImageController controller = Get.put(SendImageController());
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> addProduct(String? token, Product product) async {
    // Maybe Want To Be More Clear Body Or Using Dio Here
    /* try { */
    Dio dio = new Dio();
    var response = await Dio().post(
      url.toString(),
      options: Options(headers: {
        "authorization": "Bearer $token",
      }),
      data: productToJson(product),
    );
    if (response.statusCode == 200) {
      var responseData = response.data;
      message = responseData['message'];
      //Get Product Id From Server
      var prod = responseData['Product'];
      int id = prod['id'];
      // Waiting Image To Be Storing In The Server
      await controller.addImage(ConstServer.productImage, id);
      return CasesFromServer.can;
    } else if (response.statusCode == 401) {
      refresh = await refreshToken.refresh_token(UserInformation.myToken);
      if (refresh) {
        return CasesFromServer.maybe;
      } else {
        message = CasesFromServer.trySignInAgain;
        return CasesFromServer.trySignInAgain;
      }
    } else if (response.statusCode! > 200 &&
        response.statusCode != 401 &&
        response.statusCode! < 500) {
      var jsonResponse = jsonDecode(response.data);
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
    /* } catch (e) {
      message = CasesFromServer.noInternet;
      return CasesFromServer.cant;
    } */
  }
}
