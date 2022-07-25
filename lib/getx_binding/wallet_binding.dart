import 'package:get/get.dart';

import '../controllers/wallet_controller.dart';

class WalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WalletController>(WalletController());
  }
}
