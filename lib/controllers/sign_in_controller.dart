// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/serves/sign_in_serves.dart';

class SignInController extends GetxController {
  @override
  void onInit() {
    email = '';
    password = '';
    remember = false.obs;
    message = '';
    token = '';
    signIn = false;
    service = SignInServes();

    super.onInit();
  }

  var password;
  var email;
  var remember;
  var signIn;
  var token;
  var message;
  var name;

  late SignInServes service;

  Future<void> signinonclick() async {
    User user = User(
        password: password,
        email: email,
        firstname: '',
        lastname: '',
        birthdate: '',
        governorate: '',
        region: '',
        street: '',
        phone_number: '');
    signIn = await service.signin(user, remember.value);

    message = service.message;

    if (message is List) {
      String text = '';
      for (String s in message) {
        // transform the list to rows of string
        text += s + '\n';
      }
      message = text;
    }
  }
}
