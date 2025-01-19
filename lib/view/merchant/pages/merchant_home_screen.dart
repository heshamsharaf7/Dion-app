import 'package:dionapplication/controller/merchant_home_controller.dart';
import 'package:dionapplication/util/alertExitApp.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/util/images.dart';
import 'package:dionapplication/view/widgets/home_slider.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantHomeScreen extends GetView<MerchantHomeController> {
  const MerchantHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: alertExitApp,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: "إدارة الديون"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: GetBuilder<MerchantHomeController>(
                      builder: (controller) => ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width:
                                    2), // Set the border color to white and width to 2
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors
                                .orange, // Set the background color to orange
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ), // Set the icon color to white
                            radius: 30,
                          ),
                        ),
                        title: controller.loadingInitData.isTrue ||
                                controller.currentStore == null
                            ? CircularProgressIndicator()
                            : Text(controller.currentStore!.name!,
                                style: robotoHugeWhite),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.loadingInitData.isTrue ||
                                        controller.currentStore == null
                                    ? CircularProgressIndicator()
                                    // : Text(controller.todayDebt.toString()
                                    : Text(
                                        "إجمالي ديون اليوم : ${controller.todayDebt.toString()}",
                                        style: robotoMediumWhite),
                                controller.loadingInitData.isTrue ||
                                        controller.currentStore == null
                                    ? CircularProgressIndicator()
                                    // : Text(controller.todayDebt.toString()
                                    : Text(
                                        "إجمالي الديون كامل : ${controller.totalDebt.toString()}",
                                        style: robotoMediumWhite),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.getinitData();
                                },
                                icon: Icon(Icons.refresh))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeSlider(
                    imagePaths: [
                      Images.banner4,
                      Images.banner5,
                    ],
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
                              "خدمات التاجر",
                              style: robotoHuge,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.CUSTOMERSMANAGEMENT);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColor.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.blue,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.people_sharp,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "إدارة العملاء",
                                                  style: robotoMediumWhiteBold,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColor.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // Get.find<SharedPreferences>()
                                            //     .clear();
                                            // Get.toNamed(Routes.CHOOSEACCOUNT);
                                            Get.toNamed(
                                                Routes.STOREFINREPORTSCREEN);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.blue,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .receipt_long_sharp,
                                                        size: 32,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "كشف الديون",
                                                        style:
                                                            robotoMediumWhiteBold,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          // Get.find<SharedPreferences>()
                          //     .clear();
                          // Get.toNamed(Routes.CHOOSEACCOUNT);
                          Get.toNamed(Routes.WALLETMANAGEMENT);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.wallet,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "اداره المحافظ الالكترونيه ",
                                      style: robotoMediumWhiteBold,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add the logout logic here
                Get.defaultDialog(
                  title: "تسجيل الخروج",
                  middleText: "هل تريد تسجيل الخروج من التطبيق؟",
                  textCancel: "إلغاء",
                  textConfirm: "تأكيد",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Perform the logout action, e.g., clear user session and navigate to login
                    Get.find<SharedPreferences>()
                        .setInt(AppConstants.CURRENT_STORE_ID, 0);
                    //set user loggined
                    Get.find<SharedPreferences>()
                        .setBool(AppConstants.MERCHANT_LOGINED, false);
                    Get.offAllNamed(Routes.CHOOSEACCOUNT);
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text(
                "تسجيل الخروج",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
