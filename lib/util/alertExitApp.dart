
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import 'app_color.dart';
import 'fonts.dart';


Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "تسجيل الخروج!",
      titleStyle:const  TextStyle(color: AppColor.primaryColor , fontWeight: FontWeight.bold),
      middleText: "هل تريد تسجيل الخروج؟ ",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.redColor)),
            onPressed: () {
          
           Get.offAllNamed(Routes.CHOOSEACCOUNT);
            },
            child: Text("نعم", style: robotoMediumWhite,)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor)),
            onPressed: () {
              Get.back();
            },
            child: Text("لا", style: robotoMediumWhite,))
      ]);
  return Future.value(true);

}