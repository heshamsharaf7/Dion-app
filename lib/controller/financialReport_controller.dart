import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dionapplication/view/user/printing/financialReport.dart';

class FinancialReportController extends GetxController {
  Rx<DateTime?> comIdIssueDate = Rx<DateTime?>(null);
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: comIdIssueDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      comIdIssueDate.value = pickedDate;
    }
  }

  @override
  void onInit() {
    super.onInit();
    finacialReportPrint.init();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
