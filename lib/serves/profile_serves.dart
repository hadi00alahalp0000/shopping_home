// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/my_profile.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import '../const_server.dart';

class UserService {
  var message = '';
  late List<MyProfile> users;
  late MyProfile account;
  var refresh = false;
  RefreshTokenServes refresToken = RefreshTokenServes();
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.myProfile);
  Future<String> reciveMyAccount(String? token) async {
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        account = MyProfile.fromJson(jsonResponse);
        return CasesFromServer.can;
      } else if (response.statusCode == 401) {
        refresh = await refresToken.refresh_token(token);
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

  // To Get Just One User No More
  Future<bool> reciveUserAccount(String path, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + path + '$id'),
        headers: {},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        account = MyProfile.fromJson(jsonResponse);
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
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

  Future<bool> reciveAllUsersAccounts(String path, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + path + '$id'),
        headers: {},
      );
      if (response.statusCode == 200) {
        users = allUsersFromJson(response.body);
        if (path == ConstServer.showAllUsersLikedProduct) {
          if (users.isEmpty) {
            message = CasesFromServer.dontHaveLike;
          } else {
            message = CasesFromServer.haveLike;
          }
        } else if (path == ConstServer.showAllUsersSawProduct) {
          if (users.isEmpty) {
            message = CasesFromServer.dontHaveView;
          } else {
            message = CasesFromServer.haveView;
          }
        } else {
          if (users.isEmpty) {
            message = CasesFromServer.dontHaveReview;
          } else {
            message = CasesFromServer.haveReview;
          }
        }
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
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
