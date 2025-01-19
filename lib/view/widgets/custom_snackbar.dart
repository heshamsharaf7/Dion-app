import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  // Method to show a colorful SnackBar with a success icon
  static void showSuccessMessage({required String message}) {
    final context = Get.context!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green, // Background color for success
        duration: const Duration(seconds: 3), // Duration to display
        behavior: SnackBarBehavior.floating, // Floating design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24.0, // Success icon
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add more methods for different types of SnackBars (error, warning, etc.)
  static void showErrorMessage({required String message}) {
    final context = Get.context!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red, // Background color for error
        duration: const Duration(seconds: 3), // Duration to display
        behavior: SnackBarBehavior.floating, // Floating design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
              size: 24.0, // Error icon
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
