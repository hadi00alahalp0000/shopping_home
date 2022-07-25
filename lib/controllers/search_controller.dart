// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/serves/search_service.dart';

import '../models/cases_from_server.dart';

class SearchController extends GetxController {
  late List<List<dynamic>> prods;
  static List<Image> images = [];
  static List<String> catename = [];
  static List<bool> islike = [];
  static int index = 0;
  late String value;

  late String searchby;
  dynamic searchvalue;
  dynamic isLoading;

  // Future<void> search() async {
  //    SearchService service=SearchService();

  //   print('hello');
  //   // AllProductController.prods=[];
  //   // AllProductController.images=[];
  //   // AllProductController.catename=[];
  //   // AllProductController.islike=[];
  //   //prods = await service.serachProduct();
  // }

  // Values
  static dynamic productsResult;
  static dynamic usersResult;
  static var values;
  static var searchType;
  late bool checkResponse;
  // Serves
  SearchService service = SearchService();

  @override
  void onInit() {
    checkResponse = false;
    super.onInit();
  }

  Future<void> search() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.serach(values, searchType);
    if (checkResponse) {
      goToSearchScreen(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  void goToSearchScreen(String? info) {
    productsResult = service.result;
    usersResult = service.users;
    // Get.toNamed('/Search');
    EasyLoading.showSuccess(
      info!,
      duration: Duration(
        seconds: CasesFromServer.second,
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
}
