import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/screens/wallet/components/records_screen.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';

import '../models/cases_from_server.dart';
import '../serves/record_serves.dart';

class RecordController extends GetxController {
  //Models
  //late Record myPayRecord;
  static dynamic myPayRecords;
  static dynamic myTakeRecords;
  static dynamic myGiveRecords;

  //Serves
  RecordServes service = RecordServes();
  CheckValidTokenServes checkToken = CheckValidTokenServes();

  //Values
  String? check;
  String? checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> getMyPayRecords() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyPayRecords();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenInPayRecords();
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
      getMyPayRecords();
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

  Future<void> getMyTakeRecords() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyTakeRecords();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenInTakeRecords();
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
      getMyTakeRecords();
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

  Future<void> getMyGiveRecords() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToMyGiveRecords();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenInPayRecords();
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
      getMyGiveRecords();
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
  void tokenExpiredAfterCheckTokenInPayRecords() async {
    checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyPayRecords();
    } else {
      EasyLoading.showError(
        service.message,
      );
    }
  }

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckTokenInTakeRecords() async {
    checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyPayRecords();
    } else {
      EasyLoading.showError(
        service.message,
      );
    }
  }

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckTokenInGiveRecords() async {
    checkResponse = await service.reciveMyPayRecords(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToMyPayRecords();
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
  void goToMyPayRecords() async {
    myPayRecords = service.myPayRecords;
    Get.toNamed(
      '/Records',
      arguments: RecordsScreenArguments(
        records: myPayRecords,
      ),
    );
    showInfo(
      service.message,
      CasesFromServer.second,
    );
  }

  //Waiting New Widget For This Function
  void goToMyTakeRecords() async {
    myTakeRecords = service.myTakeRecords;
    Get.toNamed(
      '/Records',
      arguments: RecordsScreenArguments(
        records: myTakeRecords,
      ),
    );
    showInfo(
      service.message,
      CasesFromServer.second,
    );
  }

  //Waiting New Widget For This Function
  void goToMyGiveRecords() async {
    myGiveRecords = service.myGiveRecords;
    Get.toNamed(
      '/Records',
      arguments: RecordsScreenArguments(
        records: myGiveRecords,
      ),
    );
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
