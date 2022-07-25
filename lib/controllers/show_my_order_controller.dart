import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/show_my_order_serves.dart';

import '../models/cases_from_server.dart';

class ShowMyOrderController extends GetxController {
  //Models
  //late MyOrder myOrder;
  static dynamic myOrder;

  //Serves
  late ShowMyOrderServes service;
  late CheckValidTokenServes checkToken;

  //Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    checkToken = CheckValidTokenServes();
    service = ShowMyOrderServes();
    super.onInit();
  }

  Future<void> getMyOrder() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyOrder(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyOrder();
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
      getMyOrder();
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
    checkResponse = await service.reciveMyOrder(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyOrder();
    } else {
      EasyLoading.showError(
        service.message,
      );
    }
  }

  // Function to Show Success Comming From CasesFromServer
  void showInfo(String info, int sec) {
    EasyLoading.showInfo(
      info.tr,
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

  //Waiting New Widget For This Function
  void goToMyOrder() {
    myOrder = service.myOrder;
    Get.toNamed('/Cart');
    showInfo(
      service.message,
      CasesFromServer.second,
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
