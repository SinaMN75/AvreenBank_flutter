part of "../data.dart";

class GetAccountFunctionCodesResponse {
  GetAccountFunctionCodesResponse({
    this.functionCodeList,
  });

  factory GetAccountFunctionCodesResponse.fromJson(String str) => GetAccountFunctionCodesResponse.fromMap(json.decode(str));

  factory GetAccountFunctionCodesResponse.fromMap(dynamic json) => GetAccountFunctionCodesResponse(
    functionCodeList: json["functionCodeList"] == null ? <FunctionCodeList>[] : List<FunctionCodeList>.from(json["functionCodeList"].map(FunctionCodeList.fromMap)),
  );
  final List<FunctionCodeList>? functionCodeList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "functionCodeList": functionCodeList == null ? <dynamic>[] : List<dynamic>.from(functionCodeList!.map((FunctionCodeList x) => x.toMap())),
  };
}

class FunctionCodeList {
  FunctionCodeList({
    this.functionCode,
    this.functionName,
    this.subFunctionCodeList,
  });

  factory FunctionCodeList.fromJson(String str) => FunctionCodeList.fromMap(json.decode(str));

  factory FunctionCodeList.fromMap(dynamic json) => FunctionCodeList(
    functionCode: json["functionCode"],
    functionName: json["functionName"],
    subFunctionCodeList: json["subFunctionCodeList"] == null ? <SubFunctionCodeList>[] : List<SubFunctionCodeList>.from(json["subFunctionCodeList"].map(SubFunctionCodeList.fromMap)),
  );
  final String? functionCode;
  final String? functionName;
  final List<SubFunctionCodeList>? subFunctionCodeList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "functionCode": functionCode,
    "functionName": functionName,
    "subFunctionCodeList": subFunctionCodeList == null ? <dynamic>[] : List<dynamic>.from(subFunctionCodeList!.map((SubFunctionCodeList x) => x.toMap())),
  };
}

class SubFunctionCodeList {
  SubFunctionCodeList({
    this.subFunctionCode,
    this.subFunctionName,
  });

  factory SubFunctionCodeList.fromJson(String str) => SubFunctionCodeList.fromMap(json.decode(str));

  factory SubFunctionCodeList.fromMap(dynamic json) => SubFunctionCodeList(
    subFunctionCode: json["subFunctionCode"],
    subFunctionName: json["subFunctionName"],
  );
  final String? subFunctionCode;
  final String? subFunctionName;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "subFunctionCode": subFunctionCode,
    "subFunctionName": subFunctionName,
  };
}
