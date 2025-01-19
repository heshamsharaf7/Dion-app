import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import '../../../../util/fonts.dart';

class ServiceItemWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  const ServiceItemWidget(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: Icon(iconData, size: 32, color: Colors.white),
                  ),
                ),
                Text(title, style: robotoMediumBold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
