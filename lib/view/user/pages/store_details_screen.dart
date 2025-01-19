import 'package:dionapplication/controller/store_details_controller.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../routes/app_pages.dart';
import '../../../../util/app_color.dart';
import '../widgets/MyGridWidget.dart';
import '../widgets/accountInfoCardWidget.dart';
import '../widgets/paymentCardWidget.dart';
import '../widgets/serviceItemWidget.dart';

class StoresDetailsScreen extends GetView<StoreDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: GetBuilder<StoreDetailsController>(
              builder: (controller) => controller.store == null
                  ? CustomAppBar(title: ".............")
                  : CustomAppBar(title: controller.store!.name.toString()),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<StoreDetailsController>(
                    builder: (controller) => controller.storeCustomer == null
                        ? Center(child: CircularProgressIndicator())
                        : AccountInfoCardWidget(
                            accountName: controller.user!.userName!.toString(),
                            accountStatus: controller.storeCustomer!.isLock
                                ? "موقف"
                                : "نشط",
                            totalDebt:
                                controller.storeCustomer!.totalDebt.toString(),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "خدمات المستخدم",
                                style: robotoHuge,
                              ),
                              Row(
                                children: [
                                  ServiceItemWidget(
                                    iconData: Icons.manage_accounts_rounded,
                                    title: 'صلاحيات',
                                    onTap: () {
                                      Get.toNamed(Routes.MANAGECREDITORS);
                                    },
                                  ),
                                  ServiceItemWidget(
                                    iconData: Icons.view_list_rounded,
                                    title: 'تقارير',
                                    onTap: () {
                                      // Get.toNamed(Routes.CHOOSEREPORTSCREEN);

                                      Get.toNamed(
                                        Routes.STOREREPORTSSCREEN,
                                        arguments: {
                                          'storeCustomer':
                                              controller.storeCustomer,
                                          'store': controller.store,
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  PaymentWidget(
                    iconData: Icons.payments_rounded,
                    title: 'سدد ديونك',
                    subtitle:
                        'عزيزي المشترك يمكنك إختيار المحفظة الالكترونية والتسديد مباشرة من التطبيق',
                    onTap: () {
                      Get.toNamed(Routes.EPAYMENT);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<StoreDetailsController>(
                            builder: (controller) {
                              if (controller.invoiceItems == null) {
                                return CircularProgressIndicator();
                              } else if (controller.invoiceItems!.isEmpty) {
                                return Center(
                                  child: Text("لا توجد ديون "),
                                );
                              } else {
                                return MyGridWidget(
                                    userName: controller.user!.userName,
                                    items: controller.invoiceItems);
                              }
                            },
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
