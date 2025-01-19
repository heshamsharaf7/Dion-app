class InvoiceGetDto {
  int id;
  String statement;
  double unitPrice;
  int quantity;
  int invoiceId;
  String participantName;
  String enteredDate;
  int participantId;

  InvoiceGetDto(
      {required this.id,
      required this.statement,
      required this.unitPrice,
      required this.quantity,
      required this.invoiceId,
      required this.participantName,
      required this.participantId,
      required this.enteredDate});

  factory InvoiceGetDto.fromJson(Map<String, dynamic> json) {
    return InvoiceGetDto(
        id: json['id'],
        statement: json['statement'],
        unitPrice: double.parse(json['unitPrice'].toString()),
        quantity: json['quantity'],
        invoiceId: json['invoiceId'],
        participantName: json['participantName'] ?? "",
        participantId:json['participantId'],
        enteredDate: json['enteredDate'] ?? "");
        
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'statement': statement,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'invoiceId': invoiceId,
      'participantName': participantName,
      'enteredDate': enteredDate,
      'participantId':participantId
    };
  }
}
