import 'package:dionapplication/controller/merchant_auth_controller.dart';
import 'package:dionapplication/data/model/store_type/store_type_model.dart';
import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get.dart';

class MerchantSignUpScreen extends GetView<MerchantAuthController> {
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
                    Obx(() => controller.errorMessage.value
                        ? Text(controller.errorMessageContetnt!)
                        : SizedBox()),
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
                      label: '(لتسجيل الحساب )  رقم الهاتف',
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
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.blue, // Set icon color to blue
                          size:
                              30, // Set icon size to 30 (you can adjust this value as needed)
                        ),
                        title: Text(
                          'قم بادخال بيانات متجرك',
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
                      controller: controller.storeNameC,
                      label: ' اسم متجرك',
                      hint: '',
                      requiredField: true,
                      icno: Icon(Icons.store),
                    ),
                    CustomInput(
                      controller: controller.storePhoneC,
                      label: '  ( عرض للعملاء فقط ( رقم هاتف المتجر ',
                      hint: '',
                      requiredField: true,
                      keyboardType: TextInputType.number,
                      icno: Icon(Icons.store),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<MerchantAuthController>(
                            builder: (c) =>
                                DropdownButtonFormField<StoreTypeModel>(
                              padding: EdgeInsets.symmetric(vertical: 0.2),
                              // value: controller.storeTypeList != null? controller.storeTypeList![0].name:"",
                              items: controller.storeTypeList != null
                                  ? controller.storeTypeList!
                                      .map((StoreTypeModel storeType) {
                                      return DropdownMenuItem<StoreTypeModel>(
                                        value: storeType,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(storeType.name!),
                                              SizedBox(
                                                width:
                                                    24, // Adjust the width as needed
                                                height:
                                                    24, // Adjust the height as needed
                                                child: Image.network(
                                                  storeType.iconPath!,
                                                  fit: BoxFit
                                                      .cover, // Adjust how the image fits within the box
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      DropdownMenuItem<StoreTypeModel>(
                                        value: null,
                                        child: Text(
                                            'Loading...'), // Display loading message while data is being fetched
                                      )
                                    ],
                              onChanged: (StoreTypeModel? newValue) {
                                if (newValue != null) {
                                  controller.selectedStoreType = newValue;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'نوع المتجر',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'يرجى تحديد نوع المتجر';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Obx(
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
                                    "تسجيل حساب متجر",
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
