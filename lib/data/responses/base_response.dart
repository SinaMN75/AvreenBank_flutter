part of "../data.dart";

class ErrorResponse {
  ErrorResponse({
    required this.errorId,
    required this.errorCode,
    required this.errorMessage,
  });

  factory ErrorResponse.fromJson(String str) => ErrorResponse.fromMap(json.decode(str));

  factory ErrorResponse.fromMap(Map<String, dynamic> json) => ErrorResponse(
    errorId: json["errorId"],
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"] ?? json["errorCode"] ?? json["errorId"],
  );

  final String errorId;
  final String errorCode;
  final String errorMessage;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "errorId": errorId,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
  };
}