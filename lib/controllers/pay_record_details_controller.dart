import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';

import '../models/cases_from_server.dart';
import '../serves/pay_record_details_serves.dart';

class PayRecordDetailsController extends GetxController {
  //Models
  //late Record myPayRecord;
  static dynamic payRecordDetails;

  //Serves
  PayRecordDetailsServes service = PayRecordDetailsServes();
  CheckValidTokenServes checkToken = CheckValidTokenServes();

  //Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  // Want PayRecord Id To Start
  Future<void> getPayRecordDetails(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.recivePayRecordDetails(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        goToPayRecordDetails();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(id);
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
      getPayRecordDetails(id);
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
  void tokenExpiredAfterCheckToken(int id) async {
    checkResponse =
        await service.recivePayRecordDetails(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      goToPayRecordDetails();
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
  void goToPayRecordDetails() async {
    payRecordDetails = service.payRecordDetails;
    //Myabe We Dont Need This
    //Get.offAllNamed('');
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
