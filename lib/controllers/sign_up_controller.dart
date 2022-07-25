// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/serves/sign_up_serves.dart';

import '../models/cases_from_server.dart';

class SignUpController extends GetxController {
  static var firstname = '';
  static var lastname = '';
  static var email = '';
  static var password = '';
  static var passwordConformation = '';
  static DateTime? birthdate;
  static var governorate = '';
  static var region = '';
  static var street = '';
  static var contact_email = '';
  static var phone_number = '';
  static var facebook_url = '';
  static var telegram_url = '';
  static var whatsapp = '';
  static var skype = '';
  static String otb = '';

  static var message;
  static var otbstatus = false;
  var registerStatus = false;

  SignUpServes service = SignUpServes();

  Future<void> checkotb() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    otbstatus = await service.otb(email);
    if (otbstatus) {
      goToOtb(
        service.otbMessage,
        CasesFromServer.second,
      );
    } else {
      showError(
        service.otbMessage,
        CasesFromServer.second,
      );
    }
  }

  Future<void> signUp() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    User user = User(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
      birthdate: birthdate,
      governorate: governorate,
      region: region,
      street: street,
      contact_email: contact_email,
      phone_number: phone_number,
      facebook_url: facebook_url,
      telegram_url: telegram_url,
      whatsapp: whatsapp,
      skype: skype,
    );
    registerStatus = await service.signUp(user, otb);
    if (registerStatus) {
      goToHome(
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

  void goToHome(String info, int sec) async {
    Get.offAllNamed('/Home');
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
      duration: Duration(seconds: sec),
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
