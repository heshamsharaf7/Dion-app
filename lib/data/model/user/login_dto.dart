class LoginModel {
  int? userType;
  int? phoneNo;
  String? userPassword;

  LoginModel({this.userType, this.phoneNo, this.userPassword});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(
        userType: json['userType'],
        phoneNo: json['phoneNo'],
        userPassword: json['userPassword'],
      );

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "phoneNo": phoneNo,
        "userPassword": userPassword,
      };
}
