// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/edit_product_in_my_order_serves.dart';

class EditProductInMyOrderController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  EditProductInMyOrderServes service = EditProductInMyOrderServes();

  // Values
  late String check;
  late String checkResponse;
  static var quantities;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> editProductInMyOrder(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.editProductInMyOrder(
        UserInformation.myToken,
        quantities,
        id,
      );
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(
          quantities,
          id,
        );
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
      editProductInMyOrder(id);
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
  void tokenExpiredAfterCheckToken(int quantities, int id) async {
    checkResponse = await service.editProductInMyOrder(
      UserInformation.myToken,
      quantities,
      id,
    );
    if (checkResponse == CasesFromServer.can) {
      worked(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Show That We Can Add Order
  void worked(String info) {
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
