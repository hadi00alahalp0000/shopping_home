// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/models/secure_storage.dart';

class SignInServes {
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.signIn);
  var notiUrl =
      Uri.parse(ConstServer.domaiNname + ConstServer.storeNotification);
  var message;
  String? token = '';

  Future<bool> signin(user, bool remember) async {
    try {
      var response = await http.post(
        url,
        headers: {},
        body: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse['success'];
        token = jsonResponse['token'];
        UserInformation.myToken = token;

        final notificationToken = await FirebaseMessaging.instance.getToken();

        var notificationResponse = await http.get(
          notiUrl,
          headers: {
            'token': '$notificationToken',
            'Authorization': 'Bearer $token'
          },
        );

        print(notificationResponse.body);
        print(notificationResponse.statusCode);

        if (remember) {
          //save token to the device
          SecureStorage storage = SecureStorage();
          await storage.save('token', UserInformation.myToken!);
          String? languge = await storage.read('language');
          if (languge == 'true') {
            await storage.save('language', 'true');
          } else {
            await storage.save('language', 'false');
          }
        }
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse['message'];
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
}
