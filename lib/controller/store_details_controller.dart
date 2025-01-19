import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/data/model/user/user_get_model.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreDetailsController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  StoreDetailsController({required this.storeCustomersRepo});

  StoreCustomersGetDto? storeCustomer;
  UserGetModel? user;
  StoreGetModel? store;
  int? storeId;
  double todayTotalDebt = 0;
  List<InvoiceGetDto>? invoiceItems;
  List<TransactionsGetModel>? transactions;

  @override
  void onInit() {
    super.onInit();
    getInitData();
  }

  getInitData() async {
    try {
      storeId = Get.arguments['storeId'];
      print(storeId);
      await getStoreInfo();
      await getUserInfo();
      await getCustomerInfo();

      // await getAllStoreCustomerTransactions();
      // getDebt();
      await getInvoiceItems();
      update();
    } catch (e) {
      // user!.userName = "no data";
      update();
    }
  }

  getStoreInfo() async {
    Response response = await storeCustomersRepo.getStore(storeId!);
    if (response.statusCode == 200) {
      store = StoreGetModel.fromJson(response.body);
    }
  }

  getUserInfo() async {
    int userId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID)!;

    if (storeCustomer == null) {
      Response response = await storeCustomersRepo.getUserById(userId);
      if (response.statusCode == 200) {
        user = UserGetModel.fromJson(response.body);
      }
    }
  }

  getCustomerInfo() async {
    int userId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID)!;
    int storeId = Get.arguments?['storeId'];

    if (storeCustomer == null) {
      Response response =
          await storeCustomersRepo.getCustomerInfo(userId, storeId);
      print(response.statusCode);
      if (response.statusCode == 200) {
        storeCustomer = StoreCustomersGetDto.fromJson(response.body);
      }
    }
  }

  // getDebt() async {
  //   totalDebt = TransactionsUtils.calculateTotalDebt(transactions!);

  //   // Response response =
  //   //     await storeCustomersRepo.getTotalDebtCreditDiscrepancy(user!.id!);
  //   // if (response.statusCode == 200) {
  //   //   totalDebt = double.parse(response.body.toString());

  //   //   //  else {
  //   //   //   ApiChecker.checkApi(response);
  //   //   // }
  //   // }
  // }

  // getAllStoreCustomerTransactions() async {
  //   // int storeId =
  //   //     Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
  //   Response response =
  //       await storeCustomersRepo.getAllStoreCustomerTransactions(
  //           storeCustomer!.id, storeCustomer!.storeId);
  //   if (response.statusCode == 200) {
  //     transactions = [];
  //     response.body.forEach((o) {
  //       transactions!.add(TransactionsGetModel.fromJson(o));
  //     });
  //   } else {
  //     transactions = [];
  //   }
  // }

  getInvoiceItems() async {
    if (invoiceItems == null) {
      Response response =
          await storeCustomersRepo.getCustomerInvoiceItems(storeCustomer!.id);
      if (response.statusCode == 200) {
        invoiceItems = [];
        response.body.forEach((o) {
          var x = InvoiceGetDto.fromJson(o);
          invoiceItems!.add(x);
          todayTotalDebt += (x.quantity * x.unitPrice);
        });
        print(response.body);
        update();
      } else {
        invoiceItems = [];
      }
    }
  }
}
