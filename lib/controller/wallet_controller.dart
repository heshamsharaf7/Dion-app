import 'package:dionapplication/data/model/store_wallet/store_wallet_get_dto.dart';
import 'package:dionapplication/data/repository/wallet_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  final WalletRepo walletRepo;
  WalletController({required this.walletRepo});

   List<StoreWalletsGetModel>? storeWallets;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getWalletList();
  }
 Future<void> getWalletList() async {
    isLoading.value = true;
 int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await walletRepo.getStoreWalletsByStoreId(storeId);
          storeWallets = [];

    if (response.statusCode == 200) {
      response.body.forEach((category) {
        storeWallets!.add(StoreWalletsGetModel.fromJson(category));
      });
      update();
    }
    isLoading.value = false;
  }

  //  [
  //   {
  //     "name": "Personal Wallet",
  //     "accountNo": "1234 5678 9012 3456",
  //     "details": "Primary wallet for personal expenses",
  //     "image": "assets/wallet1.png", // Replace with actual image paths
  //   },
  //   {
  //     "name": "Business Wallet",
  //     "accountNo": "9876 5432 1098 7654",
  //     "details": "Wallet for business transactions",
  //     "image": "assets/wallet2.png", // Replace with actual image paths
  //   },
  // ];
}
