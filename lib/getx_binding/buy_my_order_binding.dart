import 'package:get/get.dart';
import 'package:shopping_home/controllers/buy_my_order_controller.dart';

class BuyMyOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BuyMyOrderController>(BuyMyOrderController());
  }
}
