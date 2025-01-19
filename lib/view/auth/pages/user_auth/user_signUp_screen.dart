import 'package:dionapplication/controller/user_auth_controller.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserSignUpScreen extends GetView<UserAuthController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.blue, // Set icon color to blue
                          size:
                              30, // Set icon size to 30 (you can adjust this value as needed)
                        ),
                        title: Text(
                          'قم بادخال بياناتك',
                          style: TextStyle(
                            color: Colors.blue, // Set text color to blue
                            fontWeight: FontWeight.bold, // Set text to bold
                            fontSize:
                                20, // Set font size to 20 (you can adjust this value as needed)
                          ),
                        ),
                      ),
                    ),
                    CustomInput(
                      controller: controller.nameC,
                      label: '  الاسم',
                      hint: '',
                      requiredField: true,
                      icno: Icon(Icons.person),
                    ),
                    CustomInput(
                      controller: controller.phoneNoC,
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
                    ),
                    CustomInput(
                      controller: controller.addressC,
                      label: ' العنوان',
                      hint: '',
                      requiredField: true,
                      icno: Icon(Icons.location_on),
                    ),
                    CustomInput(
                        controller: controller.passwordC,
                        label: 'كلمة المرور',
                        hint: '',
                        icno: Icon(Icons.password),
                        requiredField: true,
                        obscureText: true),
                    SizedBox(
                      height: 20,
                    ),
       Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: 
                          Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                if (controller.isLoading.isFalse) {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.registerAccount();
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
                                    "تسجيل حساب عميل",
                                    style: robotoHugeWhite,
                                  ),
                                  if (controller.isLoading.isTrue)
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(Colors
                                                .white), // Set valueColor to white
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )),
                    )
                  ]),
            ),
          ),
        ));

  }
}
