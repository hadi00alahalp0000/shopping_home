// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, type_check_with_null, prefer_void_to_null

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/product.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/add_product_serves.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';

class AddProductController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  AddProductServes service = AddProductServes();
  //Controller
  ShowProductsController products = Get.put(ShowProductsController());
  // Value
  static var name;
  static var quantity;
  static var price;
  static var description;
  static var category;
  static var contactEmail;
  static var phoneNumber;
  static var facebookUrl;
  static var telegramUrl;
  static var whatsapp;
  static var skype;
  static var twitter;
  dynamic data;

  late String check;
  late String checkResponse;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> addProduct() async {
    if (SendImageController.data is Null) {
      showError(
        CasesFromServer.productWithoutImage,
        CasesFromServer.second,
      );
    } else {
      EasyLoading.show(status: CasesFromServer.loading.tr);
      Product product = Product(
        name: name,
        quantity: quantity,
        price: price,
        description: description,
        category: category,
        contact_email: contactEmail,
        phone_number: phoneNumber,
        facebook_url: facebookUrl,
        telegram_url: telegramUrl,
        whatsapp: whatsapp,
        skype: skype,
        twitter: twitter,
      );
      check = await checkToken.checkValidToken(UserInformation.myToken);
      if (check == CasesFromServer.can) {
        checkResponse =
            await service.addProduct(UserInformation.myToken, product);
        if (checkResponse == CasesFromServer.can) {
          goToMyProducts();
        } else if (checkResponse == CasesFromServer.maybe) {
          tokenExpiredAfterCheckToken(product);
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
        addProduct();
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
  void tokenExpiredAfterCheckToken(Product product) async {
    checkResponse = await service.addProduct(UserInformation.myToken, product);
    if (checkResponse == CasesFromServer.can) {
      goToMyProducts();
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Go To My Product Screen With Message From Service
  // Not Finshed Want The Screen Route Name
  void goToMyProducts() {
    products.getProducts(
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
