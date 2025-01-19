import 'package:dionapplication/bindings/bindings.dart';
import 'package:dionapplication/view/auth/pages/merchant_auth/merchant_auth_screen.dart';
import 'package:dionapplication/view/auth/pages/chooseAccount_screen.dart';
import 'package:dionapplication/view/auth/pages/user_auth/user_auth_screen.dart';
import 'package:dionapplication/view/merchant/pages/add_customer_screen.dart';
import 'package:dionapplication/view/merchant/pages/add_dept_screen.dart';
import 'package:dionapplication/view/merchant/pages/add_wallet.dart';
import 'package:dionapplication/view/merchant/pages/customers_management_screen.dart';
import 'package:dionapplication/view/merchant/pages/debt_details_screen.dart';
import 'package:dionapplication/view/merchant/pages/edit_customer_screen.dart';
import 'package:dionapplication/view/merchant/pages/merchant_home_screen.dart';
import 'package:dionapplication/view/merchant/pages/store_report_screen.dart';
import 'package:dionapplication/view/merchant/pages/store_wallerts.dart';
import 'package:dionapplication/view/onBoarding/onboarding_screen.dart';
import 'package:dionapplication/view/user/pages/chooseReport_screen.dart';
import 'package:dionapplication/view/user/pages/ePayment_screen.dart';
import 'package:dionapplication/view/user/pages/financialReport_screen.dart';
import 'package:dionapplication/view/user/pages/manage_creditors_screen.dart';
import 'package:dionapplication/view/user/pages/store_details_screen.dart';
import 'package:dionapplication/view/user/pages/store_orders_screen.dart';
import 'package:dionapplication/view/user/pages/store_reports_screen.dart';
import 'package:dionapplication/view/user/pages/stores_list_screen.dart';
import 'package:dionapplication/view/user/pages/user_home_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.MERCHANTAUTHSCREEN,
      page: () => MerchantAuthScreen(),
      binding: MerchantAuthBinding()
    ),
    GetPage(
      name: _Paths.USERAUTHSCREEN,
      page: () => UserAuthScreen(),
      binding: UserAuthBinding()
    ),
    GetPage(
      name: _Paths.USERHOMESCREEN,
      page: () => UserHomeScreen(),
      binding: UserHomeBinding()
    ),
    GetPage(
      name: _Paths.STORESLIST,
      page: () => StoresListScreen(),
      binding: StoreListsBinding()
    ),
    GetPage(
      name: _Paths.STOREDETAILS,
      page: () => StoresDetailsScreen(),
      binding: StoreDetailsBinding()
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: _Paths.CHOOSEACCOUNT,
      page: () => ChooseAccountScreen(),
    ),
    GetPage(
      name: _Paths.MERCHANTAUTHSCREEN,
      page: () => MerchantAuthScreen(),
    ),
    GetPage(
      name: _Paths.MANAGECREDITORS,
      page: () => ManageCreditorsScreen(),
      binding: ManageCreditorsBinding()
    ),
    GetPage(
      name: _Paths.EPAYMENT,
      page: () => ePaymentScreen(),
    ),
    GetPage(
      name: _Paths.MERCHANTHOME,
      page: () => MerchantHomeScreen(),
      binding: MerchantHomeBinding()
    ),
    GetPage(
      name: _Paths.CUSTOMERSMANAGEMENT,
      page: () => CustomersManagementScreen(),
      binding: CustomerManagementBinding()
    ),
    GetPage(
      name: _Paths.ADDCUSTOMERSCREEN,
      page: () => AddCustomerScreen(),
      binding: AddCustomerBinding()
    ),
    GetPage(
      name: _Paths.ADDDEPTSCREEN,
      page: () => AddDeptScreen(),
      binding: AddDeptBinding()
    ),
    GetPage(
      name: _Paths.EDITCUSTOMERSCREEN,
      page: () => EditCustomerScreen(),
      binding: EditCustomerBinding()
    ),
    GetPage(
      name: _Paths.CHOOSEREPORTSCREEN,
      page: () => ChooseReportScreen(),
    ),
    GetPage(
      name: _Paths.FINANCIALREPORTSCREEN,
      page: () => FinancialReportScreen(),
      binding: FinancialReportBinding()
    ),
    GetPage(
      name: _Paths.STOREORDERCREEN,
      page: () => StoreOrdersScreen(),
      binding: StoreOrdersBinding()
    ),
    GetPage(
      name: _Paths.DEBTDETAILSSCREEN,
      page: () => DebtDetailsScreen(),
      binding: DebtDetailsBinding()
    ),
    GetPage(
      name: _Paths.STOREFINREPORTSCREEN,
      page: () => StoreFinReportScreen(),
      binding: StoreFinReportBinding()
    ),
     GetPage(
      name: _Paths.STOREREPORTSSCREEN,
      page: () => StoreReportScreen(),
      binding: StoreReportsBinding()
    ),
    GetPage(
      name: _Paths.WALLETMANAGEMENT,
      page: () => WalletManagementScreen(),
      binding: WalletBinding()
    ),
    GetPage(
      name: _Paths.ADDWALLET,
      page: () => AddWalletScreen(),
      binding: AddWalletBinding()
    ),
  ];
}
