import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/manage_creditors_controller.dart';
import 'package:dionapplication/util/images.dart';

class ChooseReportScreen extends GetView<ManageCreditorsController> {
  const ChooseReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: CustomAppBar(title: 'التقارير'),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Images.reports),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    "إختر نوع التقرير",
                    style: robotoHuge,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.FINANCIALREPORTSCREEN);
                      },
                      child: Text(
                        'تقارير مالية',
                        style: robotoMediumWhiteBold,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'تقارير تفصيلية',
                        style: robotoMediumWhiteBold,
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
          )),
    );
  }
}
