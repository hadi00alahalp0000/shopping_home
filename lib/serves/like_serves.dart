// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings


import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

class LikeServes {
  var message;
  var refresh;
  //Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> addLike(String? token, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.addLike + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        //var jsonResponse = jsonDecode(response.body);
        //var notifcationMessage = jsonResponse['state_send_notification'];
        message = CasesFromServer.youAddedLike;

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
        message = CasesFromServer.cantAddLikeAgain;
        return CasesFromServer.cantAddLikeAgain;
      } else {
        message = CasesFromServer.noInternet;
        return CasesFromServer.cant;
      }
    } catch (e) {
      message = CasesFromServer.noInternet;
      return CasesFromServer.cant;
    }
  }

  Future<String> deleteLike(String? token, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.deleteLike + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        message = CasesFromServer.deleteLike;
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

  Future<bool> checkLike(String? token, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.checkLike + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
