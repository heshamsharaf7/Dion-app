
import 'package:dionapplication/data/api/api_client.dart';
import 'package:dionapplication/data/model/invoice/invoice_add_moedl.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class InvoiceRepo {
  final ApiClient apiClient;
  InvoiceRepo({ required this.apiClient});

 
  
  Future<Response> addInvoice(InvoiceAddDto invoice) async {
    return await apiClient.postData(AppConstants.INVOICE,invoice);
  }
  Future<Response> getCustomerParticipant(int customerId) async {
    return await apiClient
        .getData('${AppConstants.GET_CUSTOMER_PARTICIPANTS}/$customerId');
  }
}