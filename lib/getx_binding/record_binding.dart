import 'package:get/get.dart';
import 'package:shopping_home/controllers/record_controller.dart';

class RecordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RecordController>(RecordController());
  }
}
