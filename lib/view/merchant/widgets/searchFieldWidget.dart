import 'package:dionapplication/controller/customer_management_controller.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final CustomerManagementController controller;

  const SearchFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: TextField(
          controller: controller.searchC,
          decoration: InputDecoration(
            hintText: "ابحث عن  اسم العميل أو العنوان...",
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
