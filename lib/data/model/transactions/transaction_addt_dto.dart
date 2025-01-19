class TransactionAddtDto {
  String statement;
  String enteredDate;
  double debit;
  double credit;
  int currencyId;
  int customerId;
  int storeId;

  TransactionAddtDto({
    required this.statement,
    required this.enteredDate,
    required this.debit,
    required this.credit,
    required this.currencyId,
    required this.customerId,
    required this.storeId,
  });
factory TransactionAddtDto.fromJson(Map<String, dynamic> json) => TransactionAddtDto(
        statement: json['statement'],
        enteredDate: json['enteredDate'],
        debit: json['debit'].toDouble(),
        credit: json['credit'].toDouble(),
        currencyId: json['currencyId'],
        customerId: json['customerId'],
        storeId: json['storeId'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Statement': statement,
      'EnteredDate': enteredDate,
      'Debit': debit,
      'Credit': credit,
      'CurrencyId': currencyId,
      'CustomerId': customerId,
      'StoreId': storeId,
    };
  }
}

