class StoreAddModel {
  int? id;
  String? userName;
  String? enteredDate;
  int? userType;
  int? phoneNo;
  String? userAddress;
  String? userPassword;
  String? storeName;
  double? latitude;
  double? longitude;
  bool? storeVerified;
  int? storeTypeId;
  int? storePhoneNo;

  StoreAddModel(
      {this.id,
      this.userName,
      this.enteredDate,
      this.userType,
      this.phoneNo,
      this.userAddress,
      this.userPassword,
      this.storeName,
      this.latitude,
      this.longitude,
      this.storePhoneNo,
      this.storeVerified,
      this.storeTypeId});

  factory StoreAddModel.fromJson(Map<String, dynamic> json) => StoreAddModel(
        id: json['id'],
        userName: json['userName'],
        enteredDate: json['enteredDate'],
        userType: json['userType'],
        phoneNo: json['phoneNo'],
        userAddress: json['userAddress'],
        userPassword: json['userPassword'],
        storeName: json['storeName'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        storeTypeId: json['storeTypeId'],
        storeVerified: json['storeVerified'],
        storePhoneNo:json['storePhoneNo']
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        "enteredDate": enteredDate,
        "userType": userType,
        "phoneNo": phoneNo,
        "userAddress": userAddress,
        "userPassword": userPassword,
        "storeName": storeName,
        "latitude": latitude,
        'longitude': longitude,
        "storeTypeId": storeTypeId,
        "storeVerified": storeVerified,
        "storePhoneNo":storePhoneNo
      };
}
