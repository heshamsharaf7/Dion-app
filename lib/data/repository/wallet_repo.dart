import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/store_wallet/store_wallet_add_dto.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class WalletRepo {
  final ApiClient apiClient;
  WalletRepo({required this.apiClient});

  
  Future<Response> getWalletsTypes() async {
    return await apiClient.getData('${AppConstants.GET_WALLET_TYPES}');
  }
  Future<Response> addWalet(StoreWalletsAddModel wallet) async {
    return await apiClient.postData(AppConstants.STORE_WALLETS,wallet);
  }

  Future<Response> getStoreWalletsByStoreId(int storeId) async {
    return await apiClient.getData('${AppConstants.STORE_WALLETS_GET_BY_STOREID}/$storeId');
  }

}
