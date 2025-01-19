import 'package:dionapplication/data/model/store_wallet/store_wallet_add_dto.dart';
import 'package:dionapplication/data/model/wallet/wallet_get_model.dart';
import 'package:dionapplication/data/repository/wallet_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWalletController extends GetxController {
  final WalletRepo walletRepo;
  AddWalletController({required this.walletRepo});

  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // Dropdown selection
  WalletGetModel? selectedWalletType;
  List<WalletGetModel>? walletTypes;

  @override
  void onInit() {
    super.onInit();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    isLoading.value = true;

    Response response = await walletRepo.getWalletsTypes();
    if (response.statusCode == 200) {
      walletTypes = [];
      response.body.forEach((category) {
        walletTypes!.add(WalletGetModel.fromJson(category));
      });
      update();
    }
    isLoading.value = false;
  }

  addWallet() async {
    isLoading.value = true;
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;

    StoreWalletsAddModel wallet = StoreWalletsAddModel(
        enteredDate: DateTime.now().toString(),
        accountNo: accountNoController.text,
        details: detailsController.text ?? "",
        storeId: storeId,
        walletId: selectedWalletType!.id);

    Response response = await walletRepo.addWalet(wallet);

    if (response.statusCode == 200) {
      print("customer added");
      accountNoController.clear();
      detailsController.clear();

      CustomSnackBar.showSuccessMessage(message: " تم اضافه المحفظه بنجاح");

      // CustomToast.successToast("  تم اضافه العميل    ");
    } else {
      CustomSnackBar.showErrorMessage(
          message: "حدث خطأ اثناء الاضافه الرجاء اعاده الاضافه");
    }
    isLoading.value = false;
  }
}
