import 'package:dionapplication/controller/add_customer_controller.dart';
import 'package:dionapplication/controller/add_dept_controller.dart';
import 'package:dionapplication/controller/add_wallet_controller.dart';
import 'package:dionapplication/controller/customer_management_controller.dart';
import 'package:dionapplication/controller/debt_details_controller.dart';
import 'package:dionapplication/controller/edit_customer_controller.dart';
import 'package:dionapplication/controller/financialReport_controller.dart';
import 'package:dionapplication/controller/manage_creditors_controller.dart';
import 'package:dionapplication/controller/merchant_auth_controller.dart';
import 'package:dionapplication/controller/merchant_home_controller.dart';
import 'package:dionapplication/controller/store_details_controller.dart';
import 'package:dionapplication/controller/store_lists_controller.dart';
import 'package:dionapplication/controller/store_orders_controller.dart';
import 'package:dionapplication/controller/store_fin_report_controller.dart';
import 'package:dionapplication/controller/store_reports_controller.dart';
import 'package:dionapplication/controller/user_auth_controller.dart';
import 'package:dionapplication/controller/user_home_controller.dart';
import 'package:dionapplication/controller/wallet_controller.dart';
import 'package:get/get.dart';

class AddCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCustomerController>(
      () => AddCustomerController(storeCustomersRepo: Get.find()),
    );
  }
}
//  Get.lazyPut(() => MerchantAuthController(storeRepo: Get.find()));
//   Get.lazyPut(() => UserAuthController(userRepo: Get.find()));

class MerchantAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantAuthController>(
      () => MerchantAuthController(storeRepo: Get.find()),
    );
  }
}

class UserAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAuthController>(
      () => UserAuthController(userRepo: Get.find()),
    );
  }
}

class EditCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCustomerController>(
      () => EditCustomerController(storeCustomersRepo: Get.find()),
    );
  }
}

class FinancialReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinancialReportController>(
      () => FinancialReportController(),
    );
  }
}

class AddDeptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeptController>(
      () => AddDeptController(Get.find()),
    );
  }
}

class StoreOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreOrdersController>(
      () => StoreOrdersController(storeCustomersRepo: Get.find()),
    );
  }
}

class CustomerManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerManagementController>(
      () => CustomerManagementController(storeCustomersRepo: Get.find()),
    );
  }
}

class UserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserHomeController>(
      () => UserHomeController(storeCustomersRepo: Get.find()),
    );
  }
}

class StoreListsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreListsController>(
      () => StoreListsController(storeCustomersRepo: Get.find()),
    );
  }
}

class StoreDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreDetailsController>(
      () => StoreDetailsController(storeCustomersRepo: Get.find()),
    );
  }
}

class ManageCreditorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageCreditorsController>(
      () => ManageCreditorsController(storeCustomersRepo: Get.find()),
    );
  }
}

class MerchantHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantHomeController>(
      () => MerchantHomeController(storeRepo: Get.find()),
    );
  }
}

class DebtDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebtDetailsController>(
      () => DebtDetailsController(storeCustomersRepo: Get.find()),
    );
  }
}
class StoreFinReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreFinReportController>(
      () => StoreFinReportController(storeCustomersRepo: Get.find(),storeRepo: Get.find()),
    );
  }
}



class StoreReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreReportsController>(
      () => StoreReportsController(storeCustomersRepo: Get.find()),
    );
  }
}

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(
      () => WalletController(walletRepo: Get.find()),
    );
  }
}


class AddWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWalletController>(
      () => AddWalletController(walletRepo: Get.find()),
    );
  }
}





