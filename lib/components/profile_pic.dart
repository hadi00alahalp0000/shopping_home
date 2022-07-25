// ignore_for_file: prefer_typing_uninitialized_variables, type_check_with_null, prefer_void_to_null, unnecessary_null_comparison

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_home/components/product_pic.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';

class ProfileImage extends StatefulWidget {
  final bool st;
  final int id;
  final String imgUrl;
  const ProfileImage({
    Key? key,
    required this.st,
    required this.id,
    required this.imgUrl,
  }) : super(key: key);
  @override
  State<ProfileImage> createState() => ProfilePic();
}

class ProfilePic extends State<ProfileImage> {
  //AddImageController addimgcontroller = Get.put(AddImageController());
  SendImageController controller = Get.put(SendImageController());
  var imageFile;
  Widget _imageSection(BuildContext context) {
    // User Make A New Account Now Or Old User Dont Have An Image Yet
    if (imageFile == null && widget.imgUrl == '') {
      return Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  Image.asset('assets/images/shopping_home_logo.png')
                      .image //change it to user.profileimage
              ),
        ],
      );
    } else if (widget.imgUrl == '') {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(55)),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
              height: 120,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      );
    } else {
      // Show User Image Using Image.network Function
      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(55)),
            // I Used The ConstServer.domainName Here To Make The imgUrl Give me The Image
            child: '${ConstServer.domaiNname}/${widget.imgUrl}' ==
                    '${ConstServer.domaiNname}/null'
                ? Image.asset('assets/images/shopping_home_logo.png')
                : Image.network('${ConstServer.domaiNname}/${widget.imgUrl}'),
          ),
        ],
      );
    }
    // if (imageFile == null && addimgcontroller.state == '') {
    //   return Stack(
    //     fit: StackFit.expand,
    //     clipBehavior: Clip.none,
    //     children: const [
    //       CircleAvatar(
    //         backgroundColor: Colors.white,
    //         backgroundImage: AssetImage(
    //           "assets/images/profile.jpg",
    //         ), //change it to user.profileimage
    //       ),
    //     ],
    //   );
    // } else if (addimgcontroller.state == '') {
    //   return Stack(
    //     children: [
    //       ClipRRect(
    //         borderRadius: const BorderRadius.all(Radius.circular(55)),
    //         child: Image.file(
    //           imageFile,
    //           fit: BoxFit.cover,
    //           height: 120,
    //           width: MediaQuery.of(context).size.width,
    //         ),
    //       ),
    //     ],
    //   );
    // } else {
    //   return Stack(children: [
    //     Container(
    //       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(55),
    //         image: DecorationImage(
    //           fit: BoxFit.fill,
    //           image: addimgcontroller.image.image,
    //         ),
    //       ),
    //     ),
    //   ]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _imageSection(context),
          widget.st
              ? Positioned(
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
                          maxHeight: 600, // <- reduce the image size
                          maxWidth: 600,
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
                            if (widget.id > 0) {
                              // Thats Mean The User Edit His Profile Image And Not New User
                              // Store The Data Inside The SendImageController
                              SendImageController.data = data;
                              // Go And Add This Image For This User
                              controller.addImage(
                                ConstServer.userImage,
                                widget.id,
                              );
                            } else {
                              // Store The Data Inside The SendImageController
                              // And Wait That User Until He SignUp In The App
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
              : Container(),
        ],
      ),
    );
  }
}
