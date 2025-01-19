import 'package:dionapplication/controller/customer_management_controller.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:dionapplication/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCustomerController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  EditCustomerController({required this.storeCustomersRepo});

  TextEditingController phoneC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoConnectC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController accountCapacityC = TextEditingController();
  RxBool accountLock = false.obs;
  RxBool payNotification = false.obs;

  StoreCustomersGetDto? storeCustomer;
  RxBool isLoading = false.obs;
  RxBool isLoadingConnect = false.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKeyConnect = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    storeCustomer = Get.arguments;
    getInfo();
  }

  getInfo() {
    nameC.text = storeCustomer!.cuName;
    phoneC.text = storeCustomer!.userPhoneNo.toString();
    addressC.text = storeCustomer!.cuAddress;
    accountCapacityC.text = storeCustomer!.accountCapacity.toString();
    accountLock.value = storeCustomer!.isLock;
    payNotification.value = storeCustomer!.payNotification;

    print(storeCustomer!.userId);
  }

  changePayNotificationk(value) async {
    Response response = await storeCustomersRepo.changePayNotification(
        storeCustomer!.id, value);
    if (response.statusCode == 200) {
      payNotification.value = value;
    } else {
      CustomToast.errorToast(" حدث خطأ");
    }
  }

  updateCustomer() async {
    isLoading.value = true;
    StoreCustomersGetDto customer = StoreCustomersGetDto(
        totalDebt: 0,
        userPhoneNo: 0,
        id: storeCustomer!.id,
        enteredDate: DateTime.now().toString(),
        accountCapacity: double.parse(accountCapacityC.text),
        cuAddress: addressC.text,
        cuName: nameC.text,
        isAccepted: storeCustomer!.isAccepted,
        isLock: accountLock.value,
        payNotification: payNotification.value,
        storeId: storeCustomer!.storeId,
        userId: storeCustomer!.userId,
        storeTypeId: storeCustomer!.storeId);

    Response responseAddSCustomer =
        await storeCustomersRepo.updateCustomer(storeCustomer!.id, customer);
    StoreCustomersGetDto customerGet =
        StoreCustomersGetDto.fromJson(responseAddSCustomer.body);
    print(customerGet);

    if (responseAddSCustomer.statusCode == 200) {
      CustomToast.successToast("  تم تعديل البيانات    ");
    } else {
      CustomToast.errorToast(" حدث خطأ");
    }
    isLoading.value = false;
  }

  changeaccountLock(value) async {
    Response response =
        await storeCustomersRepo.changeAccountLock(storeCustomer!.id, value);
    if (response.statusCode == 200) {
      accountLock.value = value;
    } else {
      CustomToast.errorToast(" حدث خطأ");
    }
  }

  connectUserWithAccount() async {
    Response response = await storeCustomersRepo.connectUser(
        storeCustomer!.id, int.parse(phoneNoConnectC.text));
    if (response.statusCode == 200) {
      StoreCustomersGetDto c = StoreCustomersGetDto.fromJson(response.body);
      storeCustomer!.userId = c.userId;
      storeCustomer!.userPhoneNo = int.parse(phoneNoConnectC.text);
      phoneC.text = phoneNoConnectC.text;
      phoneNoConnectC.clear();
      Get.back();
      CustomSnackBar.showSuccessMessage(message: "تم ربط العميل بنجاح   ");
      update();
      var r = Get.find<CustomerManagementController>();
      await r.refreshCustomerData(c);
    } else {
      CustomSnackBar.showErrorMessage(
          message: "فشل ربط العميل يرجى التحقق من صحه البيانات      ");
    }
  }

  connectUser() {
    isLoadingConnect.value = false;

    Get.defaultDialog(
      title: " ربط العميل بحساب ",
      content: Form(
        key: formKeyConnect,
        child: Column(
          children: [
            CustomInput(
              controller: phoneNoConnectC,
              keyboardType: TextInputType.number,
              hint: "ادخل رقم الهاتف",
              requiredField: true,
              label: "ادخل رقم الهاتف ",
              icno: Icon(Icons.phone),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (formKeyConnect.currentState!.validate()) {
                  if (isLoadingConnect.value == false) {
                    // addMoney(storeCustomer);

                    connectUserWithAccount();
                  }
                }
                // controller.saveMoney();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("ربط",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
      radius: 12,
    );
  }
}
