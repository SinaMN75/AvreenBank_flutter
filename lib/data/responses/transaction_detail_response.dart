part of "../data.dart";

extension TransactionDetailResponseExtension on TransactionDetailResponse {
  String receiptText() => <String>[
    U.s.transactionReceipt,
    if (transactionAmount != null) "${U.s.amount}: ${transactionAmount.rial()}",
    if (logDate.isNotNullOrEmpty()) "${U.s.date}: ${logDate.formatJalaliDateTime()}",
    if (merchantName.isNotNullOrEmpty()) "${U.s.merchant}: $merchantName",
    if (merchantAddress.isNotNullOrEmpty()) "${U.s.address}: $merchantAddress",
    if (terminalType.isNotNullOrEmpty()) "${U.s.terminalType}: ${terminalTypeName()}",
    if (debitType != null || transactionType.isNotNullOrEmpty()) "${U.s.transactionType}: ${transactionTypeName()}",
    if (rrn.isNotNullOrEmpty()) "${U.s.referenceNumber}: $rrn",
    if (stan.isNotNullOrEmpty()) "${U.s.traceNumber}: $stan",
    if (docId.isNotNullOrEmpty()) "${U.s.documentNumber}: $docId",
    if ((discountAmount ?? 0) > 0) "${U.s.discount}: ${discountAmount.rial()}",
    if (loanId.isNotNullOrEmpty()) "${U.s.loanId}: $loanId",
    ...accountTypes.map((TransactionAccount e) => "${e.accountTypeName ?? e.accountType ?? ""}: ${e.amount.rial()}"),
    if (logMessage.isNotNullOrEmpty()) "${U.s.description}: $logMessage",
    if (transactionStatus != null) "${U.s.status}: ${statusName()}",
  ].join("\n");

  String transactionTypeName() => debitType == null ? transactionType ?? "" : debitTypeName();
}

class TransactionDetailResponse with TransactionStatusMixin {
  TransactionDetailResponse({
    this.logId,
    this.fileId,
    this.docId,
    this.logMessage,
    this.transactionType,
    this.merchantName,
    this.merchantAddress,
    this.stan,
    this.discountAmount,
    this.loanId,
    this.logDate,
    this.transactionAmount,
    this.transactionStatus,
    this.rrn,
    this.terminalType,
    this.debitType,
    this.accountTypes = const <TransactionAccount>[],
  });

  factory TransactionDetailResponse.fromJson(String str) => TransactionDetailResponse.fromMap(json.decode(str));

  factory TransactionDetailResponse.fromMap(Map<String, dynamic> json) => TransactionDetailResponse(
    logId: json["logId"],
    fileId: json["fileId"],
    docId: json["docId"],
    logMessage: json["logMessage"],
    transactionType: json["transactionType"],
    merchantName: json["merchantName"],
    merchantAddress: json["merchantAddress"],
    stan: json["stan"],
    discountAmount: (json["discountAmount"] as num?)?.toInt(),
    loanId: json["loanId"],
    logDate: json["logDate"],
    transactionAmount: (json["transactionAmount"] as num?)?.toInt(),
    transactionStatus: (json["transactionStatus"] as num?)?.toInt(),
    rrn: json["rrn"],
    terminalType: json["terminalType"],
    debitType: (json["debitType"] as num?)?.toInt(),
    accountTypes: json["accountTypes"] == null ? <TransactionAccount>[] : List<TransactionAccount>.from(json["accountTypes"].map(TransactionAccount.fromMap)),
  );

  final String? logId;
  final String? fileId;
  final String? docId;
  final String? logMessage;
  final String? transactionType;
  final String? merchantName;
  final String? merchantAddress;
  final String? stan;
  final int? discountAmount;
  final String? loanId;
  final String? logDate;
  final int? transactionAmount;
  @override
  final int? transactionStatus;
  final String? rrn;
  @override
  final String? terminalType;
  @override
  final int? debitType;
  final List<TransactionAccount> accountTypes;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "logId": logId,
    "fileId": fileId,
    "docId": docId,
    "logMessage": logMessage,
    "transactionType": transactionType,
    "merchantName": merchantName,
    "merchantAddress": merchantAddress,
    "stan": stan,
    "discountAmount": discountAmount,
    "loanId": loanId,
    "logDate": logDate,
    "transactionAmount": transactionAmount,
    "transactionStatus": transactionStatus,
    "rrn": rrn,
    "terminalType": terminalType,
    "debitType": debitType,
    "accountTypes": List<dynamic>.from(accountTypes.map((TransactionAccount x) => x.toMap())),
  };
}

class TransactionAccount {
  TransactionAccount({
    this.accountType,
    this.accountTypeName,
    this.amount,
  });

  factory TransactionAccount.fromJson(String str) => TransactionAccount.fromMap(json.decode(str));

  factory TransactionAccount.fromMap(dynamic json) => TransactionAccount(
    accountType: json["accountType"],
    accountTypeName: json["accountTypeName"],
    amount: (json["amount"] as num?)?.toInt(),
  );

  final String? accountType;
  final String? accountTypeName;
  final int? amount;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountType": accountType,
    "accountTypeName": accountTypeName,
    "amount": amount,
  };
}
