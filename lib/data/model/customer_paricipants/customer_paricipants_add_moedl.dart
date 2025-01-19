class CustomerParticipantAddDto {
  int id;
  String name;
  String enteredDate;
  bool isActive;
  int customerId;

  CustomerParticipantAddDto({
    required this.id,
    required this.name,
    required this.enteredDate,
    required this.isActive,
    required this.customerId,
  });

  factory CustomerParticipantAddDto.fromJson(Map<String, dynamic> json) {
    return CustomerParticipantAddDto(
      id: json['id'],
      name: json['name'],
      enteredDate: json['enteredDate'],
      isActive: json['isActive'],
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'enteredDate': enteredDate,
      'isActive': isActive,
      'customerId': customerId,
    };
  }
}


