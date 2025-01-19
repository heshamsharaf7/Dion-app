import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store_type/store_type_model.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreListsController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  StoreListsController({required this.storeCustomersRepo});

  List<StoreGetModel> storeList = []; // Initialized as a non-null empty list
  StoreTypeModel? storeType;

  @override
  void onInit() {
    super.onInit();
    print("StoreListsController initialized.");
    storeType = Get.arguments?['storeType'];
    if (storeType == null) {
      print("Error: storeType is null in Get.arguments.");
    }
    getStores();
  }

  getStores() async {
    // Retrieve userId from SharedPreferences and check if it's null
    int? userId = Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID);
    if (userId == null) {
      print('Error: User ID is null. Ensure CURRENT_USER_ID is set in SharedPreferences.');
      return; // Stop the function if userId is null
    }

    // Check if storeType is null before proceeding
    if (storeType == null) {
      print('Error: Store type is null. Cannot fetch stores without a store type.');
      return;
    }

    print("Fetching stores for user ID: $userId and store type ID: ${storeType!.id}");

    // Fetch store list only if it's empty
    if (storeList.isEmpty) {
      Response response = await storeCustomersRepo.getStoreForCustomers(userId, storeType!.id!);
      if (response.statusCode == 200 && response.body != null) {
        storeList.clear();
        response.body.forEach((o) {
          storeList.add(StoreGetModel.fromJson(o));
        });
        update();
      } else {
        print('Error: Failed to fetch store data or response body is null');
      }
    }
  }
}
