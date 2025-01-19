import 'package:dionapplication/data/model/store_type/store_type_model.dart';
import 'package:dionapplication/data/model/user/user_get_model.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  UserHomeController({required this.storeCustomersRepo});
  List<StoreTypeModel>? storeTypeList;
  UserGetModel? user;

  @override
  void onInit() {
    super.onInit();
    getInitData();
  }

  getInitData() async {
    await getUserInfo();
    await getStoreTypes();
  }

  getUserInfo() async {
    int userId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID)!;
    Response response = await storeCustomersRepo.getUserById(userId);
    if (response.statusCode == 200) {
      user = UserGetModel.fromJson(response.body);
      update();
    }
  }

  getStoreTypes() async {
    int userId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID)!;
    if (storeTypeList == null) {
      Response response =
          await storeCustomersRepo.getStoreTypesForCustomers(userId);
      if (response.statusCode == 200) {
        storeTypeList = [];
        response.body.forEach((o) {
          storeTypeList!.add(StoreTypeModel.fromJson(o));

          // orderList!.add(OrderInfo(o['id'], "f", o['enteredDate']));
        });
        update();
      }

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }
}
