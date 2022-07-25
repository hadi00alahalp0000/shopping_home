import 'package:get/get.dart';
import 'package:shopping_home/controllers/add_product_controller.dart';

class AddProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddProductController>(AddProductController());
  }
}
