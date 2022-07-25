import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/serves/category_serves.dart';

class CategoryController extends GetxController {
  //serves
  CategoryServes service = CategoryServes();
  //values
  late bool checkResponse;
  static dynamic categories;
  static dynamic category;

  @override
  void onInit() {
    checkResponse = false;
    super.onInit();
  }

  Future<void> getCategories() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveCategories();
    if (checkResponse) {
      goToCategories(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  Future<void> getCategoryByProductId(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveCategoryByProductId(id);
    if (checkResponse) {
      goToCategories('Just One Category For This Product');
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

  // go to my product screen with message from the service
  // Want the Route Name To Be Finished:
  void goToCategories(String info) {
    if (info == 'Just One Category For This Product') {
      categories = [service.category];
      Get.toNamed('/Categories');
      EasyLoading.showInfo(
        CasesFromServer.categoryByProductId,
        duration: Duration(
          seconds: CasesFromServer.second,
        ),
      );
    } else {
      categories = service.categories;
      Get.toNamed('/Categories');
      EasyLoading.showInfo(
        info,
        duration: Duration(
          seconds: CasesFromServer.second,
        ),
      );
    }
  }
}
