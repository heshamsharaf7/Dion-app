import 'package:dionapplication/controller/store_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:dionapplication/data/model/invoice/invoice_get_moedl.dart';
import 'package:get/get.dart';
import '../../../../util/fonts.dart';

class MyGridWidget extends StatelessWidget {
  var controller = Get.find<StoreDetailsController>();

  final List<InvoiceGetDto>? items;
  final String? userName;

  MyGridWidget({required this.items, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          // Wrap the DataTable in SingleChildScrollView for horizontal scrolling
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('م')),
                DataColumn(label: Text('السلعة')),
                DataColumn(label: Text('الكميه')),
                DataColumn(label: Text('السعر')),
                DataColumn(label: Text('الاجمالي')),
                DataColumn(label: Text('المشتري')),
              ],
              rows: items!.map((item) {
                return DataRow(cells: [
                  DataCell(Text('${item.id}')),
                  DataCell(Text('${item.statement}')),
                  DataCell(Text('${item.quantity}')),
                  DataCell(Text('${item.unitPrice}')),
                  DataCell(Text('${item.quantity * item.unitPrice}')),
                  DataCell(Text(
                      '${item.participantId == 0 ? userName : item.participantName}')),
                ]);
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 255, 140, 64),
                  ),
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'إجمالي الدين اليوم : ${controller.todayTotalDebt} ريال',
                        style: robotoMediumWhiteBold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(),
              // child: ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //   ),
              //   onPressed: () {
              //     // Action to take when the button is pressed
              //   },
              //   child: Text(
              //     'عرض',
              //     style: robotoMediumWhiteBold,
              //   ),
              // ),
            ),
          ],
        ),
      ],
    );
  }
}
