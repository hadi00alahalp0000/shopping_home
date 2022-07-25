// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/user_information.dart';

class ForgetPasswordServes {
  var message = '';
  var otbMessage = '';
  String? token = '';
  late Map<String, dynamic> errorMap;
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.forgetPassword);

  Future<bool> forgetPassword(User user, var otb) async {
    try {
      var response = await http.post(
        url,
        headers: {},
        body: {'email': user.email, 'password': user.password, 'otb': otb},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        //message = jsonResponse['message'];
        message = CasesFromServer.welcomeWithUs;
        token = jsonResponse['token'];
        UserInformation.myToken = token;
        return true;
      }
      // Wrong OTB
      else if (response.statusCode == 424) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse['message'];
        return false;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
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
        return false;
      } else {
        message = CasesFromServer.noInternet;
        return false;
      }
    } catch (e) {
      message = CasesFromServer.noInternet;
      return false;
    }
  }

  Future<bool> forgetPasswordOtb(String email) async {
    try {
      var response = await http.post(
        Uri.parse(ConstServer.domaiNname + ConstServer.sendForgetPasswordOtb),
        headers: {},
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        otbMessage = jsonResponse['msg'];
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        otbMessage = CasesFromServer.wrongEmail;
        return false;
      } else {
        otbMessage = CasesFromServer.noInternet;
        return false;
      }
    } catch (e) {
      otbMessage = CasesFromServer.noInternet;
      return false;
    }
  }
}
