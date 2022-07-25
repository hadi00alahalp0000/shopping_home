import 'package:get/get.dart';
import 'package:shopping_home/controllers/delete_product_controller.dart';

class DeleteProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DeleteProductController>(DeleteProductController());
  }
}
