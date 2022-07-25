import 'package:get/get.dart';
import 'package:shopping_home/controllers/view_controller.dart';

class ViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ViewController>(ViewController());
  }
}
