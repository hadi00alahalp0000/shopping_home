// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';

final picker = ImagePicker();

class ProductPic extends StatefulWidget {
  final String imgUrl;
  final int id;
  const ProductPic({
    Key? key,
    required this.id,
    required this.imgUrl,
  }) : super(key: key);
  @override
  State<ProductPic> createState() => _ProductPic();
}

// class _ProductPic extends State<ProductPic> {
//   AddProductController con = Get.find();
//   var imageFile;
//   Widget _imageSection(BuildContext context) {
//     return (imageFile == null)
//         ? SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: 220,
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: const BorderSide(color: Colors.white),
//                 ),
//                 primary: Colors.white,
//                 backgroundColor: const Color(0xFFF5F6F9),
//               ),
//               onPressed: () {},
//               child: SvgPicture.asset("assets/images/product.png"),
//             ),
//           )
//         : ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Column(
//               children: [
//                 Image.file(
//                   imageFile,
//                   fit: BoxFit.cover,
//                   height: 120,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//               ],
//             ),
//           );
//   }
class _ProductPic extends State<ProductPic> {
  SendImageController controller = Get.put(SendImageController());
  var imageFile;
  Widget _imageSection(BuildContext context) {
    // If User Add New Product
    if (imageFile == null && widget.imgUrl == '') {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.white),
            ),
            primary: Colors.white,
            backgroundColor: const Color(0xFFF5F6F9),
          ),
          onPressed: () {},
          child: SvgPicture.asset("assets/images/product.png"),
        ),
      );
    }
    // User Put New Image For The New Product
    else if (widget.imgUrl == '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Image.file(
              imageFile,
              fit: BoxFit.cover,
              height: 120,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      );
    } else {
      // The Product Have Image
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Image.network(ConstServer.domaiNname + '/' + widget.imgUrl),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _imageSection(context),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  var pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50, // <- Reduce Image quality
                    maxHeight: 500, // <- reduce the image size
                    maxWidth: 500,
                  );

                  if (pickedFile != null) {
                    String fileName = pickedFile.path.split('/').last;

                    FormData data = FormData.fromMap({
                      "image": await MultipartFile.fromFile(
                        pickedFile.path,
                        filename: fileName,
                      ),
                    });
                    if (data != null) {
                      // This Product I Can Edit Its Image Now Without Waiting Add It To Server
                      if (widget.id > 0) {
                        SendImageController.data = data;
                        controller.addImage(
                            ConstServer.productImage, widget.id);
                      } else {
                        // Just Save The Data Until We Add That Product To Server
                        SendImageController.data = data;
                      }
                    }
                  }

                  if (pickedFile != null) {
                    setState(() {
                      imageFile = File(pickedFile.path);
                    });
                  }
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
