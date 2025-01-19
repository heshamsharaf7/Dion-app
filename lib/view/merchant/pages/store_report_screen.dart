import 'package:dionapplication/controller/store_fin_report_controller.dart';
import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/view/merchant/printing/store_financial_report.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date;

class StoreFinReportScreen extends GetView<StoreFinReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "تقارير المتجر "),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "إبحث بيان الدين بالتاريخ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: controller.showDateRange.value,
                                onChanged: (value) {
                                  controller.showDateRange.value = value!;
                                },
                              ),
                              Text(
                                'بحث بين فتره',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      (controller.showDateRange.value)
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectFromDate();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              color: Colors.orange),
                                          SizedBox(width: 8),
                                          Text(
                                            " من ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            date.DateFormat('yyyy-MM-dd')
                                                .format(DateTime.parse(
                                                    controller.fromDate.value)),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectToDate();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              color: Colors.orange),
                                          SizedBox(width: 8),
                                          Text(
                                            "الى ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            date.DateFormat('yyyy-MM-dd')
                                                .format(DateTime.parse(
                                                    controller.toDate.value)),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.selectFromDate();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 5,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today,
                                                color: Colors.orange),
                                            SizedBox(width: 8),
                                            Text(
                                              "  تاريخ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              date.DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.parse(
                                                      controller
                                                          .fromDate.value)),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors
                        .transparent, // Make the material background transparent
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(12), // Match the border radius
                      onTap: () {
                        controller.performSearch();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade300.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.blue.shade900.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, -6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'بحث',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                // Transaction Table
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _storeTableHeaderForTransaction(),
                      GetBuilder<StoreFinReportController>(
                        builder: (context) {
                          if (controller.transactions == null) {
                            return CircularProgressIndicator();
                          } else if (controller.transactions!.isEmpty) {
                            return Text("لاتوجد بيانات");
                          } else {
                            return Column(
                              children: controller.transactions!.map((element) {
                                return storeTableRowForTransaction(
                                    element, controller);
                              }).toList(),
                            );
                          }
                        },
                      ),
                      // _tableRow("2", "سكر", "2500", "صالح شرف"),
                      // _tableRow("3", "ماء صنعان", "3000", "عدنان شرف"),
                      // _tableRow("4", "بيض", "500", "هشام شرف"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    StoreFinacialReportPrint(
                            store: controller.store,
                            transactions: controller.transactions,
                            fromDate: DateTime.parse(controller
                                .transactions!.first.enteredDate
                                .toString()),
                            toDate: DateTime.parse(controller
                                .transactions!.last.enteredDate
                                .toString()))
                        .createPdf();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'طباعه pdf',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Info Column Widget for the Customer Info Section
}

// Table Header FOR TRANSACTIONS
Widget _storeTableHeaderForTransaction() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    color: Colors.grey.shade200,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text("التاريخ",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("العميل",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("البيان",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("عليه/مدين",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("له/دائن",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("الرصيد",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("إجراء",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
      ],
    ),
  );
}

// Table Row
Widget storeTableRowForTransaction(
    TransactionsGetModel transaction, StoreFinReportController controller) {
  final formattedDate = date.DateFormat('dd/MM/yy HH:mm')
      .format(DateTime.parse(transaction.enteredDate.toString()));

  // Calculate the balance based on previous balance and transaction amount
  double balance = controller.calculateBalance(transaction);

  return Container(
    // padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(formattedDate, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(transaction.customerName!, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(transaction.statement!, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 1,
          child:
              Text(transaction.debit!.toString(), textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child:
              Text(transaction.credit!.toString(), textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(balance.toString(), textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 1,
          child: PopupMenuButton<int>(
            onSelected: (int value) {
              if (value == 0) {
                controller.viewTransactionItems(transaction);
              } else if (value == 1) {
                controller.deleteTransactionDialog(transaction);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('عرض الفاتورة '),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(' حذف العمليه'),
              ),
            ],
            child: Center(
                child: Text('..',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue))),
          ),
        ),
      ],
    ),
  );
}

// Table Header Style
TextStyle _tableHeaderStyle() {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// Table Header
Widget storeTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    color: Colors.grey.shade200,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text("التاريخ",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("السلعة",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("السعر",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("المشتري",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
        Expanded(
            child: Text("إجراء",
                textAlign: TextAlign.center, style: _tableHeaderStyle())),
      ],
    ),
  );
}

// Table Row
Widget storeTableRow(
    InvoiceGetDto invoiceGetDto, StoreFinReportController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(invoiceGetDto.enteredDate, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(invoiceGetDto.statement, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 1,
          child: Text(
              (invoiceGetDto.quantity * invoiceGetDto.unitPrice).toString(),
              textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(
              invoiceGetDto.participantName == "0"
                  ? controller.storeCustomer!.cuName
                  : invoiceGetDto.participantName,
              textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.editInvoiceItem(invoiceGetDto, Get.context!);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                  onTap: () => controller.deleteItem(invoiceGetDto),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ],
    ),
  );
}
