part of "../data.dart";

class GoodGroupsTransactionsParams {
  GoodGroupsTransactionsParams({
    required this.fileId,
    required this.groupId,
  });

  factory GoodGroupsTransactionsParams.fromJson(String str) => GoodGroupsTransactionsParams.fromMap(json.decode(str));

  factory GoodGroupsTransactionsParams.fromMap(Map<String, dynamic> json) => GoodGroupsTransactionsParams(
    fileId: json["fileId"],
    groupId: json["groupId"],
  );

  final String fileId;
  final String groupId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "fileId": fileId,
    "groupId": groupId,
  };
}
