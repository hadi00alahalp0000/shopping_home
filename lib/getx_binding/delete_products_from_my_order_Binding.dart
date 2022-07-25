// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:shopping_home/controllers/delete_products_from_my_order_controller.dart';

class DeleteProductsFromMyOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DeleteProductsFromMyOrderController>(
        DeleteProductsFromMyOrderController());
  }
}
