// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, type_check_with_null, prefer_void_to_null

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/product.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/edit_product_serves.dart';

class EditProductController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  EditProductServes service = EditProductServes();

  // Value
  static var id;
  static var name;
  static var quantity;
  static var price;
  static var description;
  static var category;
  static var contact_email;
  static var phone_number;
  static var facebook_url;
  static var telegram_url;
  static var whatsapp;
  static var skype;
  static var twitter;

  late String check;
  late String checkResponse;
  var message;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> editProduct(int id) async {
    if (SendImageController.data is Null) {
      showError(
        CasesFromServer.productWithoutImage,
        CasesFromServer.second,
      );
    } else {
      EasyLoading.show(status: CasesFromServer.loading.tr);
      Product product = Product(
        id: id,
        name: name,
        quantity: quantity,
        price: price.toDouble(),
        description: description,
        category: category,
        contact_email: contact_email,
        phone_number: phone_number,
        facebook_url: facebook_url,
        telegram_url: telegram_url,
        whatsapp: whatsapp,
        skype: skype,
        twitter: twitter,
      );
      check = await checkToken.checkValidToken(UserInformation.myToken);
      if (check == CasesFromServer.can) {
        checkResponse =
            await service.editProduct(UserInformation.myToken, product, id);
        if (checkResponse == CasesFromServer.can) {
          goToMyProducts(service.message);
        } else if (checkResponse == CasesFromServer.maybe) {
          tokenExpiredAfterCheckToken(product, id);
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
        editProduct(id);
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
  void tokenExpiredAfterCheckToken(Product product, int id) async {
    checkResponse =
        await service.editProduct(UserInformation.myToken, product, id);
    if (checkResponse == CasesFromServer.can) {
      goToMyProducts(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Go To My Product Screen With Message From Service
  // Not Finshed Want The Screen Route Name
  // Maybe I Want Stay In That product
  void goToMyProducts(String info) {
    EasyLoading.showInfo(info);
    message = 'true';
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
