import 'package:flutter/material.dart';
import '../../../../util/app_color.dart';
import '../../../../util/fonts.dart';

class CreditorsListWidget extends StatelessWidget {
  final String personName;

  const CreditorsListWidget({
    Key? key,
    required this.personName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
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
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(personName, style: robotoHuge),
          subtitle: SizedBox(),
        ),
      ),
    );
  }
}
