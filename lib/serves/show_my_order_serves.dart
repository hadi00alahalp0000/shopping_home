import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/my_order.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import '../const_server.dart';

class ShowMyOrderServes {
  //Models
  late MyOrder myOrder;
  //Serves
  RefreshTokenServes refresToken = RefreshTokenServes();
  //Values
  var message = '';
  var refresh = false;
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.showMyOrder);
  Future<String> reciveMyOrder(String? token) async {
    //try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        myOrder = myOrderFromJson(response.body);
        if (myOrder.orderProducts.isEmpty) {
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
      } else if (response.statusCode > 200 &&
          response.statusCode != 401 &&
          response.statusCode < 500) {
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
}
