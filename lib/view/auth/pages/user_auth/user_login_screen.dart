import 'package:dionapplication/controller/user_auth_controller.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/util/images.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginScreen extends GetView<UserAuthController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logoTransparent,
              scale: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  contentPadding: EdgeInsets.all(12.0),
                  title: Center(
                    child: Text("ادخل بياناتك لتسجيل الدخول", style: robotoHuge),
                  ),
                  subtitle: Column(
                    children: [
                      CustomInput(
                        icno: Icon(Icons.phone),
                        controller: controller.loginPhoneNoC,
                        label: "رقم الهاتف",
                        requiredField: true,
                        hint: "",
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomInput(
                                controller: controller.loginPasswordC,
                                icno: Icon(Icons.password),
                                label: 'كلمة المرور',
                                requiredField: true,
                                hint: '',
                                obscureText: true),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.fingerprint_rounded,
                                size: 40,
                              ))
                        ],
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
                                  if (controller.loginFormKey.currentState!
                                      .validate()) {
                                    controller.login();
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
                                    "دخول  ",
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
                                  ),
                      
                          //  ElevatedButton(
                          //   onPressed: () {
                          //     // Get.offAllNamed(Routes.CHOOSEACCOUNT);
                          //     Get.toNamed(Routes.MERCHANTHOME);
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors
                          //         .blue, // Change this to your desired button color
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(
                          //           10.0), // Adjust the radius as needed
                          //     ),
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 30, vertical: 10),
                          //   ),
                          //   child: Text(
                          //     "دخول",
                          //     style: robotoHugeWhite,
                          //   ),
                          // ),
                       
                       
                       
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
