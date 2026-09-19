part of "../data.dart";

extension TransactionResponseExtension on TransactionInfo {
  IconData terminalTypeIconData() {
    if (terminalType == "08") return Icons.mobile_friendly;
    if (terminalType == "03") return Icons.credit_card;
    if (terminalType == "12") return Icons.online_prediction;
    return Icons.shopping_cart;
  }

  String terminalTypeName() {
    if (terminalType == "08") return U.s.mobileBank;
    if (terminalType == "03") return U.s.posDevice;
    if (terminalType == "12") return U.s.internetPayment;
    return U.s.other;
  }

  bool isCredit() => debitType == 0;

  bool isSuccessful() => transactionStatus == 0;

  String statusName() => isSuccessful() ? U.s.successful : U.s.failed;

  String? pan() => Core.currentFile.value.panInfoList.where((PanInfo e) => e.panId == panId).firstOrDefault()?.pan;

  String receiptText() {
    final String? cardNumber = pan();
    return <String>[
      U.s.transactionReceipt,
      "${U.s.amount}: ${transactionAmount.rial()}",
      if (logDate.isNotNullOrEmpty()) "${U.s.date}: ${logDate.formatJalaliDateTime()}",
      if (merchantName.isNotNullOrEmpty()) "${U.s.merchant}: $merchantName",
      if (merchantAddress.isNotNullOrEmpty()) "${U.s.address}: $merchantAddress",
      if (cardNumber.isNotNullOrEmpty()) "${U.s.cardNumber}: $cardNumber",
      "${U.s.terminalType}: ${terminalTypeName()}",
      if (transactionType.isNotNullOrEmpty()) "${U.s.transactionType}: $transactionType",
      if (rrn.isNotNullOrEmpty()) "${U.s.referenceNumber}: $rrn",
      if (stan.isNotNullOrEmpty()) "${U.s.traceNumber}: $stan",
      if (docId.isNotNullOrEmpty()) "${U.s.documentNumber}: $docId",
      if (logMessage.isNotNullOrEmpty()) "${U.s.description}: $logMessage",
      "${U.s.status}: ${statusName()}",
    ].join("\n");
  }
}

class TransactionResponse {
  TransactionResponse({
    required this.transactionInfoList,
  });

  factory TransactionResponse.fromJson(String str) => TransactionResponse.fromMap(json.decode(str));

  factory TransactionResponse.fromMap(Map<String, dynamic> json) => TransactionResponse(
    transactionInfoList: List<TransactionInfo>.from(json["transactionInfoList"].map(TransactionInfo.fromMap)),
  );
  final List<TransactionInfo> transactionInfoList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "transactionInfoList": List<dynamic>.from(transactionInfoList.map((TransactionInfo x) => x.toMap())),
  };
}

class TransactionInfo {
  TransactionInfo({
    this.debitType,
    this.docId,
    this.fileId,
    this.logDate,
    this.logId,
    this.logMessage,
    this.merchantAddress,
    this.merchantName,
    this.rrn,
    this.stan,
    this.terminalType,
    this.transactionAmount,
    this.transactionStatus,
    this.transactionType,
    this.panId,
  });

  factory TransactionInfo.fromJson(String str) => TransactionInfo.fromMap(json.decode(str));

  factory TransactionInfo.fromMap(dynamic json) => TransactionInfo(
    debitType: json["debitType"],
    docId: json["docId"],
    fileId: json["fileId"],
    logDate: json["logDate"],
    logId: json["logId"],
    logMessage: json["logMessage"],
    merchantAddress: json["merchantAddress"],
    merchantName: json["merchantName"],
    rrn: json["rrn"],
    stan: json["stan"],
    terminalType: json["terminalType"],
    transactionAmount: json["transactionAmount"],
    transactionStatus: json["transactionStatus"],
    transactionType: json["transactionType"],
    panId: json["panId"],
  );
  final String? docId;
  final String? fileId;
  final String? logDate;
  final String? logId;
  final String? logMessage;
  final String? merchantAddress;
  final String? merchantName;
  final String? rrn;
  final String? stan;
  final String? terminalType;
  final String? transactionType;
  final int? debitType;
  final int? transactionAmount;
  final int? transactionStatus;
  final String? panId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "debitType": debitType,
    "docId": docId,
    "fileId": fileId,
    "logDate": logDate,
    "logId": logId,
    "logMessage": logMessage,
    "merchantAddress": merchantAddress,
    "merchantName": merchantName,
    "rrn": rrn,
    "stan": stan,
    "terminalType": terminalType,
    "transactionAmount": transactionAmount,
    "transactionStatus": transactionStatus,
    "transactionType": transactionType,
    "panId": panId,
  };
}
