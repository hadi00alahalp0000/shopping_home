import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_home/serves/notification_service.dart';

import '../models/cases_from_server.dart';
import '../models/user_information.dart';
import '../serves/check_valida_token_serves.dart';

class ShowMyNotificationController extends GetxController {
  //Models
  //late MyOrder myOrder;
  static dynamic myNotifications;

  //Serves
  NotificationService service = NotificationService();
  CheckValidTokenServes checkToken = CheckValidTokenServes();

  //Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    //checkToken = CheckValidTokenServes();
    //service = NotificationService();
    super.onInit();
  }

  Future<void> getMyNotifications() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.reciveMyNotifications(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyNotifications();
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
      getMyNotifications();
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
    checkResponse =
        await service.reciveMyNotifications(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyNotifications();
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
  void goToMyNotifications() {
    myNotifications = service.myNotifications;
    Get.toNamed('/Notifications');
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

  Future<void> deleteMyNotification(int index) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.deleteMyNotification(UserInformation.myToken, index);
      if (checkResponse == CasesFromServer.can) {
        goToMyNotifications();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken();
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      getMyNotifications();
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

  Future<void> deleteAllMyNotification() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.deleteAllMyNotifications(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyNotifications();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken();
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      getMyNotifications();
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
}
