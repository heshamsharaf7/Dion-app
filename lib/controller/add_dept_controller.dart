import 'package:dionapplication/data/model/customer_paricipants/customer_paricipants_get_moedl.dart';
import 'package:dionapplication/data/model/invoice/invoice_add_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/repository/invoice_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDeptController extends GetxController {
  final InvoiceRepo invoiceRepo;

  AddDeptController(this.invoiceRepo);

  final isChecked = true.obs;
  final selectedValue = 'بيان عادي'.obs;

  changeInvoiceType(String value) {
    selectedValue.value = value.toString();

    if (value == 'تفصيلي' && invoiceItems.length == 0) {
      ddContainer();
      ddContainer();
    }
  }

  TextEditingController amountC = TextEditingController();
  TextEditingController detailsC = TextEditingController();

  TextEditingController itemAmountC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  //forms
  GlobalKey<FormState> formKey = GlobalKey();

  StoreCustomersGetDto? customer;

  @override
  void onInit() async {
    super.onInit();
    customer = Get.arguments;
    getCustoemrParticipantList(customer!.id);
  }

  var isLoading = false.obs;

  // var itemDataList = <Map<int, String>>[].obs;
  void addMultiInvoiceItems() {
    List<InvoiceItems> items = [];
    invoiceItems.forEach((key, value) {
      if (value.containsValue('') || value.containsValue(null)) {
        return; // Skip items with empty or null values
      }

      print('Index: $key');
      print('Name: ${value['name']}');
      print('Amount: ${value['amount']}');
      print('Price: ${value['price']}');

      print('Total: ${value['total']}');
      print('-----------------------');
      items.add(InvoiceItems(
          quantity: int.parse(value['amount'].toString()),
          statement: value['name'].toString(),
          unitPrice: double.parse(value['price'].toString())));
    });
    if (items.length != 0) {
      addInvoice(items);
      invoiceItems.clear();
    }
  }

  void deleteItem(int index) {
    invoiceItems.remove(index);
  }

  void calculateTotal(int index) {
    if (invoiceItems.containsKey(index)) {
      final item = invoiceItems[index];
      if (item != null) {
        final amount = double.tryParse(item['amount'] ?? '0') ?? 0;
        final price = double.tryParse(item['price'] ?? '0.00') ?? 0.00;
        final total = amount * price;
        item['total'] = total.toString();
        update();
        print(item);
      }
    }
  }

  RxMap<int, Map<String, String>> invoiceItems =
      <int, Map<String, String>>{}.obs;
  // Method to initialize an item in the list
  // void addItemData() {
  //   itemDataList.add({
  //     'name': '',
  //     'amount': '',
  //     'price': '',
  //   });
  // }

  // Method to update item data in the list
  void updateItemData(int index, String key, String value) {
    if (invoiceItems.containsKey(index)) {
      invoiceItems[index]![key] = value;
      if (key == 'amount' || key == 'price') {
        calculateTotal(index);
      }
    }
  }

  void ddContainer() {
    if (invoiceItems.length < 20) {
      int newIndex = 0;
      if (invoiceItems.isNotEmpty) {
        newIndex = invoiceItems.keys.reduce((a, b) => a > b ? a : b) + 1;
      }

      invoiceItems[newIndex] = {
        'name': '',
        'amount': '',
        'price': '',
        'total': '0'
      };

      // itemControllers.add(Get.find<AddDeptController>());
      // itemControllers.last.addItemData(); // Initialize new item data in list
    }
  }
  // retrieveListViewData(itemControllers) {
  //   // List to store all item data
  //   List<Map<String, String>> itemDataList = [];

  //   print("object${itemDataList}");
  //   // Loop through each controller in itemControllers
  //   for (var i = 0; i < itemControllers.length; i++) {
  //     final controller = itemControllers[i];

  //     // Get values from the TextEditingControllers
  //     final name = controller.nameC.text;
  //     final price = controller.priceC.text;
  //     final amount = controller.itemAmountC.text;

  //     // Check if the values are not empty
  //     if (name.isNotEmpty || price.isNotEmpty || amount.isNotEmpty) {
  //       // Add data to the list as a Map
  //       itemDataList.add({'name': name, 'price': price, 'amount': amount});
  //     }
  //   }

  //   // Print or process the collected data
  //   print(itemDataList);
  //   // You can also upload this data to a server, save it locally, etc.
  // }

  @override
  void onClose() {
    nameC.dispose();
    amountC.dispose();
    priceC.dispose();
    super.onClose();
  }

  // addMultiInvoiceItems() {}
  addInvoice1Item() {
    addInvoice([
      InvoiceItems(
          quantity: 1,
          statement: detailsC.text,
          unitPrice: double.parse(amountC.text))
    ]);
  }

  addInvoice(List<InvoiceItems> invoiceItems) async {
    // isLoading.value = true;
    double customerTotalDebt = customer!.totalDebt;

    invoiceItems.forEach((element) {
      customerTotalDebt += (element.quantity * element.unitPrice);
    });
    if (!customer!.isAccepted) {
      CustomSnackBar.showErrorMessage(
          message:
              "عذرا لا يمكن التدين لهذا الحساب (يرجى ابلاغ العميل بالموافقه على طلب الاضافه)  ");
      return;
    }
    if (customer!.isLock) {
      CustomSnackBar.showErrorMessage(
          message: "عذرا لا يمكن التدين لهذا الحساب (الحساب مقفل)  ");
      return;
    }
    if (customerTotalDebt > customer!.accountCapacity) {
      CustomSnackBar.showErrorMessage(
          message: "المبلغ المراد تدينه اكبر من المبلغ المسموح   ");
      return;
    }
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    List<InvoiceItems> items = invoiceItems;
    InvoiceAddDto invoice = InvoiceAddDto(
        currencyId: 2,
        customerId: customer!.id,
        storeId: storeId,
        participantId:
            isChecked.value == true ? 0 : (selectedParticipant?.id ?? 0),
        enteredDate: DateTime.now().toString(),
        invoiceItems: items);
    print(invoice.toJson());

    Response response = await invoiceRepo.addInvoice(invoice);

    if (response.statusCode == 200) {
      print("invoice added");
      amountC.clear();
      detailsC.clear();
      CustomSnackBar.showSuccessMessage(message: "تمت الإضافة بنجاح");

      // CustomToast.successToast("  تم ارسال الطلب الى العميل");
    } else {
      CustomSnackBar.showErrorMessage(message: "حدث خطأ أثناء العملية");
    }
    isLoading.value = false;
  }

  List<CustomerParticipantGetDto>? customerParticipantList;

  CustomerParticipantGetDto? selectedParticipant;

  Future<void> getCustoemrParticipantList(int customerId) async {
    isLoading.value = true;

    if (customerParticipantList == null) {
      Response response = await invoiceRepo.getCustomerParticipant(customerId);
      if (response.statusCode == 200) {
        customerParticipantList = [];
        // _interestSelectedList = [];
        response.body.forEach((category) {
          customerParticipantList!
              .add(CustomerParticipantGetDto.fromJson(category));
          // _interestSelectedList.add(false);
        });
        update();
      }
      isLoading.value = false;
      print("hi${customerParticipantList!.length}");

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }
}

class ItemAttributes {
  String name;
  String amount;
  String price;
  String total;

  ItemAttributes(
      {required this.name,
      required this.amount,
      required this.price,
      required this.total});

  Map<String, String> toMap() {
    return {'name': name, 'amount': amount, 'price': price, 'total': total};
  }
}
