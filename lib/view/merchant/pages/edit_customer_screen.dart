import 'package:dionapplication/controller/edit_customer_controller.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EditCustomerScreen extends GetView<EditCustomerController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("تعديل عميل", style: robotoHugeWhite),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.wallet, color: Colors.white),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInput(
                    controller: controller.nameC,
                    label: 'الاسم*',
                    hint: '',
                    requiredField: true,
                    icno: Icon(Icons.person),
                  ),
                  GetBuilder<EditCustomerController>(builder: (context) {
                    return controller.phoneC.text == "0"
                        ? Container()
                        : CustomInput(
                            controller: controller.phoneC,
                            label: 'رقم الهاتف',
                            hint: '',
                            disabled: true,
                            requiredField: true,
                            icno: Icon(Icons.phone),
                          );
                  }),
                  CustomInput(
                    controller: controller.addressC,
                    label: 'العنوان*',
                    hint: '',
                    requiredField: true,
                    icno: Icon(Icons.location_city_outlined),
                  ),
                  CustomInput(
                    controller: controller.accountCapacityC,
                    label: 'سقف الحساب*',
                    hint: '',
                    requiredField: true,
                    icno: Icon(Icons.money),
                  ),
                  // Switch buttons with Obx
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Text(
                                controller.accountLock.value
                                    ? "حاله الحساب (مقفل) "
                                    : "حاله الحساب (نشط) ",
                                style: robotoHuge,
                              ),
                            ),
                          ),
                          Obx(() => Switch(
                                activeColor: Colors.blue,
                                value: controller.accountLock.value,
                                onChanged: (value) {
                                  controller.changeaccountLock(value);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Text(
                                controller.payNotification.value
                                    ? "ارسال اشعار دين  (نشط) "
                                    : "ارسال اشعار دين  (مقفل) ",
                                style: robotoHuge,
                              ),
                            ),
                          ),
                          Obx(() => Switch(
                                activeColor: Colors.blue,
                                value: controller.payNotification.value,
                                onChanged: (value) {
                                  controller.changePayNotificationk(value);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<EditCustomerController>(
                    builder: (controller) => controller.phoneC.text == "0"
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "هل تريد ربط الحساب مع العميل لضمان تحديث البيانات بينك وبين العميل",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "ربط",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight
                                        .bold, // Set the font weight to bold
                                  ),
                                ),
                                onPressed: () {
                                  // Add your onPressed logic here
                                  controller.connectUser();
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          if (controller.formKey.currentState!.validate()) {
                            controller.updateCustomer();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تعديل بيانات عميل",
                            style: robotoHugeWhite,
                          ),
                          if (controller.isLoading.isTrue)
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white), // Set valueColor to white
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
