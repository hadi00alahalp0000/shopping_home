// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/review.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/serves/check_valida_token_serves.dart';
import 'package:shopping_home/serves/review_serves.dart';

class ReviewController extends GetxController {
  // Serves
  CheckValidTokenServes checkToken = CheckValidTokenServes();
  ReviewServes service = ReviewServes();
  // Value
  static var review;
  static var numStar;
  late String check;
  late String checkResponse;
  static dynamic reviews;

  // Add Review To Product By Id That Product
  Future<void> addReview(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    // Models
    Review model = Review(
      review: review,
      numStar: numStar,
    );
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse =
          await service.addReview(UserInformation.myToken, model, id);
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckToken(model, id);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      addReview(id);
    } else if (check == CasesFromServer.trySignInAgain) {
      goToSignIn(
        '/SignIn',
        checkToken.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        checkToken.message,
        CasesFromServer.second,
      );
    }
  }

  // Delete Review For Product By Id That Product
  Future<void> deleteReview(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    check = await checkToken.checkValidToken(UserInformation.myToken);
    if (check == CasesFromServer.can) {
      checkResponse = await service.deleteReview(UserInformation.myToken, id);
      if (checkResponse == CasesFromServer.can) {
        worked(service.message);
      } else if (checkResponse == CasesFromServer.maybe) {
        tokenExpiredAfterCheckTokenForDelete(id);
      } else if (checkResponse == CasesFromServer.trySignInAgain) {
        goToSignIn(
          '/SignIn',
          service.message,
          CasesFromServer.second,
        );
      } else {
        showError(
          service.message,
          CasesFromServer.second,
        );
      }
    } else if (check == CasesFromServer.maybe) {
      deleteReview(id);
    } else if (check == CasesFromServer.trySignInAgain) {
      goToSignIn(
        '/SignIn',
        checkToken.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        checkToken.message,
        CasesFromServer.second,
      );
    }
  }

  Future<void> getAllReviewsByProductId(int id) async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    checkResponse = await service.reciveAllReview(id);
    if (checkResponse == CasesFromServer.can) {
      goToReviewScreen(
        service.message,
        CasesFromServer.second,
      );
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Function to Show Errors Comming From Server
  void showError(String info, int sec) {
    EasyLoading.showError(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckToken(Review model, int id) async {
    checkResponse = await service.addReview(UserInformation.myToken, model, id);
    if (checkResponse == CasesFromServer.can) {
      worked(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // If We Have Token Expired After The checkResponse Give Us maybe Case
  void tokenExpiredAfterCheckTokenForDelete(int id) async {
    checkResponse = await service.deleteReview(UserInformation.myToken, id);
    if (checkResponse == CasesFromServer.can) {
      worked(service.message);
    } else {
      showError(
        service.message,
        CasesFromServer.second,
      );
    }
  }

  // Show That We Can Add Or Delete Review
  void worked(String info) {
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: CasesFromServer.second,
      ),
    );
  }

  // Go To Review Screen To See Reviews There
  // Want The Route Name To Be Finshed
  void goToReviewScreen(String info, int sec) {
    reviews = service.reviews;
    //Get.offAllNamed('');
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }

  // Go To SignIn Screen Cause Token Invaild Or Not Found
  void goToSignIn(String route, String info, int sec) {
    Get.offAllNamed(route);
    EasyLoading.showInfo(
      info,
      duration: Duration(
        seconds: sec,
      ),
    );
  }
}
