// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/serves/forget_password_serves.dart';

class ForgetPasswordController extends GetxController {
  // Serves
  ForgetPasswordServes service = ForgetPasswordServes();

  // Values
  static var email;
  static var password;
  static var passwordconformation;
  static var forgetPasswordOtb;
  late var getOtb;
  late var checkResponse;

  @override
  void onInit() {
    getOtb = false;
    checkResponse = false;
    super.onInit();
  }

  Future<void> checkForgetPasswordOtb() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    getOtb = await service.forgetPasswordOtb(email);
    if (getOtb) {
      goToOtb(
        service.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        service.otbMessage,
        CasesFromServer.second,
      );
    }
  }

  Future<void> signUpWithNewPassword() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    User user = User(
      firstname: 'firstname',
      lastname: 'lastname',
      email: email,
      password: password,
      birthdate: 'birthdate',
      governorate: 'governorate',
      region: 'region',
      street: 'street',
      contact_email: 'contact_email',
      phone_number: 'phone_number',
      facebook_url: 'facebook_url',
      telegram_url: 'telegram_url',
      whatsapp: 'whatsapp',
      skype: 'skype',
    );

    checkResponse = await service.forgetPassword(user, forgetPasswordOtb);
    if (checkResponse) {
      goToSignIn(
        CasesFromServer.welcome,
        CasesFromServer.second,
      );
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  void goToSignIn(String info, int sec) async {
    Get.offAllNamed('/SignIn');
    EasyLoading.showSuccess(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  void goToOtb(String info, int sec) {
    // go to otb sceen
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
}
