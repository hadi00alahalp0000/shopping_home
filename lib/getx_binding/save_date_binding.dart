import 'package:get/get.dart';
import 'package:shopping_home/controllers/save_date_controller.dart';

class SaveDateBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SaveDateController>(SaveDateController());
  }
}
