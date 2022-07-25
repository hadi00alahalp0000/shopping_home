// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

import '../const_server.dart';
import 'package:http/http.dart' as http;

class EditProfileServes {
  RefreshTokenServes refreshToken = RefreshTokenServes();
  bool refresh = false;
  String? token;
  var message = '';
  late Map<String, dynamic> errorMap;
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.updateMyProfile);
  Future<String> editProfile(String? token, EditPerson p) async {
    // try {
      final userBirthdate = DateFormat('yyyy/MM/dd').format(p.birthdate);
      p.facebook_url ??= '';
      p.whatsapp ??= '';
      p.skype ??= '';
      p.telegram_url ??= '';
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "firstname": p.firstname,
          "lastname": p.lastname,
          "password": p.password,
          "birthdate": userBirthdate,
          "governorate": p.governorate,
          "region": p.region,
          "street": p.street,
          "phone_number": p.phone_number,
          "contact_email": p.contact_email,
          "facebook_url": p.facebook_url,
          "telegram_url": p.telegram_url,
          "whatsapp": p.whatsapp,
          "skype": p.skype,
        },
      );
      if (response.statusCode == 200) {
        return CasesFromServer.can;
      } else if (response.statusCode == 401) {
        refresh = await refreshToken.refresh_token(token);
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
    // } catch (e) {
    //   message = CasesFromServer.noInternet;
    //   return CasesFromServer.cant;
    // }
  }
}
