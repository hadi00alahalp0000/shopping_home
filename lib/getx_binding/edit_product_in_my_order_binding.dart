import 'package:get/get.dart';
import 'package:shopping_home/controllers/edit_product_in_my_order_controller.dart';

class EditProductInMyOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EditProductInMyOrderController>(EditProductInMyOrderController());
  }
}
