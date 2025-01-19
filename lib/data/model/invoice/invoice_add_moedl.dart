class InvoiceAddDto {
  String enteredDate;
  // String details;
  int customerId;
  int currencyId;
  int participantId;
  int storeId;
  List<InvoiceItems> invoiceItems;

  InvoiceAddDto(
      {required this.enteredDate,
      // required this.details,
      required this.customerId,
      required this.currencyId,
      required this.invoiceItems,
      required this.storeId,
      required this.participantId});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> items =
        invoiceItems.map((item) => item.toJson()).toList();
    return {
      'enteredDate': enteredDate,
      // 'details': details,
      'customerId': customerId,
      'currencyId': currencyId,
      'participantId': participantId,
      'invoiceItems': items,
      'storeId':storeId
    };
  }
}

class InvoiceItems {
  String statement;
  double unitPrice;
  int quantity;

  InvoiceItems({
    required this.statement,
    required this.unitPrice,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'statement': statement,
      'unitPrice': unitPrice,
      'quantity': quantity,
    };
  }
}
