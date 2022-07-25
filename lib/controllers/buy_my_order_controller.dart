// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/delete_products_from_my_order_controller.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/buy_my_order_serves.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';

class BuyMyOrderController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  BuyMyOrderServes service = BuyMyOrderServes();

  //Controller
  ShowProductsController products = Get.put(ShowProductsController());
  DeleteProductsFromMyOrderController delete =
      Get.put(DeleteProductsFromMyOrderController());

  // Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> buyMyOrder() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.buyMyOrder(
        UserInformation.myToken,
      );
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken();
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
      buyMyOrder();
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
  void tokenExpiredAfterCheckToken() async {
    checkResponse = await service.buyMyOrder(
      UserInformation.myToken,
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
    // products.getProducts(
    //   ConstServer.showAllProducts,
    //   'nothing',
    //   0,
    // );
    //delete.deleteAllProductsFromMyOrder();
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
