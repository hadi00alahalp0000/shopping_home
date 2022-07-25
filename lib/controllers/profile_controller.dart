// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/get_image_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/screens/edit_profile/edit_profile_screen.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/profile_serves.dart';

class ProfileController extends GetxController {
  static dynamic account;
  late String check;
  late String checkResponse;
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  GetImageController controller = Get.put(GetImageController());
  UserService service = UserService();

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    service = UserService();
    super.onInit();
  }

  Future<void> getaccount() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveMyAccount(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        goToProfile();
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
      getaccount();
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

  // if we have token expired after the check vaildate thoke give us can case
  void tokenExpiredAfterCheckToken() async {
    checkResponse = await service.reciveMyAccount(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      goToProfile();
    } else {
      EasyLoading.showError(service.message);
    }
  }

  void goToProfile() async {
    account = service.account;
    Get.toNamed(
      '/edit_profile',
      arguments: ProfileArguments(
        account: account,
      ),
    );
    EasyLoading.showSuccess(
      CasesFromServer.done.tr,
      duration: Duration(
        seconds: CasesFromServer.second,
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
