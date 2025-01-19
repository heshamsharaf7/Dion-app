import 'package:flutter/material.dart';
import '../../../../util/fonts.dart';
import '../../widgets/custom_input.dart';

class addCreditorsWidget extends StatelessWidget {
  final String title;
  final String inputLabel;
  final String inputHint;
  final String buttonText;
  final Function()? onPressed;
  final TextEditingController controller;

  const addCreditorsWidget({
    Key? key,
    required this.title,
    required this.inputLabel,
    required this.inputHint,
    required this.buttonText,
    required this.controller,
    this.onPressed,
  }) : super(key: key);

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
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          contentPadding: EdgeInsets.all(12.0),
          title: Text(title, style: robotoHuge),
          subtitle: Column(
            children: [
              CustomInput(
                controller: controller,
                label: inputLabel, requiredField: true,
                hint: inputHint,
                icno: Icon(Icons.abc),
              ),
          ],
          ),
        ),
      ),
    );
  }
}
