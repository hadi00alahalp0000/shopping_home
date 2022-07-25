// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new, unnecessary_type_check, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_home/controllers/send_image_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user.dart';
import 'package:shopping_home/models/user_information.dart';
import '../const_server.dart';

class SignUpServes {
  //Values
  var message = '';
  var otbMessage = '';
  static var picked;
  String? token = '';
  late Map<String, dynamic> errorMap;
  //Url
  var url = ConstServer.domaiNname + ConstServer.register;
  //Controller
  SendImageController controller = Get.put(SendImageController());

  Future<bool> signUp(User user, var otb) async {
    final userBirthdate = DateFormat('yyyy/MM/dd').format(user.birthdate);
    var response = await Dio().post(
      url,
      options: Options(headers: {}),
      data: {
        'firstname': user.firstname,
        'lastname': user.lastname,
        'email': user.email,
        'password': user.password,
        'birthdate': userBirthdate.toString(),
        'governorate': user.governorate,
        'region': user.region,
        'street': user.street,
        'contact_email': user.contact_email,
        'phone_number': user.phone_number,
        'facebook_url': user.facebook_url,
        'telegram_url': user.telegram_url,
        'whatsapp': user.whatsapp,
        'skype': user.skype,
        'otb': otb
      },
    );
    if (response.statusCode == 200) {
      //var jsonResponse = jsonDecode(response.data);
      message = CasesFromServer.welcomeWithUs;
      // Get Token From Server
      token = response.data['data']['token'];
      UserInformation.myToken = token;
      // Get User Id From Server
      dynamic sendMyImage = response.data['data'];
      var id = sendMyImage['user'];
      var id2 = id[0]['id'];

      // Waiting Image To Be Saving In The Server
      await controller.addImage(ConstServer.userImage, id2);
      return true;
    }
    // Wrong OTB
    else if (response.statusCode == 424) {
      //var jsonResponse = jsonDecode(response.data);
      message = response.data['message'];
      return false;
    } else if (response.statusCode! > 200 && response.statusCode! < 500) {
      //var jsonResponse = jsonDecode(response.data);
      errorMap = response.data['error'];
      // convert the Map from back to List<dynamic>
      convertMapToList() => errorMap.entries.map((e) => e.value).toList();
      // convert the list<dynamic> here to text and save it in message
      if (convertMapToList() is List) {
        String text = '';
        for (List<dynamic> l in convertMapToList()) {
          if (l is List) {
            for (dynamic s in l) {
              if (s is String) {
                // convert the list that have string to string
                text += s + '\n';
              } else {
                // convert the list that have dynamic value like int or double ....etc to string
                text += '$s' + '\n';
              }
            }
          }
        }
        if (text == '') {
          message = CasesFromServer.errorFromServer;
        } else {
          message = text;
        }
      }
      return false;
    } else {
      message = CasesFromServer.noInternet;
      return false;
    }
    // } catch (e) {
    //   message = CasesFromServer.noInternet;
    //   return false;
    // }
  }

  Future<bool> otb(String email) async {
    // try {
    var response = await Dio().post(
      ConstServer.domaiNname + ConstServer.sendOtb,
      options: Options(
        headers: {},
      ),
      data: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      //var jsonResponse = jsonDecode(response.data);
      otbMessage = response.data['msg'];
      return true;
    } else if (response.statusCode! > 200 && response.statusCode! < 500) {
      //var jsonResponse = jsonDecode(response.data);
      otbMessage = response.data['msg'];
      return false;
    } else {
      otbMessage = CasesFromServer.noInternet;
      return false;
    }
    // } catch (e) {
    //   otbMessage = CasesFromServer.noInternet;
    //   return false;
    // }
  }
}
