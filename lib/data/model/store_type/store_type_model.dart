class StoreTypeModel {
  int? id;
  String? name;
  String? enteredDate;
  String? details;
  String? iconPath;

  StoreTypeModel({
    this.id,
    this.name,
    this.enteredDate,
    this.details,
    this.iconPath
  });

  factory StoreTypeModel.fromJson(Map<String, dynamic> json) => StoreTypeModel(
        id: json['id'],
        name: json['name'],
        enteredDate: json['enteredDate'],
        details: json['details'],
        iconPath:json['iconPath']
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, "enteredDate": enteredDate, "details": details,"iconPath":iconPath};
}
