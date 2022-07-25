import 'package:shopping_home/const_server.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_home/serves/refresh_token_serves.dart';
import 'package:shopping_home/models/cases_from_server.dart';

class CheckValidTokenServes {
  var message = '';
  var refresh = false;
  RefreshTokenServes refreshToken = RefreshTokenServes();
  var url = Uri.parse(ConstServer.domaiNname + ConstServer.checkToken);
  Future<String> checkValidToken(String? token) async {
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return CasesFromServer.can;
      } else if (response.statusCode == 401) {
        refresh = await refreshToken.refresh_token(token);
        if (refresh) {
          return CasesFromServer.maybe;
        } else {
          message = CasesFromServer.trySignInAgain;
          return CasesFromServer.trySignInAgain;
        }
      } else if (response.statusCode > 200 &&
          response.statusCode != 401 &&
          response.statusCode < 500) {
        message = CasesFromServer.beWithUs;
        return CasesFromServer.trySignInAgain;
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
