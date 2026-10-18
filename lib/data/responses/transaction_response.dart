part of "../data.dart";

extension TransactionResponseExtension on TransactionInfo {
  IconData terminalTypeIconData() {
    switch (terminalType) {
      case "01":
        return Icons.account_balance;
      case "03":
        return Icons.credit_card;
      case "43":
        return Icons.store;
      case "60":
        return Icons.phone_android;
      case "07":
        return Icons.computer;
      case "08":
        return Icons.mobile_friendly;
      case "09":
        return Icons.phone;
      case "12":
        return Icons.online_prediction;
      case "14":
        return Icons.business;
      case "16":
        return Icons.tv;
      case "23":
        return Icons.point_of_sale;
      default:
        return Icons.shopping_cart;
    }
  }

  String terminalTypeName() {
    switch (terminalType) {
      case "01":
        return U.s.atm;
      case "03":
        return U.s.posDevice;
      case "43":
        return U.s.kiosk;
      case "60":
        return U.s.mobileApp;
      case "07":
        return U.s.pc;
      case "08":
        return U.s.mobileBank;
      case "09":
        return U.s.landline;
      case "12":
        return U.s.internetPayment;
      case "14":
        return U.s.merchantSystem;
      case "16":
        return U.s.setTopBox;
      case "23":
        return U.s.mPos;
      default:
        return terminalType ?? U.s.other;
    }
  }

  bool isSuccessful() => transactionStatus == 2 || transactionStatus == 7;

  Color color() {
    switch (transactionStatus) {
      case 2:
        return Colors.yellow.shade800;
      case 7:
        return Colors.green;
      case 8:
        return Colors.orange;
      case 6:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String statusName() {
    switch (transactionStatus) {
      case 1:
        return U.s.request;
      case 2:
        return "موفق";
      case 3:
        return U.s.insufficientAmount;
      case 4:
        return U.s.accountClosed;
      case 5:
        return U.s.failed;
      case 6:
        return "برگشت سیستمی";
      case 7:
        return "تایید شده";
      case 8:
        return "برگشت ستادی";
      default:
        return U.s.other;
    }
  }

  String debitTypeName() {
    switch (debitType) {
      case 1:
        return "خرید اعتباری";
      case 2:
        return "خرید اقساطی";
      case 3:
        return "بن کارت";
      case 4:
        return "برگشت از خرید";
      case 5:
        return "لیزینگ";
      default:
        return debitType.toString();
    }
  }

  bool isRefund() => debitType == 4;
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
    this.logDate,
    this.logId,
    this.rrn,
    this.terminalType,
    this.transactionAmount,
    this.transactionStatus,
  });

  factory TransactionInfo.fromJson(String str) => TransactionInfo.fromMap(json.decode(str));

  factory TransactionInfo.fromMap(dynamic json) => TransactionInfo(
    debitType: json["debitType"],
    logDate: json["logDate"],
    logId: json["logId"],
    rrn: json["rrn"],
    terminalType: json["terminalType"],
    transactionAmount: json["transactionAmount"],
    transactionStatus: json["transactionStatus"],
  );
  final String? logId;
  final String? logDate;
  final int? transactionStatus;
  final int? transactionAmount;
  final String? rrn;
  final String? terminalType;
  final int? debitType;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "debitType": debitType,
    "logDate": logDate,
    "logId": logId,
    "rrn": rrn,
    "terminalType": terminalType,
    "transactionAmount": transactionAmount,
    "transactionStatus": transactionStatus,
  };
}
