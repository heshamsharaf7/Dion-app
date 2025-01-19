class StoreGetModel {
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  bool? verified;
  String? enteredDate;
  int? storeTypeId;
  int? userId;
  int? storePhoneNo;

  StoreGetModel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.verified,
    this.enteredDate,
    this.storePhoneNo,
    this.storeTypeId,
    this.userId,
  });

  factory StoreGetModel.fromJson(Map<String, dynamic> json) => StoreGetModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      verified: json['verified'],
      enteredDate: json['enteredDate'],
      storeTypeId: json['storeTypeId'],
      userId: json['userId'],
      storePhoneNo: json['storePhoneNo']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'verified': verified,
        'enteredDate': enteredDate,
        'storeTypeId': storeTypeId,
        'userId': userId,
        "storePhoneNo": storePhoneNo
      };
}
