import 'dart:convert';
import 'package:dionapplication/SharedPreferance/shared_preferance.dart';
import 'package:dionapplication/controller/greeting_controller.dart';
import 'package:dionapplication/controller/localization_controller.dart';
import 'package:dionapplication/controller/theme_controller.dart';
import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/utili/language_model.dart';
import 'package:dionapplication/data/repository/invoice_repo.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/data/repository/store_repo.dart';
import 'package:dionapplication/data/repository/user_repo.dart';
import 'package:dionapplication/data/repository/wallet_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/dailog_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.put<SharedPreferences>(sharedPreferences);
  Get.put(ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository UserRepo
  Get.put(StoreRepo(apiClient: Get.find()));
  Get.put(UserRepo(apiClient: Get.find()));
  Get.put(StoreCustomersRepo(apiClient: Get.find()));
    Get.put(InvoiceRepo(apiClient: Get.find()));
    Get.put(WalletRepo(apiClient: Get.find()));


  // Controller

  Get.lazyPut(() =>
      ThemeController(sharedPreferences: SpHelper.spHelper.sharedPreferences));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => TimeGreetingController(), fenix: true);
  // Get.lazyPut(() => ManageCreditorsController(), fenix: true);
  // Get.lazyPut(() => AddDeptController(), fenix: true);


//services
  Get.lazyPut<DialogService>(() => DialogService());

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
