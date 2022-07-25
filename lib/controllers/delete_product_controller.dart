import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/delete_product_serves.dart';

class DeleteProductController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  DeleteProductServes service = DeleteProductServes();

  // Controller
  ShowProductsController controller = Get.put(ShowProductsController());
  // Values
  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> deleteMyProduct(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.deleteProduct(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        deleteDone();
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
      deleteMyProduct(id);
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
    checkResponse = await service.deleteProduct(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      deleteDone();
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

  void deleteDone() {
    controller.getProducts(
      ConstServer.showAllMyProducts,
      'nothing',
      0,
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
