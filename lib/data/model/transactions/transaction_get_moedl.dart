class TransactionsGetModel {
  int? id;
  String? statement;
  String? enteredDate;
  double? debit;
  double? credit;
  bool? lockStatus;
  String? lockDate;
  int? invoiceId;
  int? currencyId;
  int? customerId;
  int? storeId;
  String? customerName;

  TransactionsGetModel({
    this.id,
    this.statement,
    this.enteredDate,
    this.debit,
    this.credit,
    this.lockStatus,
    this.lockDate,
    this.invoiceId,
    this.currencyId,
    this.customerId,
    this.storeId,
    this.customerName
  });

  factory TransactionsGetModel.fromJson(Map<String, dynamic> json) =>
      TransactionsGetModel(
        id: json['id'],
        statement: json['statement'],
        enteredDate: json['enteredDate'],
        debit: json['debit'].toDouble(),
        credit: json['credit'].toDouble(),
        lockStatus: json['lockStatus'],
        lockDate: json['lockDate'],
        invoiceId: json['invoiceId'],
        currencyId: json['currencyId'],
        customerId: json['customerId'],
        storeId: json['storeId'],
        customerName:json['customerName']
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'statement': statement,
        'enteredDate': enteredDate,
        'debit': debit,
        'credit': credit,
        'lockStatus': lockStatus,
        'lockDate': lockDate,
        'invoiceId': invoiceId,
        'currencyId': currencyId,
        'customerId': customerId,
        'storeId': storeId,
        'customerName':'customerName'
      };
}
