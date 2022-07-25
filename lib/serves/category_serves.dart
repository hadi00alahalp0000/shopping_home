// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryServes {
  // Models
  late List<Category> categories;
  late Category category;
  // Values
  var message = '';
  //Url
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.showAllCategories);

  Future<bool> reciveCategories() async {
    try {
      var response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        categories = categoryFromJson(response.body);

        if (categories.isEmpty) {
          message = CasesFromServer.categoryDontHaveProducts;
          return true;
        } else {
          message = CasesFromServer.categoryHaveProducts;
          return true;
        }
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

  Future<bool> reciveCategoryByProductId(int id) async {
    try {
      var response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        category = Category.fromJson(jsonResponse);
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
