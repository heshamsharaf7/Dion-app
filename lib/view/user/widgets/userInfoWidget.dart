import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const UserInfoWidget({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(
                leadingIcon,
                color: Colors.white,
                size: 40,
              ),
              radius: 30,
            ),
          ),
          title: Text(
            "أهلا $title",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "إجمالي الديون : $subtitle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
