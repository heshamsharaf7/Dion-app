import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  void showLoadingDialog(String message) {
    isLoading.value = true;
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void dismissLoadingDialog() {
    isLoading.value = false;
    Get.back();
  }
}