import 'package:flutter/material.dart';
import '../../../../util/fonts.dart';

class AccountInfoCardWidget extends StatelessWidget {
  final String accountName;
  final String accountStatus;
  final String totalDebt;

  const AccountInfoCardWidget({
    Key? key,
    required this.accountName,
    required this.accountStatus,
    required this.totalDebt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
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
          title: Text(
            "اسم الحساب : $accountName",
            style: robotoMediumWhiteBold,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  "حالة الحساب : $accountStatus",
                  style: robotoMediumWhiteBold,
                ),
              ),
              FittedBox(
                child: Text(
                  "إجمالي الدين عليك : $totalDebt",
                  style: robotoMediumWhiteBold,
                ),
              ),
            ],
          ),
          trailing: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Icon(
              Icons.wallet,
              size: 32,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
