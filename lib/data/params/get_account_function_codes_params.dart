part of "../data.dart";

class GetAccountFunctionCodesParams {
  GetAccountFunctionCodesParams({
    required this.accountId,
  });

  factory GetAccountFunctionCodesParams.fromJson(String str) => GetAccountFunctionCodesParams.fromMap(json.decode(str));

  factory GetAccountFunctionCodesParams.fromMap(Map<String, dynamic> json) => GetAccountFunctionCodesParams(
    accountId: json["accountId"],
  );
  final String accountId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "accountId": accountId,
  };
}
