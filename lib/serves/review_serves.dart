// ignore_for_file: unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/review.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';

class ReviewServes {
  //Values
  var message;
  var refresh;
  late var notification;
  late List<Review> reviews;
  //Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();
  Future<String> addReview(String? token, Review model, int id) async {
    try {
      var response = await http.post(
        Uri.parse(ConstServer.domaiNname + ConstServer.addReview + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'num_star': model.numStar,
          'review': model.review,
        },
      );
      if (response.statusCode == 200) {
        message = CasesFromServer.addedReview;
        var jsonResponse = jsonDecode(response.body);
        notification = jsonResponse['state_send_notification'];
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
        message = CasesFromServer.cantAddReviewAgain;
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

  Future<String> deleteReview(String? token, int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.deleteReview + '$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        message = CasesFromServer.deleteReview;
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

  // Want Product Id
  Future<String> reciveAllReview(int id) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.showAllReview + '$id'),
        headers: {},
      );
      if (response.statusCode == 200) {
        reviews = reviewFromJson(response.body);
        if (reviews.isEmpty) {
          message = CasesFromServer.dontHaveReview;
        } else {
          message = CasesFromServer.haveReview;
        }
        return CasesFromServer.can;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
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
}
