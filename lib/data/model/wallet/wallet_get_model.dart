

class WalletGetModel {
  int? id;
  String? name;
  String? enteredDate;
  String? iconPath;

  WalletGetModel({this.id, this.name, this.enteredDate, this.iconPath});

  factory WalletGetModel.fromJson(Map<String, dynamic> json) => WalletGetModel(
      id: json['id'],
      name: json['name'],
      enteredDate: json['enteredDate'],
      iconPath: json['iconPath']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        "enteredDate": enteredDate,
        "iconPath": iconPath
      };
}

