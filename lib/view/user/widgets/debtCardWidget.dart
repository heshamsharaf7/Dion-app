import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import '../../../../util/fonts.dart';

class DebtCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String debtAmount;
  final VoidCallback onTap;
  final Color backgroundColor;

  const DebtCardWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.debtAmount,
    required this.onTap,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(8.0), // Adjust the padding as needed
                child: Image.network(
                  icon,
                  fit:
                      BoxFit.contain, // Ensures the image scales proportionally
                ),
              ),
            ),
            title: Text(title, style: robotoHuge),
            subtitle: Text("إجمالي الدين $debtAmount", style: robotoMedium),
            trailing: Icon(
              Icons.arrow_back_ios_new_rounded,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
  }
}
