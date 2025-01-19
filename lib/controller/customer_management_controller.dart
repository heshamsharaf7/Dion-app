import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/transactions/transaction_addt_dto.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerManagementController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  CustomerManagementController({required this.storeCustomersRepo});

  // List<StoreCustomersGetDto>? customersList;

  TextEditingController searchC = TextEditingController();
  TextEditingController creditMoneyC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var isLoading = false.obs;
  var isLoadingCustomers = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
    searchC.addListener(filterCustomers);
  }

  var customersList = <StoreCustomersGetDto>[].obs; // Full list of customers
  var filteredCustomersList = <StoreCustomersGetDto>[].obs; // Filtered list

  // Filter criteria
  RxBool showLockedOnly = false.obs; // Toggle for locked customers
  RxBool showNotificationOnly =
      false.obs; // Toggle for customers with notifications
  RxString selectedStoreName = ''.obs; // Selected store name (for dropdown)

  // Multi-criteria filtering function
  void filterCustomers() {
    String query = searchC.text.toLowerCase();

    filteredCustomersList.value = customersList.where((customer) {
      // Check search query
      bool matchesSearch = query.isEmpty ||
          customer.cuName.toLowerCase().contains(query) ||
          customer.cuAddress.toLowerCase().contains(query);

      // Check locked filter
      bool matchesLocked = !showLockedOnly.value || customer.isLock;

      // Check notification filter
      bool matchesNotification =
          !showNotificationOnly.value || customer.payNotification;

      // Check store filter
      bool matchesStore = selectedStoreName.value.isEmpty;

      // Combine all conditions
      return matchesSearch &&
          matchesLocked &&
          matchesNotification &&
          matchesStore;
    }).toList();
  }

  // // Mock data function
  // Future<void> getCustomers() async {
  //   await getCustomers();
  //   filteredCustomersList.value = customersList; // Initialize both lists
  // }
  refreshCustomerData(StoreCustomersGetDto customersGetDto) async {
    Response response =
        await storeCustomersRepo.getCustomerInfoById(customersGetDto.id);
    print(response.statusCode);

    if (response.statusCode == 200) {
      StoreCustomersGetDto storeCustomer =
          StoreCustomersGetDto.fromJson(response.body);

      // Update customersList
      var cIndex = customersList
          .indexWhere((element) => element.id == customersGetDto.id);
      if (cIndex != -1) {
        customersList[cIndex] = storeCustomer;
      }

      // Update filteredCustomersList
      var cfIndex = filteredCustomersList
          .indexWhere((element) => element.id == customersGetDto.id);
      if (cfIndex != -1) {
        filteredCustomersList[cfIndex] = storeCustomer;
      }
    }
  }

  getCustomers() async {
    isLoadingCustomers.value = true;
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeCustomersRepo.getStoreCustomers(storeId);
    if (response.statusCode == 200) {
      customersList.value = [];
      response.body.forEach((o) {
        customersList.add(StoreCustomersGetDto.fromJson(o));
      });
      filteredCustomersList.value = customersList;
    }
    isLoadingCustomers.value = false;
  }

  addMoney(StoreCustomersGetDto storeCustomer) async {
    Get.back();

    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    TransactionAddtDto transaction = TransactionAddtDto(
        statement: "قبض مبلغ",
        enteredDate: DateTime.now().toString(),
        debit: 0,
        credit: double.parse(creditMoneyC.text),
        currencyId: 2,
        customerId: storeCustomer.id,
        storeId: storeId);

    Response response = await storeCustomersRepo.addMoney(transaction);

    if (response.statusCode == 200) {
      print("transaction added");

      CustomSnackBar.showSuccessMessage(message: "تم تنفيذ العمليه بنجاح   ");
    } else {
      CustomSnackBar.showErrorMessage(message: "حدث خطأ أثناء العملية");
    }
    creditMoneyC.clear();
    isLoading.value = false;
  }

  getMoney(StoreCustomersGetDto storeCustomer) {
    creditMoneyC.clear();
    isLoading.value = false;

    Get.defaultDialog(
      title: " قبض مبلغ",
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomInput(
                controller: creditMoneyC,
                keyboardType: TextInputType.number,
                hint: "ادخل المبلغ",
                requiredField: true,
                label: "ادخل المبلغ المقبوض",
                icno: Icon(Icons.money),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (isLoading.value == false) {
                      addMoney(storeCustomer);
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
                child: Text("حفظ",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      radius: 12,
    );
  }
}
