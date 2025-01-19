import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/store_customers/store_customers_add.dart';
import 'package:dionapplication/data/model/user/user_get_model.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/dailog_info.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCustomerController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  AddCustomerController({required this.storeCustomersRepo});

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController AddressC = TextEditingController();
  TextEditingController accountCapacityC = TextEditingController();

  RxBool customerHasAccount = true.obs;

  //forms
  GlobalKey<FormState> formKey = GlobalKey();
  //loading
  RxBool isLoading = false.obs;

  addCustomer() {
    if (customerHasAccount.value) {
      addCustomerWithAccount();
    } else {
      addCustomerWithNoAccount();
    }
  }

  addCustomerWithNoAccount() async {
    isLoading.value = true;
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;

    Response responseStore = await storeCustomersRepo.getStore(storeId);

    StoreGetModel store = StoreGetModel.fromJson(responseStore.body);

    StoreCustomersAddDto customer = StoreCustomersAddDto(
        enteredDate: DateTime.now().toString(),
        accountCapacity: double.parse(accountCapacityC.text),
        cuAddress: AddressC.text,
        cuName: nameC.text,
        isAccepted: true,
        isLock: false,
        payNotification: true,
        storeId: store.id!,
        userId: 0,
        storeTypeId: store.storeTypeId!);

    Response responseAddSCustomer =
        await storeCustomersRepo.addCustomer(customer);
    StoreCustomersGetDto customerGet =
        StoreCustomersGetDto.fromJson(responseAddSCustomer.body);
    print(customerGet);

    if (responseAddSCustomer.statusCode == 200) {
      print("customer added");
      nameC.clear();
      phoneC.clear();
      AddressC.clear();
      accountCapacityC.clear();
      CustomSnackBar.showSuccessMessage(message: " تم اضافه العميل بنجاح");

      // CustomToast.successToast("  تم اضافه العميل    ");
    } else {
      CustomSnackBar.showErrorMessage(
          message: "حدث خطأ اثناء الاضافه الرجاء اعاده الاضافه");
    }
    isLoading.value = false;
  }

  addCustomerWithAccount() async {
    isLoading.value = true;
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeCustomersRepo.isPhoneNoExist(phoneC.text);
    if (response.statusCode == 200) {
      if (response.body == false) {
        DialogService.showInfoDialog('لا يوجد حساب بهذا الرقم');
      } else {
        Response responseUser =
            await storeCustomersRepo.getUserByPhoneNo(phoneC.text);

        UserGetModel user = UserGetModel.fromJson(responseUser.body);
        Response responseIsUserExist =
            await storeCustomersRepo.isUserExist(user.id!, storeId);
        if (responseIsUserExist.statusCode == 200) {
          if (responseIsUserExist.body == true) {
            DialogService.showInfoDialog('العميل مسجل بالفعل لديك');
            isLoading.value = false;

            return;
          }
        } else {
          CustomSnackBar.showErrorMessage(message: "حدث خطأ ");
          isLoading.value = false;

          return;
        }
        if (user.userType == 1) {
          Response responseStore = await storeCustomersRepo.getStore(storeId);

          StoreGetModel store = StoreGetModel.fromJson(responseStore.body);

          StoreCustomersAddDto customer = StoreCustomersAddDto(
              enteredDate: DateTime.now().toString(),
              accountCapacity: double.parse(accountCapacityC.text),
              cuAddress: AddressC.text,
              cuName: nameC.text,
              isAccepted: false,
              isLock: false,
              payNotification: true,
              storeId: store.id!,
              userId: user.id!,
              storeTypeId: store.storeTypeId!);

          Response responseAddSCustomer =
              await storeCustomersRepo.addCustomer(customer);
          StoreCustomersGetDto customerGet =
              StoreCustomersGetDto.fromJson(responseAddSCustomer.body);
          print(customerGet);

          if (responseAddSCustomer.statusCode == 200) {
            print("customer added");
            nameC.clear();
            phoneC.clear();
            AddressC.clear();
            accountCapacityC.clear();
            CustomSnackBar.showSuccessMessage(
                message: "تم ارسال طلب الاضافه الى العميل");
          } else {
            CustomSnackBar.showErrorMessage(message: "حدث خطأ ");
          }
        } else {
          DialogService.showInfoDialog('لا يوجد حساب بهذا الرقم');
        }
      }
    } else {
      CustomSnackBar.showErrorMessage(message: "حدث خطأ ");
    }

    isLoading.value = false;
  }
}
