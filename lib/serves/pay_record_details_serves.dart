// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import '../const_server.dart';
import '../models/pay_record_details.dart';

class PayRecordDetailsServes {
  //Models
  late List<PayRecordDetails> payRecordDetails;
  //Serves
  RefreshTokenServes refresToken = RefreshTokenServes();
  //Values
  var message = '';
  var refresh = false;
  Future<String> recivePayRecordDetails(String? token, int id) async {
    try {
      var url = Uri.parse(
          ConstServer.domaiNname + ConstServer.payRecordDetails + '$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        payRecordDetails = payRecordDetailsFromJson(response.body);
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
}
