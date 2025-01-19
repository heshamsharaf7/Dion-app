import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/data/repository/store_repo.dart';
import 'package:dionapplication/helper/transactions_utils.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantHomeController extends GetxController {
  final StoreRepo storeRepo;
  MerchantHomeController({required this.storeRepo});

  RxBool loadingInitData = true.obs;
  double? todayDebt;
  double? totalDebt;
  StoreGetModel? currentStore;
  List<TransactionsGetModel>? transactions;

  @override
  void onInit() {
    super.onInit();
    getinitData();
  }

  getSoreData() async {
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response responseAddStore = await storeRepo.getStore(storeId);
    if (responseAddStore.statusCode == 200) {
      currentStore = StoreGetModel.fromJson(responseAddStore.body);
    } else {
      currentStore = StoreGetModel(name: "no data");
      // currentStore!.name = "no data";
    }
  }

  getAllStoreTransactions() async {
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeRepo.getAllStoreTransactions(storeId);
    if (response.statusCode == 200) {
      transactions = [];
      response.body.forEach((o) {
        transactions!.add(TransactionsGetModel.fromJson(o));
      });
    } else {
      transactions = [];
    }
  }

  getDebt() {
    totalDebt = TransactionsUtils.calculateTotalDebt(transactions!);
    // Response response =
    //     await storeRepo.getTotalDebtCreditDiscrepancy(currentStore!.id!);
    // if (response.statusCode == 200) {
    //   totalDebt = double.parse(response.body.toString());

    //   //  else {
    //   //   ApiChecker.checkApi(response);
    //   // }
    // }
  }

  getTodayDebt() async {
    todayDebt =
        TransactionsUtils.calculateDebtForCurrentDay(transactions!);

    // Response response = await storeRepo
    //     .getTotalDebtCreditDiscrepancyForCurrentDay(currentStore!.id!);
    // if (response.statusCode == 200) {
    //   todayDebt = double.parse(response.body.toString());

    //   print("object${response.body}");
    //   //  else {
    //   //   ApiChecker.checkApi(response);
    //   // }
    // }
  }

  getinitData() async {
    try {
      await getAllStoreTransactions();
      await getSoreData();
      await getTodayDebt();
      await getDebt();
      loadingInitData.value = false;

      update();
    } catch (e) {
      update();
      todayDebt = 0;
      totalDebt = 0;
      loadingInitData.value = false;

      update();
    }
  }
}
