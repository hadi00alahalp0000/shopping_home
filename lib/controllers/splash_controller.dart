// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/secure_storage.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';

class SplashController extends GetxController {
  // Serves
  late CheckValidTokenServes checkToken = CheckValidTokenServes();
  // Models
  late SecureStorage stored_token = SecureStorage();

  // Controller
  ShowProductsController controller = Get.put(ShowProductsController());

  // Values
  late String check;
  static var userOrGuest;

  @override
  void onInit() {
    check = 'cant';
    super.onInit();
  }

  Future<void> goingToHome() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    String? token = await stored_token.read('token');
    UserInformation.myToken = token;

    check = await checkToken.checkValidToken(UserInformation.myToken);

    if (check == CasesFromServer.can) {
      // Going To Home Like User
      userOrGuest = 'user';
      letsGo();
    } else if (check == CasesFromServer.maybe) {
      //Try To Know If The Persone Who Click is User Or Guest
      goingToHome();
    } else if (check == CasesFromServer.noInternet) {
      showError(
        checkToken.message,
        CasesFromServer.second,
      );
    } else {
      //Going Home Like Guest
      userOrGuest = 'guest';
      letsGo();
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

  void letsGo() async {
    controller.getProducts(
      ConstServer.showAllProducts,
      'nothing',
      0,
    );
  }
}
