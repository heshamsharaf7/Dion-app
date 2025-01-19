import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/customer_paricipants/customer_paricipants_add_moedl.dart';
import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/store_customers/store_customers_add.dart';
import 'package:dionapplication/data/model/transactions/transaction_addt_dto.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class StoreCustomersRepo {
  final ApiClient apiClient;
  StoreCustomersRepo({required this.apiClient});

  Future<Response> addCustomer(StoreCustomersAddDto customer) async {
    return await apiClient.postData(AppConstants.STORE_CUSTOMERS, customer);
  }

  Future<Response> isPhoneNoExist(String phoneNo) async {
    return await apiClient.getData('${AppConstants.USER}/$phoneNo');
  }

  Future<Response> getUserByPhoneNo(String phoneNo) async {
    return await apiClient.getData('${AppConstants.USER_BY_PHONENO}/$phoneNo');
  }

  Future<Response> getStore(int storeId) async {
    return await apiClient.getData('${AppConstants.STORE}/$storeId');
  }

  Future<Response> isUserExist(int userId, int storeId) async {
    return await apiClient
        .getData('${AppConstants.USER_EXIST}/$userId/$storeId');
  }

  Future<Response> getOrders(int userId) async {
    return await apiClient.getData('${AppConstants.GET_ORDERS}/$userId');
  }

  Future<Response> getOrdersForUser(int userId) async {
    return await apiClient
        .getData('${AppConstants.GET_ORDERS_BY_USER}/$userId');
  }

  Future<Response> acceptedStore(int id) async {
    return await apiClient.postData('${AppConstants.ACCEPTSTORE}/$id', {});
  }

  Future<Response> getStoreCustomers(int storeId) async {
    return await apiClient.getData('${AppConstants.STORE_CUSTOMERS}/$storeId');
  }

  Future<Response> getStoreTypesForCustomers(int userId) async {
    return await apiClient
        .getData('${AppConstants.STORE_TYPS_FOR_CUSTOMERS}/$userId');
  }

  Future<Response> getStoreForCustomers(int userId, int storeTypeId) async {
    return await apiClient
        .getData('${AppConstants.STORERS__FOR_CUSTOMERS}/$userId/$storeTypeId');
  }

  Future<Response> getCustomerInfo(int userId, int storeId) async {
    return await apiClient
        .getData('${AppConstants.CUSTOMER_INFO}/$userId/$storeId');
  }
 Future<Response> getCustomerInfoById(int customerId) async {
    return await apiClient
        .getData('${AppConstants.GER_CUSTOMER}/$customerId');
  }
  Future<Response> getCustomerParticipant(int customerId) async {
    return await apiClient
        .getData('${AppConstants.GET_CUSTOMER_PARTICIPANTS}/$customerId');
  }

  Future<Response> addCustomerParticipant(
      CustomerParticipantAddDto customerParticipantAddDto) async {
    return await apiClient.postData('${AppConstants.ADD_CUSTOMER_PARTICIPANTS}',
        customerParticipantAddDto.toJson());
  }

  Future<Response> getUserById(int userId) async {
    return await apiClient.getData('${AppConstants.GET_USER_BY_ID}/$userId');
  }

  Future<Response> getAllStoreCustomerTransactions(
      int customerId, int storeId) async {
    return await apiClient.getData(
        '${AppConstants.GET_ALL_STORE_CUSTOMER_TRANSACTIONS}/$customerId/$storeId');
  }

  Future<Response> addMoney(TransactionAddtDto transaction) async {
    return await apiClient.postData(
        '${AppConstants.TRANSACTION}', transaction.toJson());
  }
  // Future<Response> getTotalDebtCreditDiscrepancy(int customerId) async {
  //   return await apiClient
  //       .getData('${AppConstants.GETTOTALDEBTCREDITDISCREPANCYCUSTOMER}/$customerId');
  // }
  //  Future<Response> GetTotalDebtCustomer(int customerId) async {
  //   return await apiClient
  //       .getData('${AppConstants.GETTOTALDEBTCUSTOMER}/$customerId');
  // }
  // Future<Response> GetTotalCreditCustomer(int customerId) async {
  //   return await apiClient
  //       .getData('${AppConstants.GETTOTALCREDITCUSTOMER}/$customerId');
  // }

  Future<Response> getCustomerInvoiceItems(int customerId) async {
    return await apiClient
        .getData('${AppConstants.GETINVOICEITEMSBYCUSTOMERID}/$customerId');
  }

  Future<Response> changeAccountLock(int customerId, bool statues) async {
    return await apiClient.postData(
        '${AppConstants.CHANGECUSTOMERLOCK}/$customerId',  statues);
  }
   Future<Response> changePayNotification(int customerId, bool statues) async {
    return await apiClient.postData(
        '${AppConstants.CHANGECUSTOMERNOTIFICATION}/$customerId',  statues);
  }
   Future<Response> updateCustomer(int customerId, StoreCustomersGetDto customer) async {
    return await apiClient.putData(
        '${AppConstants.UPDACUSTOMERDATA}/$customerId',  customer.toJson());
  }
  Future<Response> deleteItemFromInvoice(int invoiceDetailsId) async {
    return await apiClient.deleteData(
        '${AppConstants.DELETEITEMFROMINVOICE}/$invoiceDetailsId');
  }
   Future<Response> updateItemFromInvoice(InvoiceGetDto invoiceGetDto) async {
    return await apiClient.postData(
        '${AppConstants.UPDATEMFROMINVOICE}',invoiceGetDto.toJson());
  }
   Future<Response> deleteTransaction(int transactionId) async {
    return await apiClient.deleteData(
        '${AppConstants.DELETETRANSACTION}/$transactionId');
  }
   Future<Response> getInvoiceItems(int invoiceId) async {
    return await apiClient
        .getData('${AppConstants.GETINVOICEITEMS}/$invoiceId');
  }
  Future<Response> connectUser(int customerId,int phoneNo) async {
    return await apiClient
        .putData('${AppConstants.CONNECTUSER}/$customerId/$phoneNo',{});
  }
}
