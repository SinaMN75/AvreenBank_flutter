part of "../data.dart";

class KalabargBalanceResponse {
  KalabargBalanceResponse({
    required this.familyCount,
    required this.balance,
  });

  factory KalabargBalanceResponse.fromJson(String str) => KalabargBalanceResponse.fromMap(json.decode(str));

  factory KalabargBalanceResponse.fromMap(dynamic json) => KalabargBalanceResponse(
    familyCount: json["familyCount"],
    balance: json["balance"],
  );

  final int? familyCount;
  final int? balance;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "familyCount": familyCount,
    "balance": balance,
  };
}
