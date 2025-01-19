class StoreCustomersAddDto {
  double accountCapacity;
  bool isLock;
  String enteredDate;
  bool payNotification;
  String cuName;
  String cuAddress;
  bool isAccepted;
  
  int storeTypeId;
  int userId;
  int storeId;

  StoreCustomersAddDto({
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
  });

  factory StoreCustomersAddDto.fromJson(Map<String, dynamic> json) {
    return StoreCustomersAddDto(
      accountCapacity: json['accountCapacity'],
      isLock: json['isLock'],
      enteredDate: json['enteredDate'],
      payNotification: json['payNotification'],
      cuName: json['cuName'],
      cuAddress: json['cuAddress'],
      isAccepted: json['isAccepted'],
      storeTypeId: json['storeTypeId'],
      userId: json['userId'],
      storeId: json['storeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}