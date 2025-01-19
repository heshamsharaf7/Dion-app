
import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/user/login_dto.dart';
import 'package:dionapplication/data/model/store/store_add_moedl.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class StoreRepo {
  final ApiClient apiClient;
  StoreRepo({ required this.apiClient});

  Future<Response> getStoreTypeList() async {
    return await apiClient.getData(AppConstants.STORE_TYPE);
  }
  Future<Response> isPhoneNoExist(String phoneNo) async {
    return await apiClient.getData('${AppConstants.USER}/$phoneNo');
  }
  
  Future<Response> addStore(StoreAddModel store) async {
    return await apiClient.postData(AppConstants.STORE,store);
  }
  Future<Response> loginAsMerchant(
      LoginModel merchantLoginModel) async {
    return await apiClient.postData(AppConstants.MERCHANT_LOGIN, merchantLoginModel);
  }
   Future<Response> getAllStoreTransactions(
      int storeId) async {
    return await apiClient.getData('${AppConstants.GET_ALL_STORE_TRANSACTIONS}/$storeId');
  }
  // Future<Response> getTotalDebtCreditDiscrepancyForCurrentDay(
  //     int storeId) async {
  //   return await apiClient.getData('${AppConstants.GETTOTALDEBTCREDITDISCREPANCYFORCURRENTDAYSTORE}/$storeId');
  // }
  // Future<Response> getTotalDebtCreditDiscrepancy(
  //     int storeId) async {
  //   return await apiClient.getData('${AppConstants.GETTOTALDEBTCREDITDISCREPANCYSTORE}/$storeId');
  // }
 Future<Response> getStore(
      int storeId) async {
    return await apiClient.getData('${AppConstants.GET_STORE}/$storeId');
  }

}