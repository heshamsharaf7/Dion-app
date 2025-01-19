import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/helper/transactions_utils.dart';
import 'package:dionapplication/view/merchant/pages/debt_details_screen.dart';
import 'package:dionapplication/view/user/pages/store_reports_screen.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreReportsController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  RxString fromDate = DateTime.now().toString().obs;

  RxString toDate = DateTime.now().toString().obs;

  StoreReportsController({required this.storeCustomersRepo});
  StoreGetModel? store;

  StoreCustomersGetDto? storeCustomer;
  RxDouble totalDebt = (0.0).obs;
  RxDouble totalCredit = (0.0).obs;

  List<InvoiceGetDto>? invoiceItems;

  RxBool showDateRange = false.obs;
  List<TransactionsGetModel>? transactions;
  List<InvoiceGetDto>? invoiceItemsByInvoiceId = [];

  RxBool isInvoiceReport = false.obs;
  double initialBalance = 0.0;

  // List<TransactionsGetModel>? transactionsReport;
  double calculateBalance(TransactionsGetModel transaction) {
    double balance = initialBalance;
    if (balance == 0.0) {
      balance += (transaction.debit! - transaction.credit!);
      // break;
    }
    // Loop through transactions to calculate the balance
    for (TransactionsGetModel tx in transactions!) {
      if (tx.id == transaction.id) {
        break;
      }

      balance += (tx.debit ?? 0) - (tx.credit ?? 0);
    }

    return balance;
  }

  changeReportType() {
    if (isInvoiceReport.value) {
      isInvoiceReport.value = false;
    } else {
      isInvoiceReport.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // CustomerFinacialReportPrint.init();
    getInitData();
  }

  void editInvoiceItem(InvoiceGetDto invoice, BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    descriptionController.text = invoice.statement;
    quantityController.text = invoice.quantity.toString();
    priceController.text = invoice.unitPrice.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl, // Ensure RTL support
          child: AlertDialog(
            title: const Text(
              'تعديل بيانات صنف',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Form(
              key: formKey, // Add a form for validation
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Statement Field
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'البيان',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البيان';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // Quantity Field
                  TextFormField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'الكمية',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الكمية';
                      }
                      if (int.tryParse(value) == null) {
                        return 'الرجاء إدخال رقم صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // Price Field
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'السعر',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال السعر';
                      }
                      if (double.tryParse(value) == null) {
                        return 'الرجاء إدخال رقم صحيح';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    InvoiceGetDto item = InvoiceGetDto(
                      id: invoice.id,
                      statement: descriptionController.text,
                      unitPrice: double.parse(priceController.text),
                      quantity: int.parse(quantityController.text),
                      invoiceId: invoice.invoiceId,
                      participantId: invoice.participantId,
                      participantName: invoice.participantName,
                      enteredDate: invoice.enteredDate,
                    );
                    await editItemFromInvoice(item); // Perform the save action
                    Navigator.of(context).pop(); // Close the dialog
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'حفظ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  editItemFromInvoice(InvoiceGetDto invoiceGetDto) async {
    Response response =
        await storeCustomersRepo.updateItemFromInvoice(invoiceGetDto);
    if (response.statusCode == 200) {
      transactions!.removeWhere((element) =>
          element.id == TransactionsGetModel.fromJson(response.body).id);
      transactions!.add(TransactionsGetModel.fromJson(response.body));

      var item = invoiceItems!
          .where(
            (element) => element.id == invoiceGetDto.id,
          )
          .first;
      invoiceItems!.remove(item);
      invoiceItems!.add(invoiceGetDto);
      CustomSnackBar.showSuccessMessage(message: "تمت التعديل بنجاح");

      update();
    } else {
      CustomSnackBar.showErrorMessage(message: "حدث خطأ أثناء العملية");
    }
  }

  getInitData() async {
    try {
      await getCustomerInfo();
      await getAllStoreTransactions();
      getDebt();
      getCredit();
      await getInvoiceItems();
      await getStoreInfo();
      update();
    } catch (e) {
      update();
    }
  }

  viewTransactionItems(TransactionsGetModel transactionsGetModel) {
    getInvoiceItemsByInvoiceId(transactionsGetModel);
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Center(child: Text('  بيانات العمليه  ')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                tableHeader(),
                GetBuilder<StoreReportsController>(
                  builder: (context) {
                    if (invoiceItemsByInvoiceId == []) {
                      return CircularProgressIndicator();
                    } else {
                      var controller = Get.find<StoreReportsController>();
                      return Column(
                        children: invoiceItemsByInvoiceId!.map((element) {
                          return storeReporttableRow(element, controller);
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getInvoiceItemsByInvoiceId(TransactionsGetModel transactionsGetModel) async {
    invoiceItemsByInvoiceId!.clear();
    Response response = await storeCustomersRepo
        .getInvoiceItems(transactionsGetModel.invoiceId!);
    if (response.statusCode == 200) {
      response.body.forEach((o) {
        invoiceItemsByInvoiceId!.add(InvoiceGetDto.fromJson(o));
      });
    }
    update();
  }

  getStoreInfo() async {
    // int storeId =
    //     Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeCustomersRepo.getStore(store!.id!);
    if (response.statusCode == 200) {
      store = (StoreGetModel.fromJson(response.body));
    } else {
      store = StoreGetModel();
    }
  }

  getAllStoreTransactions() async {
    // int storeId =
    //     Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeCustomersRepo
        .getAllStoreCustomerTransactions(storeCustomer!.id, store!.id!);
    if (response.statusCode == 200) {
      transactions = [];
      response.body.forEach((o) {
        transactions!.add(TransactionsGetModel.fromJson(o));
      });
      // transactionsReport = transactions;
    } else {
      transactions = [];
    }
  }

  getCustomerInfo() async {
    print(storeCustomer);

    storeCustomer = Get.arguments['storeCustomer'];
    print(storeCustomer);

    store = Get.arguments['store'];

    print(storeCustomer);
    print(store);
  }

  delteItemFromInvoice(InvoiceGetDto invoiceGetDto) async {
    Response response =
        await storeCustomersRepo.deleteItemFromInvoice(invoiceGetDto.id);
    if (response.statusCode == 200) {
      CustomSnackBar.showSuccessMessage(message: "تم الحذف بنجاح  ");

      transactions!.removeWhere((element) =>
          element.id == TransactionsGetModel.fromJson(response.body).id);
      if (TransactionsGetModel.fromJson(response.body).debit != 0 ||
          TransactionsGetModel.fromJson(response.body).credit != 0) {
        transactions!.add(TransactionsGetModel.fromJson(response.body));
      }

      invoiceItems!.remove(invoiceGetDto);
      update();
    }
  }

  deleteTransaction(TransactionsGetModel transactionsGetModel) async {
    Response response =
        await storeCustomersRepo.deleteTransaction(transactionsGetModel.id!);
    if (response.statusCode == 200) {
      CustomSnackBar.showSuccessMessage(message: "تم الحذف بنجاح  ");

      transactions!
          .removeWhere((element) => element.id == transactionsGetModel.id);
      response.body.forEach((o) {
        InvoiceGetDto i = invoiceItems!
            .where((element) => element.id == InvoiceGetDto.fromJson(o).id)
            .first;
        invoiceItems!.remove(i);
      });
      update();
    }
  }

  deleteItem(InvoiceGetDto invoiceGetDto) {
    Get.defaultDialog(
      title: "",
      contentPadding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      radius: 12.0,
      content: Column(
        children: [
          // Warning Icon
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 50,
          ),
          const SizedBox(height: 12.0),

          // Custom Dialog Title
          const Text(
            "حذف عنصر",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),

          // Middle Text Description
          const Text(
            "هل تأكيد حذف هذا العنصر؟",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // Confirm and Cancel Buttons
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Get.back(); // Close the dialog
          delteItemFromInvoice(invoiceGetDto);
        },
        icon: const Icon(Icons.delete, color: Colors.white),
        label: const Text(
          "حذف",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      cancel: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Get.back(); // Close the dialog
        },
        icon: const Icon(Icons.cancel, color: Colors.white),
        label: const Text(
          "الغاء",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
    );
  }

  deleteTransactionDialog(TransactionsGetModel transactionsGetModel) {
    Get.defaultDialog(
      title: "",
      contentPadding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      radius: 12.0,
      content: Column(
        children: [
          // Warning Icon
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.redAccent,
            size: 50,
          ),
          const SizedBox(height: 12.0),

          // Custom Dialog Title
          const Text(
            "حذف عنصر",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),

          // Middle Text Description
          const Text(
            "هل تأكيد حذف هذا العنصر؟",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // Confirm and Cancel Buttons
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Get.back(); // Close the dialog
          deleteTransaction(transactionsGetModel); // Perform delete action
        },
        icon: const Icon(Icons.delete, color: Colors.white),
        label: const Text(
          "حذف",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      cancel: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Get.back(); // Close the dialog
        },
        icon: const Icon(Icons.cancel, color: Colors.white),
        label: const Text(
          "الغاء",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
    );
  }

  getDebt() async {
    totalDebt.value = TransactionsUtils.calculateTotalDebt(transactions!);

    // Response response =
    //     await storeCustomersRepo.GetTotalDebtCustomer(storeCustomer!.id);
    // if (response.statusCode == 200) {
    //   totalDebt.value = double.parse(response.body.toString());

    //   //  else {
    //   //   ApiChecker.checkApi(response);
    //   // }
    // }
  }

// Functions to show the date pickers
  Future<void> selectFromDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.parse(fromDate.value),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != fromDate) {
      fromDate.value = picked.toString();
    }
  }

  Future<void> selectToDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.parse(toDate.toString()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != toDate) {
      toDate.value = picked.toString();
    }
  }

  getCredit() async {
    totalCredit.value = TransactionsUtils.calculateTotalCredit(transactions!);

    // Response response =
    //     await storeCustomersRepo.GetTotalCreditCustomer(storeCustomer!.id);
    // if (response.statusCode == 200) {
    //   totalCredit.value = double.parse(response.body.toString());

    //   //  else {
    //   //   ApiChecker.checkApi(response);
    //   // }
    // }
  }

  getInvoiceItems() async {
    Response response =
        await storeCustomersRepo.getCustomerInvoiceItems(storeCustomer!.id);
    if (response.statusCode == 200) {
      invoiceItems = [];
      response.body.forEach((o) {
        invoiceItems!.add(InvoiceGetDto.fromJson(o));
      });
      print("oooo${invoiceItems!.length}");
      update();
    } else if (response.statusCode == 404) {
      invoiceItems = [];
      update();
    }

    //  else {
    //   ApiChecker.checkApi(response);
    // }
  }

  void performSearch() async {
    invoiceItems = null;
    transactions = null;
    update();
    await getAllStoreTransactions();
    await getInvoiceItems();

    // Parse the selected dates
    DateTime? fromDate;
    DateTime? toDate;

    try {
      fromDate = DateTime.parse(this.fromDate.value);
      if (showDateRange.value) {
        toDate = DateTime.parse(this.toDate.value);
      }
    } catch (e) {
      print("Error parsing dates: $e");
      return;
    }

    // Validate the date range
    if (showDateRange.value && toDate != null && toDate.isBefore(fromDate)) {
      print("Error: 'To Date' cannot be before 'From Date'.");
      return;
    }

    // Filter the `invoiceItems` list based on date(s)
    List<InvoiceGetDto>? filteredInvoices = invoiceItems?.where((item) {
      DateTime itemDate = DateTime.parse(item.enteredDate);
      if (showDateRange.value && toDate != null) {
        // Between two dates (compare only year, month, and day)
        return _isSameOrAfter(itemDate, fromDate!) &&
            _isSameOrBefore(itemDate, toDate);
      } else {
        // Single date (compare only year, month, and day)
        return _isSameDay(itemDate, fromDate!);
      }
    }).toList();

    // Filter the `transactions` list based on date(s)
    List<TransactionsGetModel>? filteredTransactions =
        transactions?.where((transaction) {
      if (transaction.enteredDate == null) return false;
      DateTime transactionDate = DateTime.parse(transaction.enteredDate!);
      if (showDateRange.value && toDate != null) {
        // Between two dates (compare only year, month, and day)
        return _isSameOrAfter(transactionDate, fromDate!) &&
            _isSameOrBefore(transactionDate, toDate);
      } else {
        // Single date (compare only year, month, and day)
        return _isSameDay(transactionDate, fromDate!);
      }
    }).toList();

    invoiceItems = filteredInvoices;
    transactions = filteredTransactions;

    update();
  }

// Helper method to check if two dates are on the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

// Helper method to check if a date is the same as or after another date (ignoring time)
  bool _isSameOrAfter(DateTime date, DateTime compareTo) {
    return date.year > compareTo.year ||
        (date.year == compareTo.year && date.month > compareTo.month) ||
        (date.year == compareTo.year &&
            date.month == compareTo.month &&
            date.day >= compareTo.day);
  }

// Helper method to check if a date is the same as or before another date (ignoring time)
  bool _isSameOrBefore(DateTime date, DateTime compareTo) {
    return date.year < compareTo.year ||
        (date.year == compareTo.year && date.month < compareTo.month) ||
        (date.year == compareTo.year &&
            date.month == compareTo.month &&
            date.day <= compareTo.day);
  }
}
