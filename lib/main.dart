import 'dart:ui';
import 'package:dionapplication/SharedPreferance/shared_preferance.dart';
import 'package:dionapplication/controller/localization_controller.dart';
import 'package:dionapplication/controller/theme_controller.dart';
import 'package:dionapplication/theme/dark_theme.dart';
import 'package:dionapplication/theme/light_theme.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/app_pages.dart';
import 'helper/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpHelper.spHelper.initSharedPrefrences();
  Map<String, Map<String, String>> _languages = await di.init();
  
  // try {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: 'AIzaSyDpo9Ig979MU98A4sfZC-Wm0b-LU5Sm9GE',
  //       appId: '1:191527608669:android:86c9b34fe4c2b6d15248b4',
  //       messagingSenderId: '191527608669',
  //       projectId: 'dion-440d5',
  //       storageBucket: 'dion-440d5.appspot.com',
  //     ),
  //   );
  // } catch (e) {}


  SharedPreferences prefs = Get.find();
  bool onboardingComplete =
      prefs.getBool(AppConstants.ONBOARDING_COMPLETE) ?? false;

  runApp(MyApp(
    onboardingComplete: onboardingComplete,
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;
  final Map<String, Map<String, String>> languages;

  const MyApp(
      {Key? key, required this.onboardingComplete, required this.languages})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return 
        GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          theme: themeController.darkTheme ? dark : light,
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
              AppConstants.languages[0].countryCode),
          // initialRoute: GetPlatform.isWeb ? RouteHelper.getInitialRoute() : RouteHelper.getSplashRoute(body),
          initialRoute:
              onboardingComplete ? Routes.CHOOSEACCOUNT : Routes.ONBOARDING,
          getPages: AppPages.routes,
          defaultTransition: Transition.topLevel,
          transitionDuration: Duration(milliseconds: 500),
        );
      });
    });
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'ديون',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   initialRoute:
    //       onboardingComplete ? Routes.CHOOSEACCOUNT : Routes.ONBOARDING,
    //   getPages: AppPages.routes,
    //   locale: Get.deviceLocale,
    // );
  }
}


// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }
