// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/show_products.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/serves/refresh_token_serves.dart';

class ShowProductsServes {
  // Models
  late List<ShowProducts> products;
  // Serves
  RefreshTokenServes refreshToken = RefreshTokenServes();
  // Values
  var refresh = false;
  var message = '';
  late var response;
  // Function Give You From Server Products You Have Product You (Like , View , Review) It
  Future<String> reciveWhatINeed(String? token, String path) async {
    try {
      response = await http.get(
        Uri.parse(ConstServer.domaiNname + path),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        products = showProductsFromJson(response.body);

        if (path == ConstServer.showAllMyProducts) {
          if (products.isEmpty) {
            message = CasesFromServer.dontHaveProducts;
          } else {
            message = CasesFromServer.haveProducts;
          }
        } else if (path == ConstServer.showAllProductsHaveMyLike) {
          if (products.isEmpty) {
            message = CasesFromServer.dontLikeProducts;
          } else {
            message = CasesFromServer.likeProducts;
          }
        } else if (path == ConstServer.showAllProductsHaveMyView) {
          if (products.isEmpty) {
            message = CasesFromServer.dontViewProducts;
          } else {
            message = CasesFromServer.viewProducts;
          }
        } else {
          if (products.isEmpty) {
            message = CasesFromServer.dontReviewProducts;
          } else {
            message = CasesFromServer.reviewProducts;
          }
        }
        return CasesFromServer.can;
      } else if (response.statusCode == 401) {
        refresh = await refreshToken.refresh_token(token);
        if (refresh) {
          return CasesFromServer.maybe;
        } else {
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

  Future<String> reciveProducts(String path, String? sortType, int? id) async {
    try {
      if (path == ConstServer.showAllProducts) {
        response = await http.get(
          Uri.parse(ConstServer.domaiNname + path),
          headers: {},
        );
      } else if (path == ConstServer.showAllSortedProducts) {
        response = await http.get(
          Uri.parse(ConstServer.domaiNname + path + '$sortType'),
          headers: {},
        );
      } else {
        response = await http.get(
          Uri.parse(ConstServer.domaiNname + path + '$id'),
          headers: {},
        );
      }
      if (response.statusCode == 200) {
        products = showProductsFromJson(response.body);
        if (products.isEmpty) {
          message = CasesFromServer.screenDontHaveProducts;
          return CasesFromServer.can;
        } else {
          message = CasesFromServer.screenHaveProducts;
          return CasesFromServer.can;
        }
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

  //   if (path == ConstServer.showAllProducts) {
  //     response = await http.get(
  //       Uri.parse(ConstServer.domaiNname + path),
  //       headers: {},
  //     );
  //   } else if (path == ConstServer.showAllSortedProducts) {
  //     response = await http.get(
  //       Uri.parse(ConstServer.domaiNname + path + '$sortType'),
  //       headers: {},
  //     );
  //   } else {
  //     response = await http.get(
  //       Uri.parse(ConstServer.domaiNname + path + '$id'),
  //       headers: {},
  //     );
  //   }
  //   if (response.statusCode == 200) {
  //     products = showProductsFromJson(response.body);
  //     if (products.isEmpty) {
  //       message = CasesFromServer.screenDontHaveProducts;
  //     } else {
  //       message = CasesFromServer.screenHaveProducts;
  //     }
  //     return CasesFromServer.can;
  //   } else if (response.statusCode > 200 && response.statusCode < 500) {
  //     message = CasesFromServer.errorFromServer;
  //     return CasesFromServer.cant;
  //   } else {
  //     message = CasesFromServer.noInternet;
  //     return CasesFromServer.cant;
  //   }
  // }
}
