import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/serves/profile_serves.dart';

import '../models/cases_from_server.dart';
import '../screens/profile_details/profile_details_screen.dart';

class UserController extends GetxController {
  //late MyProfile account;
  static dynamic account;
  //late List<MyProfile> users;
  static dynamic users;
  late String check;
  late bool checkResponse;
  late UserService service;

  @override
  void onInit() {
    check = 'cant';
    checkResponse = false;
    service = UserService();
    super.onInit();
  }

  // Get One User From The Server
  Future<void> getUserAccount(String path, int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveUserAccount(path, id);
    if (checkResponse) {
      goToUserProfile();
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Get All Users From The Server
  Future<void> getAllUsersAccounts(String path, int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveAllUsersAccounts(path, id);
    if (checkResponse) {
      letsGo(path);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Function to Show Success Comming From CasesFromServer
  void showSuccess(String info, int sec) {
    EasyLoading.showSuccess(
      info.tr,
      duration: Duration(
        seconds: sec,
      ),
    );
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

  //Waiting New Widget For This Function
  void goToUserProfile() async {
    account = service.account;
    Get.toNamed(
      'Profile_details',
      arguments: ProfileDetailsArguments(
        account: account,
      ),
    );
    showSuccess(
      CasesFromServer.done,
      CasesFromServer.second,
    );
  }

  void letsGo(String path) async {
    if (path == ConstServer.showAllUsersLikedProduct) {
      goToShowAllUsersLikedProduct();
    } else if (path == ConstServer.showAllUsersSawProduct) {
      goToShowAllUsersSawProduct();
    } else if (path == ConstServer.showAllUsersReviewedProduct) {
      goToShowAllUsersReviewedProduct();
    }
    //Impossible
    else {
      showError(
        'Impossible',
        CasesFromServer.second,
      );
    }
  }

  // Function Go To Widget Show To You All Users Had Liked Product You Have Its Id
  //Not Finshed Yet
  void goToShowAllUsersLikedProduct() {
    users = service.users;
    Get.offAllNamed('');
    showSuccess(
      CasesFromServer.done,
      CasesFromServer.second,
    );
  }

  // Function Go To Widget Show To You All Users Had Saw Product You Have Its Id
  //Not Finshed Yet
  void goToShowAllUsersSawProduct() {
    users = service.users;
    Get.offAllNamed('');
    showSuccess(
      CasesFromServer.done,
      CasesFromServer.second,
    );
  }

  // Function Go To Widget Show To You All Users Had Reviewed Product You Have Its Id
  //Not Finshed Yet
  void goToShowAllUsersReviewedProduct() {
    users = service.users;
    Get.offAllNamed('');
    showSuccess(
      CasesFromServer.done,
      CasesFromServer.second,
    );
  }
}
