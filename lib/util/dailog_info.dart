import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService extends GetxService {
  static void showInfoDialog(String content) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.error, size: 48, color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
