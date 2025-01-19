class StoreWalletsAddModel {
  String? accountNo;
  String? details;
  String? enteredDate;
  int? storeId;
  int? walletId;

  StoreWalletsAddModel({
    this.accountNo,
    this.details,
    this.enteredDate,
    this.storeId,
    this.walletId,
  });

  factory StoreWalletsAddModel.fromJson(Map<String, dynamic> json) =>
      StoreWalletsAddModel(
        accountNo: json['accountNo'],
        details: json['details'],
        enteredDate: json['enteredDate'],
        storeId: json['storeId'],
        walletId: json['walletId'],
      );

  Map<String, dynamic> toJson() => {
        'accountNo': accountNo,
        'details': details,
        'enteredDate': enteredDate,
        'storeId': storeId,
        'walletId': walletId,
      };
}
