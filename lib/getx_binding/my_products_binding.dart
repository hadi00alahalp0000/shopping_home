import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';

class MyProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShowProductsController>(ShowProductsController());
  }
}
