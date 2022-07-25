import 'package:get/get.dart';
import 'package:shopping_home/controllers/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CategoryController>(CategoryController());
  }
}
