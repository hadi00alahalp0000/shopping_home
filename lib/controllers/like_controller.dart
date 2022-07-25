// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/like_serves.dart';

class LikeController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  LikeServes service = LikeServes();

  // Value
  var message;
  static var isLike;
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  // Add Like To Product By Id That Product
  Future<void> addLike(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.addLike(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(id);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          CasesFromServer.second,
        );
      } else if (checkResponse == CasesFromServer.cantAddLikeAgain) {
        deleteLike(id);
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      addLike(id);
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

  // Delete Like For Product By Id That Product
  Future<void> deleteLike(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.deleteLike(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenForDelete(id);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      deleteLike(id);
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

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckToken(int id) async {
    checkResponse = await service.addLike(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      worked(service.message);
    } else if (checkResponse == CasesFromServer.cantAddLikeAgain) {
      deleteLike(id);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckTokenForDelete(int id) async {
    checkResponse = await service.deleteLike(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      worked(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Show That We Can Add Or Delete Like
  void worked(String info) {
    message = info;
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To SignIn Screen Cause Token Invaild Or Not Found
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
