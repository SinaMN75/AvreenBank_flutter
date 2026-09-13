part of "../data.dart";

class InquiryLoanParams {
  InquiryLoanParams({
    required this.fileId,
    this.usage,
  });

  factory InquiryLoanParams.fromJson(String str) => InquiryLoanParams.fromMap(json.decode(str));

  factory InquiryLoanParams.fromMap(Map<String, dynamic> json) => InquiryLoanParams(
    fileId: json["fileId"],
    usage: json["usage"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "usage": usage,
  };

  final String fileId;
  final String? usage;
}
