import 'package:dionapplication/data/model/utili/language_model.dart';
import 'package:dionapplication/util/images.dart';

class AppConstants {
  // apis
  static const String APP_NAME = 'Dion';
  static const double APP_VERSION = 5.8;
  static const String BASE_URL = 'http://dionsys-001-site1.jtempurl.com';
  static const String STORE_TYPE = '/api/StoreType';
  static const String USER = '/api/User';
  static const String STORE = '/api/Store';
  static const String INVOICE = '/api/Invoice';
  static const String STORE_WALLETS = '/api/StoreWallets';
  static const String STORE_WALLETS_GET_BY_STOREID =
      '/api/StoreWallets/GetByStoreId';
  static const String MERCHANT_LOGIN = '/api/User/merchantLogin';
  static const String USER_ADD_ACCOUNT = '/api/User/userAddAccount';
  static const String USER_LOGIN = '/api/User/userLogin';
  static const String STORE_CUSTOMERS = '/api/StoreCustomers';
  static const String USER_BY_PHONENO = '/api/User/GetUserByPhoneNo';
  static const String USER_EXIST = '/api/StoreCustomers/isUserExist';
  static const String GET_ORDERS = '/api/StoreCustomers/getItemsByUserId';
  static const String GET_ORDERS_BY_USER =
      '/api/StoreCustomers/GetOrdersByUserId';
  static const String ACCEPTSTORE = '/api/StoreCustomers/AcceptedStore';
  static const String CHANGECUSTOMERLOCK =
      '/api/StoreCustomers/ChangeCustomerLock';
  static const String CHANGECUSTOMERNOTIFICATION =
      '/api/StoreCustomers/ChangeCustomerPayNotification';
  static const String UPDACUSTOMERDATA = '/api/StoreCustomers/UpdateItem';
  static const String DELETEITEMFROMINVOICE =
      '/api/Invoice/DeleteInvoiceDetail';
  static const String UPDATEMFROMINVOICE = '/api/Invoice/UpdateInvoiceDetail';
  static const String DELETETRANSACTION = '/api/Transaction/DeleteTransaction';
  static const String STORE_TYPS_FOR_CUSTOMERS =
      '/api/StoreCustomers/getStoreTypesByUserId';
  static const String STORERS__FOR_CUSTOMERS =
      '/api/StoreCustomers/getStoresByUserIdStoreAndTypeId';
  static const String CONNECTUSER = '/api/StoreCustomers/ConnectUser';
  static const String CUSTOMER_INFO =
      '/api/StoreCustomers/getItemByStoreAdUser';
  static const String GER_CUSTOMER = '/api/StoreCustomers/GetCustomer';
  static const String GET_CUSTOMER_PARTICIPANTS =
      '/api/CustomerParticipant/getByCustomerId';
  static const String ADD_CUSTOMER_PARTICIPANTS = '/api/CustomerParticipant';
  static const String TRANSACTION = "/api/Transaction";
  static const String GET_ALL_STORE_TRANSACTIONS =
      "/api/Transaction/GetAllStoreTransactions";
  static const String GET_ALL_STORE_CUSTOMER_TRANSACTIONS =
      "/api/Transaction/GetAllStoreCustomerTransactions";
  static const String GET_ALL_CUSTOMER_TRANSACTIONS = '';
  static const String GET_STORE = '/api/Store/GetStore';
  static const String GET_USER_BY_ID = '/api/User/GetUserById';
  static const String GETINVOICEITEMSBYCUSTOMERID =
      '/api/Invoice/GetInvoiceDetailsByCustomerId';
  static const String GETINVOICEITEMS =
      '/api/Invoice/GetInvoiceDetailsByInvoiceId';
static const String GET_WALLET_TYPES =
      '/api/Wallet';



  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'multivendor_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String ONBOARDING_COMPLETE = 'onboarding_complete';
  static const String MERCHANT_LOGINED = 'merchant_logined';
  static const String CURRENT_STORE_ID = 'current_store_id';
  static const String USER_LOGINED = 'user_logined';
  static const String CURRENT_USER_ID = 'current_user_id';
  static const String LANGUAGE_CODE = 'language_code';
  
  
  //Preference Day
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
