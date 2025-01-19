class StoreCustomersGetDto {
  int id;
  double accountCapacity;
  bool isLock;
  String enteredDate;
  bool payNotification;
  String cuName;
  String cuAddress;
  bool isAccepted;
  int userPhoneNo;
  int storeTypeId;
  int userId;
  int storeId;
  double totalDebt;
  StoreCustomersGetDto(
      {required this.id,
      required this.accountCapacity,
      required this.isLock,
      required this.enteredDate,
      required this.payNotification,
      required this.cuName,
      required this.cuAddress,
      required this.isAccepted,
      required this.storeTypeId,
      required this.userId,
      required this.storeId,
      required this.userPhoneNo,
      required this.totalDebt});

  factory StoreCustomersGetDto.fromJson(Map<String, dynamic> json) {
    return StoreCustomersGetDto(
        id: json['id'],
        accountCapacity:
            (json['accountCapacity'] as num).toDouble(), // Convert to double
        isLock: json['isLock'],
        enteredDate: json['enteredDate'],
        payNotification: json['payNotification'],
        cuName: json['cuName'],
        cuAddress: json['cuAddress'],
        isAccepted: json['isAccepted'],
        storeTypeId: json['storeTypeId'],
        userId: json['userId'],
        storeId: json['storeId'],
        userPhoneNo: json['userPhoneNo'],
        totalDebt:double.parse(json['totalDebt'].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountCapacity': accountCapacity,
      'isLock': isLock,
      'enteredDate': enteredDate,
      'payNotification': payNotification,
      'cuName': cuName,
      'cuAddress': cuAddress,
      'isAccepted': isAccepted,
      'storeTypeId': storeTypeId,
      'userId': userId,
      'storeId': storeId,
      'userPhoneNo': userPhoneNo
    };
  }
}
