// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/show_products_serves.dart';

import '../models/user_information.dart';

class ShowProductsController extends GetxController {
  //Sreves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  ShowProductsServes service = ShowProductsServes();
  //Values
  late String check;
  late String checkResponse;
  //late List<ShowProducts> products;
  static dynamic allProducts;
  static dynamic myProducts;
  static dynamic productsByCategoryId;
  static dynamic productsByUserId;
  static dynamic sortedProducts;
  static dynamic productsYouLike;
  static dynamic productsYouView;
  static dynamic productsYouReview;
  static var message;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = 'cant';
    super.onInit();
  }

  Future<void> getProducts(String path, String? sortType, int? id) async {
    if (path == ConstServer.showAllMyProducts ||
        path == ConstServer.showAllProductsHaveMyLike ||
        path == ConstServer.showAllProductsHaveMyView ||
        path == ConstServer.showAllProductsHaveMyReview) {
      getWhatINeed(path);
    } else {
      getAnotherProducts(path, sortType, id);
    }
  }

  //Get My Products Or Product (Like,View,Review) it From Server
  void getWhatINeed(String path) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.reciveWhatINeed(
        UserInformation.myToken,
        path,
      );
      if (checkResponse == CasesFromServer.can) {
        letsGo(path);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(path);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          CasesFromServer.trySignInAgain,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      getWhatINeed(path);
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

  // Get All Products Or Products By User Id Or Products By Categorys Id Or Sorted Products
  void getAnotherProducts(String path, String? sortType, int? id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveProducts(path, sortType, id);
    if (checkResponse == CasesFromServer.can) {
      letsGo(path);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Function To Show Errors Comming From Service
  void showError(String info, int sec) {
    EasyLoading.showError(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  // Choice Where Would You Go
  void letsGo(String path) {
    if (path == ConstServer.showAllMyProducts) {
      gotToMyProducts(
        service.message,
      );
    } else if (path == ConstServer.showAllProductsHaveMyLike) {
      goToProductsYouLike(
        service.message,
      );
    } else if (path == ConstServer.showAllProductsHaveMyView) {
      goToProductsYouView(
        service.message,
      );
    } else if (path == ConstServer.showAllProductsHaveMyReview) {
      goToProductsYouReview(
        service.message,
      );
    } else if (path == ConstServer.showAllProducts) {
      goToHome(
        service.message,
      );
    } else if (path == ConstServer.showAllProductsByCategoryId) {
      goToCategoryProducts(
        service.message,
      );
    } else if (path == ConstServer.showAllProductsByUser) {
      gotToUserProducts(
        service.message,
      );
    } else if (path == ConstServer.showAllSortedProducts) {
      gotToSortedProducts(
        service.message,
      );
    } else {
      // Impossible
      showError(
        CasesFromServer.dontHaveProducts,
        CasesFromServer.second,
      );
    }
  }

  // If We Have Token Expired After The check Give Us can Case And checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckToken(String path) async {
    checkResponse =
        await service.reciveWhatINeed(UserInformation.myToken, path);
    if (checkResponse == CasesFromServer.can) {
      letsGo(path);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Go To User Product Screen With Message From The Service
  // Want the Route Name To Be Finished:
  void gotToUserProducts(String info) {
    productsByUserId = service.products;
    message = info;
    Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Product Screen You Like It With Message From The Service
  // Want the Route Name To Be Finished:
  void goToProductsYouLike(String info) {
    productsYouLike = service.products;
    message = info;
    Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Product Screen You View It With Message From The Service
  // Want the Route Name To Be Finished:
  void goToProductsYouView(String info) {
    productsYouView = service.products;
    message = info;
    Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Product Screen You Review It With Message From The Service
  // Want the Route Name To Be Finished:
  void goToProductsYouReview(String info) {
    productsYouReview = service.products;
    message = info;
    Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  void gotToSortedProducts(String info) {
    sortedProducts = service.products;
    message = info;
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // go to my product screen with message from the service
  // Want the Route Name To Be Finished:
  void gotToMyProducts(String info) {
    myProducts = service.products;
    message = info;
    Get.offAllNamed('/My_Products');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Home Screen With Message From The Service
  void goToHome(String info) {
    allProducts = service.products;
    message = info;
    Get.offAllNamed('/Home');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Category Products Screen With Message From The Service
  // Want the Route Name To Be Finished:
  void goToCategoryProducts(String info) {
    productsByCategoryId = service.products;
    Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To SignIn Screen Caues Token Invaild Or Not Found
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
