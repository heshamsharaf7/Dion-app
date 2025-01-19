import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/user/login_dto.dart';
import 'package:dionapplication/data/model/user/user_model.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> isPhoneNoExist(String phoneNo) async {
    return await apiClient.getData('${AppConstants.USER}/$phoneNo');
  }
  
  Future<Response> addUser(UserModel user) async {
    return await apiClient.postData(AppConstants.USER_ADD_ACCOUNT,user);
  }

  Future<Response> loginAsUser(
      LoginModel merchantLoginModel) async {
    return await apiClient.postData(AppConstants.USER_LOGIN, merchantLoginModel);
  }


}
