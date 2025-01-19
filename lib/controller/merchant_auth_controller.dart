import 'package:dionapplication/data/model/user/login_dto.dart';
import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store/store_add_moedl.dart';
import 'package:dionapplication/data/model/store_type/store_type_model.dart';
import 'package:dionapplication/data/repository/store_repo.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/dailog_info.dart';
import 'package:dionapplication/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dionapplication/util/get_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantAuthController extends GetxController implements GetxService {
  final StoreRepo storeRepo;

  MerchantAuthController({required this.storeRepo});

  //forms
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  //login texts editors
  TextEditingController loginPhoneNoC = TextEditingController();
  TextEditingController loginPasswordC = TextEditingController();

  //signup texts editors
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController storeNameC = TextEditingController();
  TextEditingController storePhoneC = TextEditingController();

  StoreTypeModel? selectedStoreType;

  RxBool errorMessage = false.obs;
  String? errorMessageContetnt;
  RxBool isLoading = false.obs;

  //lists
  List<StoreTypeModel>? storeTypeList;
  List<StoreGetModel>? userStoreList;

  @override
  void onInit() async {
    super.onInit();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    isLoading.value = true;

    if (storeTypeList == null) {
      Response response = await storeRepo.getStoreTypeList();
      if (response.statusCode == 200) {
        storeTypeList = [];
        // _interestSelectedList = [];
        response.body.forEach((category) {
          storeTypeList!.add(StoreTypeModel.fromJson(category));
          // _interestSelectedList.add(false);
        });
        update();
      }
      isLoading.value = false;

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }

  registerAccount() async {
    try {
      isLoading.value = true;

      Response response = await storeRepo.isPhoneNoExist(phoneNoC.text);
      if (response.statusCode == 200) {
        if (response.body) {
          // errorMessageContetnt = "هذا الحساب مسجل برقم هاتف من قبل";
          // errorMessage.value = true;
          DialogService.showInfoDialog('هذا الحساب مسجل برقم الهاتف من قبل');
        } else {
          Position position = await getCurrentLocation();

          StoreAddModel store = StoreAddModel(
              id: 0,
              enteredDate: DateTime.now().toString(),
              phoneNo: int.parse(phoneNoC.text),
              storeName: storeNameC.text,
              userName: nameC.text,
              storeTypeId: selectedStoreType!.id,
              userType: 2,
              storePhoneNo: int.parse(storePhoneC.text),
              storeVerified: false,
              userAddress: addressC.text,
              userPassword: passwordC.text,
              latitude: position.latitude,
              longitude: position.longitude);

          Response responseAddStore = await storeRepo.addStore(store);
          if (responseAddStore.statusCode == 200) {
            print("user added");
            var store = StoreGetModel.fromJson(responseAddStore.body);
            Get.find<SharedPreferences>()
                .setInt(AppConstants.CURRENT_STORE_ID, store.id!);
            Get.find<SharedPreferences>()
                .setBool(AppConstants.MERCHANT_LOGINED, true);
            Get.offAllNamed(Routes.MERCHANTHOME);
          } else {
            CustomToast.errorToast(" حدث خطأ");
          }
        }
      } else {
        CustomToast.errorToast(" حدث خطأ");
      }

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast(" حدث خطأ");

      isLoading.value = false;
    }
  }

  login() async {
    isLoading.value = true;
    LoginModel merchantLoginModel = LoginModel(
        phoneNo: int.parse(loginPhoneNoC.text),
        userPassword: loginPasswordC.text,
        userType: 2);
    Response response = await storeRepo.loginAsMerchant(merchantLoginModel);
    if (response.statusCode == 200) {
      if (response.body.length != 0) {
        userStoreList = [];
        response.body.forEach((store) {
          userStoreList!.add(StoreGetModel.fromJson(store));
        });
        Get.find<SharedPreferences>()
            .setInt(AppConstants.CURRENT_STORE_ID, userStoreList![0].id!);
        Get.find<SharedPreferences>()
            .setBool(AppConstants.MERCHANT_LOGINED, true);
        Get.offAllNamed(Routes.MERCHANTHOME);
        print("hi");
      } else {
        CustomToast.errorToast(" حدث خطأ");
      }
    } else {
      CustomToast.errorToast(" رقم الهاتف او كلمه المرور خطأ ");
    }

    isLoading.value = false;
  }
}
