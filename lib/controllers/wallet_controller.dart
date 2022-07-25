import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/wallet_serves.dart';

import '../models/cases_from_server.dart';

class WalletController extends GetxController {
  //Values
  late String check;
  late String checkResponse;
  //Serves
  late WalletServes service;
  late CheckValidTokenServes checkToken;
  //late MyWallet wallet;
  static dynamic wallet;

  @override
  void onInit() {
    checkResponse = 'cant';
    checkToken = CheckValidTokenServes();
    service = WalletServes();
    super.onInit();
  }

  // Get One User From The Server
  Future<void> getWallet() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyWallet(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyWallet(
          service.message,
          CasesFromServer.second,
        );
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken();
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          CasesFromServer.trySignInAgain,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      getWallet();
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

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckToken() async {
    checkResponse = await service.reciveMyWallet(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyWallet(
        service.message,
        CasesFromServer.second,
      );
    } else {
      EasyLoading.showError(service.message);
    }
  }

  // Go To My Wallet
  // Not Finshed Want The Wallet Widget Name To Be Done
  void goToMyWallet(String info, int sec) {
    wallet = service.wallet;
    Get.toNamed('Wallet');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
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
}
