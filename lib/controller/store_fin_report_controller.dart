import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/store/store_get_moedl.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/data/repository/store_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/view/merchant/pages/store_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreFinReportController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;
  final StoreRepo storeRepo;

  RxString fromDate = DateTime.now().toString().obs;

  RxString toDate = DateTime.now().toString().obs;

  StoreFinReportController(
      {required this.storeCustomersRepo, required this.storeRepo});

  StoreCustomersGetDto? storeCustomer;

  RxBool showDateRange = false.obs;
  List<TransactionsGetModel>? transactions;
  List<InvoiceGetDto>? invoiceItemsByInvoiceId = [];
  List<TransactionsGetModel>? transactionsReport;
  StoreGetModel? store;

  @override
  void onInit() {
    super.onInit();
    getInitData();
  }

  getStoreInfo() async {
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeCustomersRepo.getStore(storeId);
    if (response.statusCode == 200) {
      store = (StoreGetModel.fromJson(response.body));
    } else {
      store = StoreGetModel();
    }
  }

  editInvoiceItem(InvoiceGetDto invoice, BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    descriptionController.text = invoice.statement;
    quantityController.text = invoice.quantity.toString();
    priceController.text = invoice.unitPrice.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  تعديل بيانات صنف'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'البيان'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'الكمية'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                InvoiceGetDto item = InvoiceGetDto(
                    id: invoice.id,
                    statement: descriptionController.text,
                    unitPrice: double.parse(priceController.text),
                    quantity: int.parse(quantityController.text),
                    invoiceId: invoice.invoiceId,
                    participantId: invoice.participantId,
                    participantName: invoice.participantName,
                    enteredDate: invoice.enteredDate);
                await editItemFromInvoice(item);
                Navigator.of(context).pop();
              },
              child: Text('حفظ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
          ],
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

      // var item = invoiceItems!
      //     .where(
      //       (element) => element.id == invoiceGetDto.id,
      //     )
      //     .first;
      // invoiceItems!.remove(item);
      // invoiceItems!.add(invoiceGetDto);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(" تم تعديل العنصر"),
      ));
      update();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(" فشل التعديل  "),
      ));
    }
  }

  getInitData() async {
    try {
      await getAllStoreTransactions();
      await getStoreInfo();
      update();
    } catch (e) {
      update();
    }
  }

  viewTransactionItems(TransactionsGetModel transactionsGetModel) async {
    getCustomerInfo(transactionsGetModel.customerId!);
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
                storeTableHeader(),
                GetBuilder<StoreFinReportController>(
                  builder: (context) {
                    if (invoiceItemsByInvoiceId == []) {
                      return CircularProgressIndicator();
                    } else {
                      var controller = Get.find<StoreFinReportController>();
                      return Column(
                        children: invoiceItemsByInvoiceId!.map((element) {
                          return storeTableRow(element, controller);
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
            // actions: <Widget>[
            //   ElevatedButton(
            //     onPressed: () async {
            //       InvoiceGetDto item = InvoiceGetDto(
            //           id: invoice.id,
            //           statement: descriptionController.text,
            //           unitPrice: double.parse(priceController.text),
            //           quantity: int.parse(quantityController.text),
            //           invoiceId: invoice.invoiceId,
            //           participantName: invoice.participantName,
            //           enteredDate: invoice.enteredDate);
            //       await editItemFromInvoice(item);
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('حفظ'),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('إلغاء'),
            //   ),
            // ],
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
      // transactions = [];
      response.body.forEach((o) {
        invoiceItemsByInvoiceId!.add(InvoiceGetDto.fromJson(o));
      });
    }
    update();
  }

  getCustomerInfo(int customerId) async {
    if (storeCustomer == null) {
      Response response =
          await storeCustomersRepo.getCustomerInfoById(customerId);
      print(response.statusCode);
      if (response.statusCode == 200) {
        storeCustomer = StoreCustomersGetDto.fromJson(response.body);
      }

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }

  void performSearch() async {
    transactions = null;
    update();
    await getAllStoreTransactions();

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

  double initialBalance = 0.0;

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

  getAllStoreTransactions() async {
    int storeId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_STORE_ID)!;
    Response response = await storeRepo.getAllStoreTransactions(storeId);
    if (response.statusCode == 200) {
      transactions = [];
      response.body.forEach((o) {
        transactions!.add(TransactionsGetModel.fromJson(o));
      });
      transactionsReport = transactions;
    } else {
      transactions = [];
    }
  }

  delteItemFromInvoice(InvoiceGetDto invoiceGetDto) async {
    Response response =
        await storeCustomersRepo.deleteItemFromInvoice(invoiceGetDto.id);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(" تم حذف العنصر"),
      ));
      transactions!.removeWhere((element) =>
          element.id == TransactionsGetModel.fromJson(response.body).id);
      transactions!.add(TransactionsGetModel.fromJson(response.body));

      // invoiceItems!.remove(invoiceGetDto);
      update();
    }
  }

  deleteTransaction(TransactionsGetModel transactionsGetModel) async {
    Response response =
        await storeCustomersRepo.deleteTransaction(transactionsGetModel.id!);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(" تم حذف القيد مع بياناته"),
      ));
      transactions!
          .removeWhere((element) => element.id == transactionsGetModel.id);
      // response.body.forEach((o) {
      //   InvoiceGetDto i = invoiceItems!
      //       .where((element) => element.id == InvoiceGetDto.fromJson(o).id)
      //       .first;
      //   invoiceItems!.remove(i);
      // });
      update();
    }
  }

  deleteItem(InvoiceGetDto invoiceGetDto) {
    Get.defaultDialog(
      title: "حذف عنصر ",
      middleText: "هل تأكيد حذف هذا العنصر؟",
      textConfirm: "حذف",
      confirmTextColor: Colors.red,
      onConfirm: () {
        Get.back();
        delteItemFromInvoice(invoiceGetDto);
      },
      textCancel: "الغاء",
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
  }

  deleteTransactionDialog(TransactionsGetModel transactionsGetModel) {
    Get.defaultDialog(
      title: "حذف عنصر ",
      middleText: "هل تأكيد حذف هذا العنصر؟",
      textConfirm: "حذف",
      confirmTextColor: Colors.red,
      onConfirm: () {
        Get.back();
        deleteTransaction(transactionsGetModel);
      },
      textCancel: "الغاء",
      onCancel: () {
        Get.back(); // Close the dialog
      },
    );
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
}
