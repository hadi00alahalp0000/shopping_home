import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shopping_home/getx_binding/add_product_binding.dart';
import 'package:shopping_home/getx_binding/category_binding.dart';
import 'package:shopping_home/getx_binding/edit_product_binding.dart';
import 'package:shopping_home/getx_binding/forget_password_binding.dart';
import 'package:shopping_home/getx_binding/profile_binding.dart';
import 'package:shopping_home/getx_binding/record_binding.dart';
import 'package:shopping_home/getx_binding/review_binding.dart';
import 'package:shopping_home/getx_binding/search_binding.dart';
import 'package:shopping_home/getx_binding/show_my_order_binding.dart';
import 'package:shopping_home/getx_binding/show_products_binding.dart';
import 'package:shopping_home/getx_binding/sign_up_binding.dart';
import 'package:shopping_home/getx_binding/splah_binding.dart';
import 'package:shopping_home/getx_binding/user_binding.dart';
import 'package:shopping_home/getx_binding/wallet_binding.dart';
import 'package:shopping_home/models/user_information.dart';
import 'package:shopping_home/screens/Register/register_screen.dart';
import 'package:shopping_home/screens/add_product/add_product_screen.dart';
import 'package:shopping_home/screens/review/review_screen.dart';
import 'package:shopping_home/screens/complete_profile/complete_profile_screen.dart';
import 'package:shopping_home/screens/details/details_screen.dart';
import 'package:shopping_home/screens/edit_details/edit_details_screen.dart';
import 'package:shopping_home/screens/edit_profile/edit_profile_screen.dart';
import 'package:shopping_home/screens/forget_password/forget_password_screen.dart';
import 'package:shopping_home/screens/home/home_screen.dart';
import 'package:shopping_home/screens/otp/otp_screen.dart';
import 'package:shopping_home/screens/profile/profile_screen.dart';
import 'package:shopping_home/screens/search/search_screen.dart';
import 'package:shopping_home/screens/sign_in/sign_in_screen.dart';
import 'package:shopping_home/screens/signin_success/signin_success_screen.dart';
import 'package:shopping_home/screens/splash/splash_screen.dart';
import 'package:shopping_home/screens/wallet/wallet_screen.dart';
import 'package:shopping_home/theme.dart';

import 'getx_binding/edit_profile_binding.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/categories/categories_screen.dart';
import 'screens/categories/components/category.dart';
import 'screens/change_password/change_password_screen.dart';
import 'screens/my_products/my_products_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/profile_details/profile_details_screen.dart';
import 'screens/wallet/components/records_screen.dart';
import 'translate.dart';
import 'getx_binding/sign_in_binding.dart';
import 'models/secure_storage.dart';

Future<void> main() async {
  try {
    late SecureStorage storage = SecureStorage();
    String? languge = await storage.read('language');

    if (languge == 'true') {
      MyApp.lang = 'en';
    } else {
      MyApp.lang = 'ar';
    }
  } catch (e) {
    UserInformation.languge = 'true';
    MyApp.lang = 'en';
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String lang = '';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale(lang),
      title: 'Shopping Home',
      theme: theme(),
      initialRoute: '/Splash',
      getPages: [
        GetPage(
          name: '/Register',
          page: () => const RegisterScreen(),
          binding: SignUpBinding(),
        ),
        GetPage(
          name: '/SignIn',
          page: () => const SignInScreen(),
          binding: SignInBinding(),
        ),
        GetPage(
          name: '/Splash',
          page: () => const SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/completeProfile',
          page: () => const CompleteProfileScreen(),
          binding: SignUpBinding(),
        ),
        GetPage(
          name: '/ForgetPassword',
          page: () => const ForgetPasswordScreen(),
          binding: ForgetPasswordBinding(),
        ),
        GetPage(
          name: '/SignInSuccess',
          page: () => const SignInSuccessScreen(),
        ),
        GetPage(
          name: '/OTB',
          page: () => const OtpScreen(),
        ),
        GetPage(
          name: '/Home',
          page: () => const HomeScreen(),
          binding: ShowProductsBinding(),
        ),
        GetPage(
          name: '/Details',
          page: () => const DetailsScreen(),
        ),
        GetPage(
          name: '/editDetails',
          page: () => const EditDetailsScreen(),
          binding: EditProductBinding(),
        ),
        GetPage(
          name: '/addProduct',
          page: () => const AddProductScreen(),
          binding: AddProductBinding(),
        ),
        GetPage(
          name: '/Profile',
          page: () => const ProfileScreen(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/Search',
          page: () => const SearchScreen(),
          binding: SearchBinding(),
        ),
        GetPage(
          name: '/review',
          page: () => const ReviewScreen(),
          binding: ReviewBinding(),
        ),
        GetPage(
          name: '/edit_profile',
          page: () => const EditProfileScreen(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: '/Cart',
          page: () => CartScreen(),
          binding: ShowMyOrderBinding(),
        ),
        GetPage(
          name: '/Notifications',
          page: () => NotificationsScreen(),
        ),
        GetPage(
          name: '/Change_password',
          page: () => const ChangePasswordScreen(),
          binding: ForgetPasswordBinding(),
        ),
        GetPage(
          name: '/Profile_details',
          page: () => const ProfileDetailsScreen(),
          binding: UserBinding(),
        ),
        GetPage(
          name: '/Categories',
          page: () => const CategoriesScreen(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: '/Category',
          page: () => const CategoryScreen(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: '/My_Products',
          page: () => const MyProductsScreen(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/Wallet',
          page: () => const WalletScreen(),
          binding: WalletBinding(),
        ),
        GetPage(
          name: '/Records',
          page: () => const RecordsScreen(),
          binding: RecordBinding(),
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
