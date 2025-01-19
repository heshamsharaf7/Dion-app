import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import '../../../../util/fonts.dart';

class PaymentWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final Function onTap;

  const PaymentWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.whiteColor,
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
            trailing: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
              ),
              child: Icon(iconData, size: 32, color: Colors.white),
            ),
            title: Text(title, style: robotoHuge),
            subtitle: Text(subtitle, style: robotoRegular),
          ),
        ),
      ),
    );
  }
}
