// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/view_serves.dart';

import '../serves/like_serves.dart';

class ViewController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  ViewServes service = ViewServes();
  LikeServes likeServes = LikeServes();

  late String check;
  late String checkResponse;
  static var isMine;
  static var isFavourite;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> addView(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.addview(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        makeView(id);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(id);
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      addView(id);
    } else {
      showError(
        checkToken.message,
        CasesFromServer.second,
      );
    }
  }

  // Check If The Product Is Liked
  Future<void> checkLike(int id) async {
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      isFavourite = await likeServes.checkLike(UserInformation.myToken, id);
    } else if (check == CasesFromServer.maybe) {
      checkLike(id);
    } else {
      isFavourite = false;
    }
  }

  // Function to Show Errors Comming From Server
  void showError(String info, int sec) {
    isMine = false;
    EasyLoading.showError(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  // If We Have Token Expired After The addedProduct Give Us maybe Case
  void tokenExpiredAfterCheckToken(int id) async {
    checkResponse = await service.addview(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      makeView(id);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Show That We Can Add View
  void makeView(int id) {
    isMine = service.isMine;
    checkLike(id);
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
