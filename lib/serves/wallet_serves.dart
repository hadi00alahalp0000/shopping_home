import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import '../const_server.dart';
import '../models/my_wallet.dart';

class WalletServes {
  var message = '';
  var refresh = false;
  late MyWallet wallet;
  RefreshTokenServes refresToken = RefreshTokenServes();
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.showMyWallet);
  Future<String> reciveMyWallet(String? token) async {
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      wallet = MyWallet.fromJson(jsonResponse['message']);
      message = CasesFromServer.goToMyWallet;
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
  }
}
