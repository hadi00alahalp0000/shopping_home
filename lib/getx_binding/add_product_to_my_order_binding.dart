import 'package:get/get.dart';
import 'package:shopping_home/controllers/add_product_to_my_order_controller.dart';

class AddProductToMyOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddProductToMyOrderController>(AddProductToMyOrderController());
  }
}
