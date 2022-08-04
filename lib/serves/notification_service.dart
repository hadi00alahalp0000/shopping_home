import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopping_home/models/notification.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import 'package:http/http.dart' as http;

import '../const_server.dart';
import '../models/cases_from_server.dart';

class NotificationService {
  List<MyNotification>? myNotifications = [];

  // late MyNotifications notifications;
  // Service
  RefreshTokenServes refresToken = RefreshTokenServes();
  // Values
  var message = '';
  var refresh = false;
  var url = ConstServer.domaiNname + ConstServer.showAllMyNotification;

  Future<String> reciveMyNotifications(String? token) async {
    //try {
    var response = await Dio().get(
      ConstServer.domaiNname + ConstServer.showAllMyNotification,
      options: Options(headers: {
        "authorization": "Bearer $token",
      }),
    );
    if (response.statusCode == 200) {
      //print(response.data.json.encode);
      myNotifications = myNotificationFromJson(json.encode(response.data));

      if (myNotifications!.isEmpty) {
        message = CasesFromServer.dontHaveOrder;
      } else {
        message = CasesFromServer.haveOrder;
      }
      return CasesFromServer.can;
    } else if (response.statusCode == 401) {
      refresh = await refresToken.refresh_token(token);
      if (refresh) {
        return CasesFromServer.maybe;
      } else {
        message = CasesFromServer.trySignInAgain;
        return CasesFromServer.trySignInAgain;
      }
    } else if (response.statusCode! > 200 &&
        response.statusCode != 401 &&
        response.statusCode! < 500) {
      message = CasesFromServer.errorFromServer;
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

  Future<String> deleteMyNotification(String? token, int index) async {
  var response = await Dio().get(
      ConstServer.domaiNname +
          ConstServer.deleteMyNotification +
          index.toString(),
      options: Options(headers: {
        "authorization": "Bearer $token",
      }));
      if (response.statusCode == 200) {
      //print(response.data.json.encode);
      
      return CasesFromServer.can;
    } else if (response.statusCode == 401) {
      refresh = await refresToken.refresh_token(token);
      if (refresh) {
        return CasesFromServer.maybe;
      } else {
        message = CasesFromServer.trySignInAgain;
        return CasesFromServer.trySignInAgain;
      }
    } else if (response.statusCode! > 200 &&
        response.statusCode != 401 &&
        response.statusCode! < 500) {
      message = CasesFromServer.errorFromServer;
      return CasesFromServer.cant;
    } else {
      message = CasesFromServer.noInternet;
      return CasesFromServer.cant;
    }

  }
  Future<String> deleteAllMyNotifications(String? token) async {
  var response = await Dio().get(
      ConstServer.domaiNname +
          ConstServer.deleteAllMyNotification,
      options: Options(headers: {
        "authorization": "Bearer $token",
      }));
      if (response.statusCode == 200) {
      //print(response.data.json.encode);
      
      return CasesFromServer.can;
    } else if (response.statusCode == 401) {
      refresh = await refresToken.refresh_token(token);
      if (refresh) {
        return CasesFromServer.maybe;
      } else {
        message = CasesFromServer.trySignInAgain;
        return CasesFromServer.trySignInAgain;
      }
    } else if (response.statusCode! > 200 &&
        response.statusCode != 401 &&
        response.statusCode! < 500) {
      message = CasesFromServer.errorFromServer;
      return CasesFromServer.cant;
    } else {
      message = CasesFromServer.noInternet;
      return CasesFromServer.cant;
    }

  }
}



