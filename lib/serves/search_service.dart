// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/search_type.dart';

class SearchService {
  late SearchType searchValue;
  late List<dynamic> result;
  late List<UserByName> users;
  late List<ProductByYName> products1;
  late List<ProductByYName> products2;
  late List<ProductByYName> products3;
  late List<ProductByYName> products4;
  var message = '';
  Future<bool> serach(dynamic value, String? searchType) async {
    try {
      var response = await http.get(
        Uri.parse(ConstServer.domaiNname + ConstServer.search + '$value'),
        headers: {},
      );

      if (response.statusCode == 200) {
        //var jsonResponse = jsonDecode(response.body);
        searchValue = searchTypeFromJson(response.body);
        if (searchType == CasesFromServer.searchByProductName) {
          result = searchValue.productByName;
          users = [];
          afterSearch(result);
        } else if (searchType == CasesFromServer.searchByPrice) {
          result = searchValue.productByPrice;
          users = [];
          afterSearch(result);
        } else if (searchType == CasesFromServer.searchByCategoryName) {
          result = searchValue.productByCategoryName;
          users = [];
          afterSearch(result);
        } else if (searchType == CasesFromServer.searchByUserName) {
          users = searchValue.userByName;
          result = [];
          afterSearch(users);
        } else {
          products1 = searchValue.productByName;
          products2 = searchValue.productByPrice;
          products3 = searchValue.productByCategoryName;
          result = [...products1, ...products2, ...products3];
          users = searchValue.userByName;
          afterSearchUsersAndProducts(result, users);
        }
        return true;
      } else if (response.statusCode > 200 && response.statusCode < 500) {
        message = CasesFromServer.errorFromServer;
        return false;
      } else {
        message = CasesFromServer.noImage;
        return false;
      }
    } catch (e) {
      message = CasesFromServer.noImage;
      return false;
    }
  }

  void afterSearch(dynamic result) {
    if (result.isEmpty) {
      message = CasesFromServer.failedSearch;
    } else {
      message = CasesFromServer.successSearch;
    }
  }

  void afterSearchUsersAndProducts(List<dynamic> result, List<dynamic> users) {
    if (result.isEmpty && users.isEmpty) {
      message = CasesFromServer.failedSearch;
    } else {
      message = CasesFromServer.successSearch;
    }
  }
}
