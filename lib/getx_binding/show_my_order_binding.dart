import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_my_order_controller.dart';

class ShowMyOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShowMyOrderController>(ShowMyOrderController());
  }
}
