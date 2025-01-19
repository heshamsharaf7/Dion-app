class StoreWalletsGetModel {
  int? id;
  String? accountNo;
  String? details;
  String? enteredDate;
  int? storeId;
  int? walletId;
  String? iconPath;

  StoreWalletsGetModel({
    this.id,
    this.accountNo,
    this.details,
    this.enteredDate,
    this.storeId,
    this.walletId,
    this.iconPath,
  });

  factory StoreWalletsGetModel.fromJson(Map<String, dynamic> json) =>
      StoreWalletsGetModel(
        id: json['id'],
        accountNo: json['accountNo'],
        details: json['details'],
        enteredDate: json['enteredDate'],
        storeId: json['storeId'],
        walletId: json['walletId'],
        iconPath: json['iconPath'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'accountNo': accountNo,
        'details': details,
        'enteredDate': enteredDate,
        'storeId': storeId,
        'walletId': walletId,
        'iconPath': iconPath,
      };
}


