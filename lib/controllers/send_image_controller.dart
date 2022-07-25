// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/image_serves.dart';

class SendImageController extends GetxController {
  //Serves
  ImageServes service = ImageServes();
  CheckValidTokenServes checkToken = CheckValidTokenServes();

  //Values
  static dynamic data;
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  // Add Image To The Product Or User
  Future<void> addImage(String path, int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.sendImage(UserInformation.myToken, path, data, id);
      if (checkResponse == CasesFromServer.can) {
        showSuccess(
          'success',
          CasesFromServer.second,
        );
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(path, data, id);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          4,
        );
      } else {
        showError(
          service.message,
          3,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      addImage(path, id);
    } else if (check == CasesFromServer.trySignInAgain) {
      goToSignIn(
        '/SignIn',
        checkToken.message,
        4,
      );
    } else {
      showError(
        checkToken.message,
        3,
      );
    }
  }

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckToken(String? path, dynamic data, int? id) async {
    checkResponse =
        await service.sendImage(path, data, UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      showSuccess(
        service.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        service.message,
        3,
      );
    }
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

  void showSuccess(String info, int sec) {
    EasyLoading.showSuccess(
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
}
