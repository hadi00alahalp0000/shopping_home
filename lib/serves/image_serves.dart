// ignore_for_file: avoid_print, unnecessary_new, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

import '../const_server.dart';

class ImageServes {
  var message = '';
  var refresh = false;
  var sendUrl;
  var getUrl;
  var checkUrl;
  var image;
  RefreshTokenServes refreshTokenServes = RefreshTokenServes();
  Future<String> sendImage(
      String? token, String? path, dynamic data, int? id) async {
    try {
      Dio dio = new Dio();
      if (path == ConstServer.userImage) {
        sendUrl = ConstServer.domaiNname + ConstServer.userImage;
      } else {
        sendUrl = ConstServer.domaiNname +
            ConstServer.productImage +
            '?product_id=' +
            '$id';
      }
      var response = await dio.post(
        sendUrl,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);
        message = jsonResponse['message'];
        return CasesFromServer.can;
      } else if (response.statusCode == 401) {
        refresh = await refreshTokenServes.refresh_token(token);
        if (refresh) {
          return CasesFromServer.maybe;
        } else {
          message = CasesFromServer.trySignInAgain;
          return CasesFromServer.trySignInAgain;
        }
      } else if (response.statusCode! > 200 &&
          response.statusCode! != 401 &&
          response.statusCode! < 500) {
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

  Future<bool> getImage(String? path, int id) async {
    if (path == ConstServer.userImage) {
      getUrl =
          ConstServer.domaiNname + ConstServer.userImage + '?user_id=' + '$id';
      var response = await http.get(
        getUrl,
        headers: {},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var mess = jsonResponse['message'];
        message = mess['profile_img_url'];
        image = Image.network(
          message,
          height: 500,
          width: 500,
        );
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
        return false;
      } else {
        message = CasesFromServer.noInternet;
        return false;
      }
    } else {
      getUrl = ConstServer.domaiNname +
          ConstServer.productImage +
          '?product_id=' +
          '$id';
      var response = await http.get(
        getUrl,
        headers: {},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var mess = jsonResponse['message'];
        message = mess['img_url'];
        image = Image.network(
          message,
          height: 500,
          width: 500,
        );
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
        return false;
      } else {
        message = CasesFromServer.noInternet;
        return false;
      }
    }
  }

  Future<bool> checkImage(int id) async {
    checkUrl = Uri.parse(
      ConstServer.domaiNname + ConstServer.checkUserImage + '?user_id=' + '$id',
    );
    var response = await http.get(
      checkUrl,
      headers: {},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      if (message == 'This user have a profile image') {
        return true;
      } else {
        message = CasesFromServer.noImage;
        return false;
      }
    } else if (response.statusCode > 200 && response.statusCode < 500) {
      message = CasesFromServer.errorFromServer;
      return false;
    } else {
      message = CasesFromServer.noInternet;
      return false;
    }
  }
}
