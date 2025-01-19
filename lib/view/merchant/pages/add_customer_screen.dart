import 'package:dionapplication/controller/add_customer_controller.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddCustomerScreen extends GetView<AddCustomerController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: CustomAppBar(title: 'إضافة عميل'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.customerHasAccount.value,
                              onChanged: (value) {
                                controller.customerHasAccount.value = value!;
                              },
                            ),
                          ),
                          Text(
                            'هل يمتلك حساب في منصه ديون',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      CustomInput(
                        controller: controller.nameC,
                        label: 'الاسم*',
                        hint: '',
                        requiredField: true,
                        icno: Icon(Icons.person),
                      ),
                      Obx(() => controller.customerHasAccount.value == true
                          ? CustomInput(
                              controller: controller.phoneC,
                              label: ' رقم الهاتف',
                              keyboardType: TextInputType.number,
                              hint: '',
                              requiredField: true,
                              icno: Icon(Icons.phone),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يرجى إدخال رقم الهاتف';
                                }
                                if (value.length != 9) {
                                  return 'يجب أن يكون رقم الهاتف مكون من 9 أرقام';
                                }
                                if (!['71', '77', '70', '73', '78']
                                    .contains(value.substring(0, 2))) {
                                  return 'يجب أن يبدأ رقم الهاتف بـ 71, 77, 70, 73, أو 78';
                                }
                                if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                  return 'يجب أن يحتوي رقم الهاتف على أرقام فقط';
                                }
                                return null;
                              },
                            )
                          : Container()),
                      CustomInput(
                        controller: controller.AddressC,
                        label: ' العنوان ',
                        hint: '',
                        requiredField: false,
                        icno: Icon(Icons.location_on),
                      ),
                      CustomInput(
                        controller: controller.accountCapacityC,
                        label: ' الدين المسموح *',
                        hint: '',

                                                      keyboardType: TextInputType.number,

                        requiredField: true,
                        icno: Icon(Icons.payments_rounded),
                      ),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (controller.isLoading.isFalse) {
                              if (controller.formKey.currentState!.validate()) {
                                controller.addCustomer();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "اضافه عميل",
                                style: robotoHugeWhite,
                              ),
                              if (controller.isLoading.isTrue)
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors
                                            .white), // Set valueColor to white
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
