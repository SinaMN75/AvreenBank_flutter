part of "../data.dart";

class KalabargBalanceParams {
  KalabargBalanceParams({
    required this.fileId,
  });

  factory KalabargBalanceParams.fromJson(String str) => KalabargBalanceParams.fromMap(json.decode(str));

  factory KalabargBalanceParams.fromMap(Map<String, dynamic> json) => KalabargBalanceParams(
    fileId: json["fileId"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
  };

  final String fileId;
}
