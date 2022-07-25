// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/profile_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/edit_profile_service.dart';

class EditProfileController extends GetxController {
  //Serves
  EditProfileServes service = EditProfileServes();
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  //Controller
  ProfileController controller = Get.put(ProfileController());

  //values
  late var message;
  late String check;
  late String checkResponse;

  static var id;
  static var firstname;
  static var lastname;
  static var password;
  static var birthdate;
  static var governorate;
  static var region;
  static var street;
  static var contact_email;
  static var phone_number;
  static var facebook_url;
  static var telegram_url;
  static var whatsapp;
  static var skype;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> editProfile() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    // Models
    EditPerson account = EditPerson(
      id: id,
      firstname: firstname,
      lastname: lastname,
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
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.editProfile(UserInformation.myToken, account);
      if (checkResponse == CasesFromServer.can) {
        controller.getaccount();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(account);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSingIn(
          '/SignIn',
          service.message,
          5,
        );
      } else {
        EasyLoading.showError(
          service.message,
          duration: const Duration(
            seconds: 5,
          ),
        );
      }
    } else if (check == CasesFromServer.maybe) {
      editProfile();
    } else if (check == CasesFromServer.trySignInAgain) {
      goToSingIn(
        '/SignIn',
        checkToken.message,
        5,
      );
    } else {
      showError(
        checkToken.message,
        3,
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
  void tokenExpiredAfterCheckToken(EditPerson account) async {
    checkResponse = await service.editProfile(UserInformation.myToken, account);
    message = service.message;
    if (checkResponse == 'can') {
      controller.getaccount();
    } else {
      EasyLoading.showError(
        message,
        duration: const Duration(
          seconds: 5,
        ),
      );
    }
  }

  void goToSingIn(String route, String info, int sec) {
    Get.offAllNamed(route);
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }
}
