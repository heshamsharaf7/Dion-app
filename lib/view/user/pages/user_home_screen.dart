import 'package:dionapplication/controller/user_home_controller.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/images.dart';
import 'package:dionapplication/view/user/widgets/debtCardWidget.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../util/alertExitApp.dart';
import '../../../../routes/app_pages.dart';
import '../../../../util/app_color.dart';
import '../../widgets/home_slider.dart';
import '../widgets/userInfoWidget.dart';

class UserHomeScreen extends GetView<UserHomeController> {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: alertExitApp,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: 'إدارة الديون'),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<UserHomeController>(
                        builder: (controller) => UserInfoWidget(
                          leadingIcon: Icons.person,
                          title: controller.user == null
                              ? ".........."
                              : ("${controller.user!.userName.toString()} (${controller.user!.phoneNo.toString()})"),
                          subtitle: "114,000",
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.STOREORDERCREEN);
                      },
                      child: Icon(Icons.list),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeSlider(
                  imagePaths: [
                    Images.banner1,
                    Images.banner2,
                    Images.banner3,
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: Colors.grey[200],
              //   ),
              //   padding: EdgeInsets.all(20.0),
              //   width: 200.0,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Icon(Icons.shopping_cart, size: 50.0, color: Colors.black),
              //       SizedBox(height: 10.0),
              //       Text(
              //         'طلبات المتاجر',
              //         style: TextStyle(fontSize: 24.0, color: Colors.black),
              //       ),
              //     ],
              //   ),
              // ),

              // DebtCardWidget(
              //   icon: Icons.money_off_csred_rounded,
              //   title: "الطلبات",
              //   debtAmount: "28,000",
              //   onTap: () {
              //     Get.toNamed(Routes.STOREORDERCREEN);
              //   },
              //   backgroundColor: AppColor.cardOrangeColor,
              // ),
              Expanded(
                child: GetBuilder<UserHomeController>(builder: (controller) {
                  return controller.storeTypeList == null
                      ? Center(child: CircularProgressIndicator())
                      : controller.storeTypeList!.isEmpty
                          ? Center(
                              child: Text("لا توجد متاجر انت مشترك فيها"),
                            )
                          : ListView.builder(
                              itemCount: controller.storeTypeList!.length,
                              itemBuilder: (context, index) {
                                final storeType =
                                    controller.storeTypeList![index];
                                return DebtCardWidget(
                                  icon: storeType.iconPath!,
                                  title: storeType.name!,
                                  debtAmount: "28,000",
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.STORESLIST,
                                      arguments: {'storeType': storeType},
                                    );
                                  },
                                  backgroundColor: AppColor.cardOrangeColor,
                                );
                              },
                            );
                }),
              ),
            ],
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
                        .setInt(AppConstants.CURRENT_USER_ID, 0);
                    //set user loggined
                    Get.find<SharedPreferences>()
                        .setBool(AppConstants.USER_LOGINED, false);
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
