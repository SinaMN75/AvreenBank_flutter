part of "../data.dart";

extension InstallmentsStatusExtension on InstallmentsStatus {
  String statusString() {
    if (status == "N") return "پرداخت نشده";
    if (status == "P") return "پرداخت شده";
    if (status == "D") return "سررسیدشده پرداخت نشده";
    return "";
  }

  Color statusColor() {
    if (status == "N") return Colors.yellow.shade900;
    if (status == "P") return Colors.green;
    if (status == "N") return Colors.red;
    return Colors.black;
  }
}

class InquiryLoanResponse {
  InquiryLoanResponse({
    required this.loanInfoList,
  });

  factory InquiryLoanResponse.fromJson(String str) => InquiryLoanResponse.fromMap(json.decode(str));

  factory InquiryLoanResponse.fromMap(dynamic json) => InquiryLoanResponse(
    loanInfoList: List<LoanInfo>.from(json["loanInfoList"].map(LoanInfo.fromMap)),
  );
  final List<LoanInfo> loanInfoList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "loanInfoList": List<dynamic>.from(loanInfoList.map((LoanInfo x) => x.toMap())),
  };
}

class LoanInfo {
  LoanInfo({
    required this.amount,
    required this.endDate,
    required this.installmentCount,
    required this.installmentsStatus,
    required this.loanTitle,
    required this.loanType,
    required this.purchaseAmount,
    required this.notPayedAmount,
    required this.notPayedDueAmount,
    required this.payedAmount,
    required this.registerDate,
    required this.startDate,
    required this.loanId,
    required this.loanAccountId,
  });

  factory LoanInfo.fromJson(String str) => LoanInfo.fromMap(json.decode(str));

  factory LoanInfo.fromMap(dynamic json) => LoanInfo(
    amount: json["amount"],
    endDate: json["endDate"],
    loanType: json["loanType"],
    purchaseAmount: json["purchaseAmount"],
    installmentCount: json["installmentCount"],
    installmentsStatus: List<InstallmentsStatus>.from(json["installmentsStatus"].map(InstallmentsStatus.fromMap)),
    loanTitle: json["loanTitle"],
    notPayedAmount: json["notPayedAmount"],
    notPayedDueAmount: json["notPayedDueAmount"],
    payedAmount: json["payedAmount"],
    registerDate: json["registerDate"],
    startDate: json["startDate"],
    loanAccountId: json["loanAccountId"],
    loanId: json["loanId"],
  );
  final int? amount;
  final int? installmentCount;
  final int? notPayedAmount;
  final int? notPayedDueAmount;
  final int? payedAmount;
  final int? purchaseAmount;
  final int? loanType;
  final String? endDate;
  final String? loanTitle;
  final String? registerDate;
  final String? startDate;
  final String? loanId;
  final String? loanAccountId;
  final List<InstallmentsStatus>? installmentsStatus;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "amount": amount,
    "endDate": endDate,
    "loanType": loanType,
    "purchaseAmount": purchaseAmount,
    "installmentCount": installmentCount,
    "installmentsStatus": List<dynamic>.from(installmentsStatus!.map((InstallmentsStatus x) => x.toMap())),
    "loanTitle": loanTitle,
    "notPayedAmount": notPayedAmount,
    "notPayedDueAmount": notPayedDueAmount,
    "payedAmount": payedAmount,
    "registerDate": registerDate,
    "startDate": startDate,
    "loanId": loanId,
    "loanAccountId": loanAccountId,
  };
}

class InstallmentsStatus {
  InstallmentsStatus({
    required this.amount,
    required this.payAmount,
    required this.dueDate,
    required this.status,
  });

  factory InstallmentsStatus.fromJson(String str) => InstallmentsStatus.fromMap(json.decode(str));

  factory InstallmentsStatus.fromMap(dynamic json) => InstallmentsStatus(
    amount: json["amount"],
    dueDate: json["dueDate"],
    status: json["status"],
    payAmount: json["payAmount"],
  );
  final int amount;
  final String dueDate;
  final String status;
  final int payAmount;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "amount": amount,
    "dueDate": dueDate,
    "status": status,
    "payAmount": payAmount,
  };
}
