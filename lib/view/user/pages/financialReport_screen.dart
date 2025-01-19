import 'package:dionapplication/controller/financialReport_controller.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/util/images.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dionapplication/view/user/printing/financialReport.dart';

class FinancialReportScreen extends GetView<FinancialReportController> {
  TextEditingController comIdIssueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'تقرير مالي'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Image.asset(Images.calendar),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  "حدد التاريخ",
                  style: robotoHuge,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: Text(
                        "من",
                        style: robotoHuge,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.comIdIssueDate.value ??
                                DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            controller.comIdIssueDate.value = pickedDate;
                            comIdIssueDateController.text =
                                '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          }
                        },
                        child: Obx(
                          () => CustomInput(
                            controller: comIdIssueDateController,
                            icno: Icon(Icons.abc),
                             requiredField: true,
                            label: '',
                            hint: controller.comIdIssueDate.value != null
                                ? '${controller.comIdIssueDate.value!.day}/${controller.comIdIssueDate.value!.month}/${controller.comIdIssueDate.value!.year}'
                                : '',
                            disabled: true,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 32,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: Text(
                        "إلى",
                        style: robotoHuge,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.comIdIssueDate.value ??
                                DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            controller.comIdIssueDate.value = pickedDate;
                            comIdIssueDateController.text =
                                '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          }
                        },
                        child: Obx(() => CustomInput(
                          icno: Icon(Icons.abc),
                              controller: comIdIssueDateController, requiredField: true,
                              label: '',
                              hint: controller.comIdIssueDate.value != null
                                  ? '${controller.comIdIssueDate.value!.day}/${controller.comIdIssueDate.value!.month}/${controller.comIdIssueDate.value!.year}'
                                  : '',
                              disabled: true,
                            )),
                      ),
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 32,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      finacialReportPrint.createPdf();
                    },
                    child: Text(
                      'طباعة',
                      style: robotoHugeWhite,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
