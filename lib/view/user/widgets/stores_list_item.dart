import 'package:dionapplication/util/app_color.dart';
import 'package:flutter/material.dart';
import '../../../../util/fonts.dart';

class StoreListItem extends StatelessWidget {
  final String storeName;
  final IconData iconData;

  const StoreListItem({
    Key? key,
    required this.storeName,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [AppColor.cardOrangeColor, Colors.orange.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(12.0),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
              ),
              child: Icon(
                iconData,
                size: 32,
                color: AppColor.cardOrangeColor,
              ),
            ),
            title: Text(
              storeName,
              style: robotoHuge.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
