part of "../data.dart";

extension GetFileInfoResponseExtension on GetFileInfoResponse {
  AccountInfo getMainAccount({required String fileId}) {
    final AccountInfo? i = fileInfoList
        .singleWhere(
          (FileInfo e) => e.fileId == fileId,
        )
        .accountInfoList
        .firstOrNull;

    if (i == null) {
      return fileInfoList.singleWhere((FileInfo e) => e.fileId == fileId).accountInfoList.first;
    } else {
      return i;
    }
  }

  List<AccountInfo> getAllAccounts({required String fileId}) => fileInfoList
      .singleWhere(
        (FileInfo e) => e.fileId == fileId,
      )
      .accountInfoList
      .toList();

  List<AccountInfo> getAccounts({required String fileId}) => fileInfoList
      .singleWhere(
        (FileInfo e) => e.fileId == fileId,
      )
      .accountInfoList
      .toList();
}

class GetFileInfoResponse {
  GetFileInfoResponse({
    required this.firstName,
    required this.lastName,
    required this.fileInfoList,
  });

  factory GetFileInfoResponse.fromJson(String str) => GetFileInfoResponse.fromMap(json.decode(str));

  factory GetFileInfoResponse.fromMap(dynamic json) => GetFileInfoResponse(
    firstName: json["firstName"],
    lastName: json["lastName"],
    fileInfoList: json["fileInfoList"] == null ? <FileInfo>[] : List<FileInfo>.from(json["fileInfoList"].map(FileInfo.fromMap)),
  );
  final String? firstName;
  final String? lastName;
  final List<FileInfo> fileInfoList;
}

class FileInfo {
  FileInfo({
    required this.fileId,
    required this.nationalId,
    required this.personnelCode,
    required this.organizationId,
    required this.organizationName,
    required this.fileTitle,
    required this.panInfoList,
    required this.accountInfoList,
  });

  factory FileInfo.fromJson(String str) => FileInfo.fromMap(json.decode(str));

  factory FileInfo.fromMap(dynamic json) => FileInfo(
    fileId: json["fileId"],
    nationalId: json["nationalId"],
    personnelCode: json["personnelCode"],
    organizationId: json["organizationId"],
    fileTitle: json["fileTitle"],
    organizationName: json["organizationName"],
    panInfoList: List<PanInfo>.from(json["panInfoList"].map(PanInfo.fromMap)),
    accountInfoList: List<AccountInfo>.from(json["accountInfoList"].map(AccountInfo.fromMap)),
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountInfoList": accountInfoList == List<dynamic>.from(accountInfoList.map((AccountInfo x) => x.toMap())),
    "fileId": fileId,
    "fileTitle": fileTitle,
    "nationalId": nationalId,
    "organizationId": organizationId,
    "organizationName": organizationName,
    "panInfoList": panInfoList == List<dynamic>.from(panInfoList.map((PanInfo x) => x.toMap())),
    "personnelCode": personnelCode,
  };

  final String fileId;
  final String fileTitle;
  final String nationalId;
  final String personnelCode;
  final String organizationId;
  final String organizationName;
  final List<PanInfo> panInfoList;
  final List<AccountInfo> accountInfoList;
}

class AccountInfoList {
  AccountInfoList({
    required this.accountInfoList,
  });

  factory AccountInfoList.fromJson(String str) => AccountInfoList.fromMap(json.decode(str));

  factory AccountInfoList.fromMap(dynamic json) => AccountInfoList(
    accountInfoList: json["accountInfoList"] == null ? null : List<AccountInfo>.from(json["accountInfoList"].map(AccountInfo.fromMap)),
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountInfoList": accountInfoList == null ? <dynamic>[] : List<dynamic>.from(accountInfoList!.map((AccountInfo x) => x.toMap())),
  };

  final List<AccountInfo>? accountInfoList;
}

class AccountInfo {
  AccountInfo({
    this.availableBalance,
    this.accountType,
    this.accountTypeName,
    this.accountId,
    this.accountTitle,
    this.creditDebt,
    this.accountLimit,
    this.debitExpireDate,
    this.accountNature,
  });

  factory AccountInfo.fromJson(String str) => AccountInfo.fromMap(json.decode(str));

  factory AccountInfo.fromMap(dynamic json) => AccountInfo(
    accountType: json["accountType"],
    accountTypeName: json["accountTypeName"],
    accountId: json["accountId"],
    accountTitle: json["accountTitle"],
    availableBalance: json["availableBalance"],
    accountLimit: json["accountLimit"],
    creditDebt: json["creditDebt"],
    debitExpireDate: json["debitExpireDate"],
    accountNature: json["accountNature"],
  );

  final int? availableBalance;
  final int? creditDebt;
  final String? accountType;
  final String? accountTypeName;
  final String? accountId;
  final String? accountTitle;
  final int? accountLimit;
  final String? debitExpireDate;
  final String? accountNature;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountType": accountType,
    "accountTypeName": accountTypeName,
    "accountId": accountId,
    "accountTitle": accountTitle,
    "availableBalance": availableBalance,
    "accountLimit": accountLimit,
    "creditDebt": creditDebt,
    "debitExpireDate": debitExpireDate,
    "accountNature": accountNature,
  };
}

class PanInfo {
  PanInfo({
    required this.panId,
    required this.pan,
    required this.panType,
    required this.cvv2,
    required this.expiredDate,
    required this.tokenizePanInfo,
  });

  factory PanInfo.fromJson(String str) => PanInfo.fromMap(json.decode(str));

  factory PanInfo.fromMap(dynamic json) => PanInfo(
    panId: json["panId"],
    pan: json["pan"],
    panType: json["panType"],
    cvv2: json["cvv2"],
    expiredDate: json["expiredDate"],
    tokenizePanInfo: json["tokenizePanInfo"] == null ? null : TokenizePanInfo.fromMap(json["tokenizePanInfo"]),
  );
  final String panId;
  final String pan;
  final String panType;
  final String? cvv2;
  final String? expiredDate;
  final TokenizePanInfo? tokenizePanInfo;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "panId": panId,
    "pan": pan,
    "panType": panType,
    "cvv2": cvv2,
    "expiredDate": expiredDate,
  };
}

class TokenizePanInfo {
  TokenizePanInfo({
    required this.track2,
  });

  factory TokenizePanInfo.fromMap(Map<String, dynamic> json) => TokenizePanInfo(
    track2: json["track2"],
  );

  factory TokenizePanInfo.fromJson(String str) => TokenizePanInfo.fromMap(json.decode(str));
  final String? track2;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "track2": track2,
  };
}
