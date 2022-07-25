import 'package:get/get.dart';
import 'package:shopping_home/controllers/pay_record_details_controller.dart';

class PayRecordDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PayRecordDetailsController>(PayRecordDetailsController());
  }
}
