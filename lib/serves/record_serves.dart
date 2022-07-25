import 'package:http/http.dart' as http;
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/refresh_token_serves.dart';
import '../const_server.dart';
import '../models/record.dart';

class RecordServes {
  //Models
  late List<Record> myPayRecords;
  List<Record>? myTakeRecords;
  List<Record>? myGiveRecords;
  //Serves
  RefreshTokenServes refresToken = RefreshTokenServes();
  //Values
  var message = '';
  var refresh = false;
  Future<String> reciveMyPayRecords(String? token) async {
    //try {
      var url = Uri.parse(ConstServer.domaiNname + ConstServer.payRecord);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Get My Pay Records
        myPayRecords = recordFromJson(response.body);
        returnMessage(myPayRecords);
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
    //} catch (e) {
    //  message = CasesFromServer.noInternet;
    //  return CasesFromServer.cant;
    //}
  }

  Future<String> reciveMyTakeRecords(String? token) async {
    try {
      var url = Uri.parse(ConstServer.domaiNname + ConstServer.takeRecord);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Get My Pay Records
        myTakeRecords = recordFromJson(response.body);
        returnMessage(myTakeRecords);
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

  Future<String> reciveMyGiveRecords(String? token) async {
    try {
      var url = Uri.parse(ConstServer.domaiNname + ConstServer.giveRecord);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Get My Pay Records
        myGiveRecords = recordFromJson(response.body);
        returnMessage(myGiveRecords);
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

  void returnMessage(dynamic result) {
    if (result.isEmpty) {
      message = CasesFromServer.dontHaveRecord;
    } else {
      message = CasesFromServer.haveRecord;
    }
  }
}
