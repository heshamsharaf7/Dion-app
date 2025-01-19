

class UserGetModel {
  int? id;
  String? userName;
  String? enteredDate;
  int? userType;
  int? phoneNo;
  String? userAddress;
  String? userPassword;


  UserGetModel(
      {this.id,
      this.userName,
      this.enteredDate,
      this.userType,
      this.phoneNo,
      this.userAddress,
      this.userPassword,
});

  factory UserGetModel.fromJson(Map<String, dynamic> json) => UserGetModel(
        id: json['id'],
        userName: json['userName'],
        enteredDate: json['enteredDate'],
        userType: json['userType'],
        phoneNo: json['phoneNo'],
        userAddress: json['userAddress'],
        userPassword: json['userPassword'],

      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        "enteredDate": enteredDate,
        "userType": userType,
        "phoneNo": phoneNo,
        "userAddress": userAddress,
        "userPassword": userPassword,

      };
}
