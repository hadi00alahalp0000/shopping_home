// ignore_for_file: non_constant_identifier_names

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/secure_storage.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/sign_out_serves.dart';

class SignOutController extends GetxController {
  late String check;
  late String checkResponse;
  late SignOutServes service;
  late SecureStorage stored_token;
  late CheckValidTokenServes checkToken;

  @override
  void onInit() {
    checkResponse = 'cant';
    check = 'cant';
    service = SignOutServes();
    stored_token = SecureStorage();
    checkToken = CheckValidTokenServes();

    super.onInit();
  }

  Future<void> logingOut() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      await user_log_out(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        letsGo('/Splash', 'Logged Out');
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken();
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      logingOut();
    } else if (check == CasesFromServer.trySignInAgain) {
      goToSignIn(
        '/SignIn',
        checkToken.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        checkToken.message,
        CasesFromServer.second,
      );
    }
  }

  // Function to Show Errors Comming From Server
  void showError(String info, int sec) {
    EasyLoading.showError(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  void goToSignIn(String route, String info, int sec) {
    Get.offAllNamed(route);
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  void letsGo(String route, String info) async {
    await stored_token.save('token', '');
    UserInformation.myToken == null;
    Get.offAllNamed(route);
    EasyLoading.showSuccess(info.tr);
  }

  Future<void> user_log_out(String? token) async {
    checkResponse = await service.logout(token);
  }

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckToken() async {
    await user_log_out(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      letsGo('/Splash', 'Logged Out');
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }
}
