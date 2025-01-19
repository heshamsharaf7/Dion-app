import 'package:dionapplication/data/model/user/login_dto.dart';
import 'package:dionapplication/data/model/user/user_model.dart';
import 'package:dionapplication/data/repository/user_repo.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/dailog_info.dart';
import 'package:dionapplication/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserAuthController({required this.userRepo});

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

  RxBool isLoading = false.obs;

//user info
  UserModel? current_user;

  registerAccount() async {
    isLoading.value = true;

    Response response = await userRepo.isPhoneNoExist(phoneNoC.text);
    if (response.statusCode == 200) {
      if (response.body) {
        DialogService.showInfoDialog('هذا الحساب مسجل برقم الهاتف من قبل');
      } else {
        // Position position = await getCurrentLocation();

        UserModel user = UserModel(
          id: 0,
          enteredDate: DateTime.now().toString(),
          phoneNo: int.parse(phoneNoC.text),
          userName: nameC.text,
          userType: 1,
          userAddress: addressC.text,
          userPassword: passwordC.text,
        );

        Response responseAddStore = await userRepo.addUser(user);
        if (responseAddStore.statusCode == 200) {
          print("user added");
          current_user = UserModel.fromJson(responseAddStore.body);
//set the id for shared
          Get.find<SharedPreferences>()
              .setInt(AppConstants.CURRENT_USER_ID, current_user!.id!);
          //set user loggined
          Get.find<SharedPreferences>()
              .setBool(AppConstants.USER_LOGINED, true);
          //routing
          Get.offAllNamed(Routes.USERHOMESCREEN);
        } else {
          CustomToast.errorToast(" حدث خطأ");
        }
      }
    } else {
      CustomToast.errorToast(" حدث خطأ");
    }

    isLoading.value = false;
  }

  login() async {
    isLoading.value = true;
    LoginModel loginModel = LoginModel(
        phoneNo: int.parse(loginPhoneNoC.text),
        userPassword: loginPasswordC.text,
        userType: 1);
    Response response = await userRepo.loginAsUser(loginModel);
    if (response.statusCode == 200) {
      if (response.body != null) {
        current_user = UserModel.fromJson(response.body);
//set the id for shared
        Get.find<SharedPreferences>()
            .setInt(AppConstants.CURRENT_USER_ID, current_user!.id!);
        //set user loggined
        Get.find<SharedPreferences>().setBool(AppConstants.USER_LOGINED, true);
        //routing
        Get.toNamed(Routes.USERHOMESCREEN);
        //
        print(
            Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID));
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
