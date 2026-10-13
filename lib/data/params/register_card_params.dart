part of "../data.dart";

class RegisterCardParams {
  RegisterCardParams({
    required this.fileId,
    required this.pan,
    required this.expiryDate,
    required this.cvv2,
    // required this.pin,
  });

  factory RegisterCardParams.fromJson(String str) => RegisterCardParams.fromMap(json.decode(str));

  factory RegisterCardParams.fromMap(Map<String, dynamic> json) => RegisterCardParams(
    fileId: json["fileId"],
    pan: json["pan"],
    expiryDate: json["expiryDate"],
    cvv2: json["cvv2"],
    // pin: json["pin"],
  );

  final String fileId;
  final String pan;
  final String expiryDate;
  final String cvv2;
  // final String pin;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "pan": pan,
    "expiryDate": expiryDate,
    "cvv2": cvv2,
    // "pin": pin,
  };
}
