import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_my_order_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/delete_products_from_my_order_serves.dart';

class DeleteProductsFromMyOrderController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  DeleteProductsFromMyOrderServes service = DeleteProductsFromMyOrderServes();

  // Controller
  ShowMyOrderController controller = Get.put(ShowMyOrderController());
  // Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> deleteProductFromMyOrder(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.deleteProductFromMyOrder(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        //showAllProductsInMyOrder();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(id);
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
      deleteProductFromMyOrder(id);
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

  Future<void> deleteAllProductsFromMyOrder() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.deleteAllProductsFromMyOrder(UserInformation.myToken);
      if (checkResponse == CasesFromServer.can) {
        //showAllProductsInMyOrder();
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenWhenDeleteAllProducts();
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
      deleteAllProductsFromMyOrder();
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

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckToken(int id) async {
    checkResponse =
        await service.deleteProductFromMyOrder(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      showAllProductsInMyOrder();
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckTokenWhenDeleteAllProducts() async {
    checkResponse =
        await service.deleteAllProductsFromMyOrder(UserInformation.myToken);
    if (checkResponse == CasesFromServer.can) {
      showAllProductsInMyOrder();
    } else {
      showError(
        service.message,
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

  // Go To My Order Screen With All Remaining Products
  void showAllProductsInMyOrder() {
    controller.getMyOrder();
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
