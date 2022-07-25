import 'package:get/get.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';

class ImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SendImageController>(SendImageController());
  }
}
