import 'package:dionapplication/controller/store_reports_controller.dart';
import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:dionapplication/data/model/transactions/transaction_get_moedl.dart';
import 'package:dionapplication/view/merchant/printing/customer_financial_report.dart';
import 'package:dionapplication/view/merchant/printing/customer_invoice_report.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as dateP;

class StoreReportScreen extends GetView<StoreReportsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "تقرير  "),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getInitData();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                // Customer Information Card
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade100,
                        Colors.orange.shade200,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 28, color: Colors.black),
                          const SizedBox(width: 12),
                          Text(
                            controller.storeCustomer!.cuName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(() => _infoColumn(
                              "الإجمالي",
                              controller.totalDebt.value.toString(),
                              Colors.orange.shade600)),
                          Obx(() => _infoColumn(
                              "مسلم",
                              controller.totalCredit.value.toString(),
                              Colors.red.shade600)),
                          Obx(
                            () => _infoColumn(
                                "المتبقي",
                                (controller.totalDebt.value -
                                        controller.totalCredit.value)
                                    .toString(),
                                Colors.green.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Search Section
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
                              fontSize: 18,
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
                                'بحث بين فترة',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      (controller.showDateRange.value)
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectFromDate();
                                    },
                                    child: _datePicker(
                                        "من", controller.fromDate.value),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectToDate();
                                    },
                                    child: _datePicker(
                                        "إلى", controller.toDate.value),
                                  ),
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.selectFromDate();
                              },
                              child: _datePicker(
                                  "تاريخ", controller.fromDate.value),
                            ),
                      SizedBox(height: 16),
                      // Search Button
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors
                              .transparent, // Make the material background transparent
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                12), // Match the border radius
                            onTap: () {
                              controller.performSearch();
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 28),
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
                                    color:
                                        Colors.blue.shade300.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: Offset(0, 6),
                                  ),
                                  BoxShadow(
                                    color:
                                        Colors.blue.shade900.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, -6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.search,
                                      color: Colors.white, size: 20),
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
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Transaction Table
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Obx(() => controller.isInvoiceReport.value == true
                      ? Column(
                          children: [
                            storeReporttableHeader(),
                            GetBuilder<StoreReportsController>(
                              builder: (context) {
                                if (controller.invoiceItems == null) {
                                  return CircularProgressIndicator();
                                } else if (controller.invoiceItems!.isEmpty) {
                                  return Text("لا توجد بيانات");
                                } else {
                                  return Column(
                                    children:
                                        controller.invoiceItems!.map((element) {
                                      return storeReporttableRow(
                                          element, controller);
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _storeReporttableHeaderForTransaction(),
                            GetBuilder<StoreReportsController>(
                              builder: (context) {
                                if (controller.transactions == null) {
                                  return CircularProgressIndicator();
                                } else if (controller.transactions!.isEmpty) {
                                  return Text("لا توجد بيانات");
                                } else {
                                  return Column(
                                    children:
                                        controller.transactions!.map((element) {
                                      return _storeReporttableRowForTransaction(
                                          element, controller);
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                ),
                SizedBox(height: 25),
                // Bottom Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeReportType();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade600,
                              Colors.blue.shade300
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => controller.isInvoiceReport.value
                              ? Text(
                                  'تقارير مالية',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  'تقارير تفصيلية',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add functionality for PDF printing here

                        if (controller.isInvoiceReport.value) {
                          CustomerInvoiceReportPrint(
                                  customer: controller.storeCustomer,
                                  invoiceItems: controller.invoiceItems,
                                  store: controller.store,
                                  fromDate: DateTime.parse(controller
                                      .transactions!.first.enteredDate
                                      .toString()),
                                  toDate: DateTime.parse(controller
                                      .transactions!.last.enteredDate
                                      .toString()))
                              .createPdf();
                        } else {
                          CustomerFinacialReportPrint(
                                  customer: controller.storeCustomer,
                                  transactions: controller.transactions,
                                  store: controller.store,
                                  fromDate: DateTime.parse(controller
                                      .transactions!.first.enteredDate
                                      .toString()),
                                  toDate: DateTime.parse(controller
                                      .transactions!.last.enteredDate
                                      .toString()))
                              .createPdf();
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'طباعة PDF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Date picker container
  Widget _datePicker(String label, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          Icon(Icons.calendar_today, color: Colors.orange),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Text(
            dateP.DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Other widget helpers remain unchanged...
}

Widget _infoColumn(String title, String value, Color color) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  );
}

// Table Header
Widget storeReporttableHeader() {
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
        // Expanded(
        //     child: Text("إجراء",
        //         textAlign: TextAlign.center, style: _tableHeaderStyle())),
      ],
    ),
  );
}

// Table Header FOR TRANSACTIONS
Widget _storeReporttableHeaderForTransaction() {
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
        // Expanded(
        //     child: Text("إجراء",
        //         textAlign: TextAlign.center, style: _tableHeaderStyle())),
      ],
    ),
  );
}

// Table Row
Widget storeReporttableRow(
    InvoiceGetDto invoiceGetDto, StoreReportsController controller) {
  final formattedDate = dateP.DateFormat('dd/MM/yy HH:mm')
      .format(DateTime.parse(invoiceGetDto.enteredDate));

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(formattedDate, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(invoiceGetDto.statement, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 1,
          child: Text(
            (invoiceGetDto.quantity * invoiceGetDto.unitPrice).toString(),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            invoiceGetDto.participantName == "0"
                ? controller.storeCustomer!.cuName
                : invoiceGetDto.participantName,
            textAlign: TextAlign.center,
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: PopupMenuButton<int>(
        //     onSelected: (int value) {
        //       if (value == 0) {
        //         controller.editInvoiceItem(invoiceGetDto, Get.context!);
        //       } else if (value == 1) {
        //         controller.deleteItem(invoiceGetDto);
        //       }
        //     },
        //     itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        //       const PopupMenuItem<int>(
        //         value: 0,
        //         child: Text('تعديل'),
        //       ),
        //       const PopupMenuItem<int>(
        //         value: 1,
        //         child: Text('حذف'),
        //       ),
        //     ],
        //     child: Center(
        //         child: Text('..',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(color: Colors.blue))),
        //   ),
        // ),
      ],
    ),
  );
}

// Table Row
Widget _storeReporttableRowForTransaction(
    TransactionsGetModel transaction, StoreReportsController controller) {
  final formattedDate = dateP.DateFormat('dd/MM/yy HH:mm')
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
