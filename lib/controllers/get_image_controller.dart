// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/serves/image_serves.dart';

class GetImageController extends GetxController {
  //Serves
  late ImageServes service = ImageServes();
  //Another Controller For Help

  //Values
  dynamic image;
  bool getImage = false;
  bool checkImage = false;

  Future<void> reciveImage(String? path, int id) async {
    checkImage = await service.checkImage(id);
    if (checkImage) {
      getImage = await service.getImage(path, id);
      if (getImage) {
        image = service.image;
      } else {
        showError(
          service.message,
          path,
          3,
        );
      }
    } else {
      showError(
        service.message,
        path,
        3,
      );
    }
  }

  // Function to Show Errors Comming From Server
  void showError(String info, String? path, int sec) {
    if (path == ConstServer.userImage) {
      image = Image.asset("assets/images/profile.png");
    }
    EasyLoading.showError(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }
}
